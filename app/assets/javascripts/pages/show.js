var CAPITAN = CAPITAN || {};
CAPITAN.page = CAPITAN.page || {};
CAPITAN.page.show = CAPITAN.page.show || {};

CAPITAN.page.show.editor = {

    delay: null,
    editor: null,
    options: null,
    converter: null,
    numberAttempts: 0,
    
    init: function(options) {
        this.options = options;
        this.convertMarkdown($(".instructions"));
        this.loadCodeEditor("code");
    },
    
    convertMarkdown: function(element) {
        if (this.conveter == null) {
            this.converter = new Markdown.Converter();
            Markdown.Extra.init(this.converter);
        }
        element.html(this.converter.makeHtml(element.html()));
    },
    
    loadCodeEditor: function(elementId) {
        var me = this;
        var element = document.getElementById(elementId);
        if (element) { 
            this.editor = CodeMirror.fromTextArea(element,{
                lineNumbers: true,
                lineWrapping: true,
                scrollbarStyle: "simple",
                extraKeys: {
                  "Ctrl-Q": function(cm) { 
                    cm.foldCode(cm.getCursor()); 
                  },
                  "F11": function(cm) {
                    cm.setOption("fullScreen", !cm.getOption("fullScreen"));
                  },
                  "Esc": function(cm) {
                    if (cm.getOption("fullScreen")) cm.setOption("fullScreen", false);
                  }                    
                },
                foldGutter: true,
                gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
            });
            
            me.editor.on("change", function() {
                clearTimeout(me.delay);
                me.delay = setTimeout(me.updatePreview('preview'), 300);
            });
            
            setTimeout(me.updatePreview('preview'), 300);              
        }
    },
    
    updatePreview: function(previewFrameId) {
        var previewFrame = document.getElementById(previewFrameId);
        if (previewFrame != null) {
            var preview =  previewFrame.contentDocument ||  previewFrame.contentWindow.document;
            preview.open();
            preview.write(this.editor.getValue());
            preview.close();
        }
    },
    
    startOver: function() {
        this.editor.setValue(this.options.initial_state);
    },
    
    save: function(autoCorrector) {
      var me = this;
      if (autoCorrector) {
        if (this.isValidCode(this.editor.getValue())) {
          this.saveAnswer(true);
        } else {
          this.numberAttempts = this.numberAttempts + 1;
          if (this.numberAttempts < 3) {
            swal({
              title: "¡Ups! Parece que debes revisar tu código.",
              text: "Inténtalo de nuevo y revisa que estés colocando el texto exacto, incluyendo los signos de puntuación",
              type: "error",
              confirmButtonText: "OK",
            });
          } else {
            swal({
              title: "¿Problemas?",
              text: "Hemos notado que te estás quedando atascada con este ejercicio, mejor continua con los demás y de ahi regresas por este.",
              type: "warning",
              showCancelButton: true,   
              confirmButtonColor: "#5CB85C",   
              closeOnConfirm: false,
              confirmButtonText: "Siguiente lección",
              cancelButtonText: "Seguir intentándolo",
              closeOnConfirm: false,
              showLoaderOnConfirm: true
            },function() {
                if (this.options.next_page_url != '') {
                    window.location = me.options.next_page_url;
                } else {
                    alert("Aún no hay una siguiente página a la que saltar!");
                }

            });
          }
        }
      }  else {
        this.saveAnswer(false);
      }
    },
    
    saveAnswer: function(autoCorrector) {
      var me = this;
      var title = autoCorrector ? me.options.save_answer_title : "Grabar respuesta";
      var text = autoCorrector ? me.options.save_answer_text   : "Este tipo de pregunta no tiene evaluación automática, la pregunta se guardará para una posterior evaluación";
      var type = autoCorrector ? "success" : "info"
      swal({
        title: title,   
        text: text,   
        type: type,
        confirmButtonText: "Grabar mi respuesta",   
        closeOnConfirm: false,
        showLoaderOnConfirm: true
      },function() {
        $.post("/saveAnswer",{
          answer: me.editor.getValue(),
          page_id: me.options.page_id,
          user_id: me.options.user_id
        },function(result) {
          if (result.status == "ok") {
            swal({
              title: "Tu código se grabó con éxito",
              text: "Da click en continuar para seguir con las siguientes actividades",
              confirmButtonText: "Continuar",
              closeOnConfirm: false,
              showLoaderOnConfirm: true
            },function() {
                if (me.options.next_page_url != '') {
                    window.location = me.options.next_page_url;
                } else {
                    alert("Aún no hay una siguiente página a la que saltar!");
                }
            });
          } else {
            swal({
              title: "¡Hubo un error al intentar grabar la respuesta!",
              text: "Por favor vuelta a intentarlo.",
              type: "error",
              confirmButtonText: "OK",
              closeOnConfirm: true
            });
          }
        });
      });     
    },
    
    isValidCode: function(code) {
        var cleanCode = code.replace(/\>\s+\</g,'><').replace(/ /g,'').replace(/;/g,'').replace(/\r\n|\n/g,'').replace(/\t+/g, '');
        var solution = $("#solution").val().replace(/\>\s+\</g,'><').replace(/ /g,'').replace(/;/g,'').replace(/\r\n|\n/g,'').replace(/\t+/g, '');
        var matcher = new RegExp(solution,"g");
        return matcher.test(cleanCode);
    },
    
    checkVideoAgain: function() {
        swal({
              title: 'Repasemos la lección',
              text:  '<iframe id="videotip" width="100%" height="315" src="http://www.youtube.com/embed/'+this.options.videotip_url+'?enablejsapi=1" frameborder="0" allowfullscreen></iframe>',
              html:  '<iframe id="videotip" width="100%" height="315" src="http://www.youtube.com/embed/'+this.options.videotip_url+'?enablejsapi=1" frameborder="0" allowfullscreen></iframe>',
              confirmButtonText: 'Cerrar',
        },function() {
            $("#videotip").remove();
        });
    }
};

CAPITAN.page.show.question = {
    saveQuestion: function(page_id) {
        if ($('input[name=question-option]:checked').val() != null) {
            $.post("/saveQuestion",{
              option_id: $('input[name=question-option]:checked').val(),
              page_id: page_id,
              question_group_id: $('input[name=question-option]:checked').attr("data-question-id"),
              sequence: parseInt($("#sequence").text())
            }, function(result) {
              if (result.status == "ok") {
                if (result.sequence != "MAX") {
                  $("#sequence").text(result.sequence);
                  $(".question").hide();
                  $("div[data-question-id="+result.questionGroupId+"]").show();
                } else {
                  $(".question-span").hide();
                  $(".question-finished").show();
                }
              } else {
                alert("Hubo un error al intentar grabar la respuesta, por favor vuelta a intentarlo");
              }
            });          
        } else {
            alert("Por favor seleccione una respuesta");
        }    
    }
}

CAPITAN.page.show.video = {
    
    player: null,
    youtube_api_init: false,
    options: null,
    
    init: function(options) {
        this.options = options;
        if (!this.youtube_api_init) {
            var tag = document.createElement('script');
            tag.src = "http://www.youtube.com/iframe_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
            this.youtube_api_init = true;
        }
    },
    
    rewind: function() {
        $(".video-overlay").hide();
        this.player.seekTo(0,true);
    },
    
    onYouTubePlayerAPIReady: function() {
        this.player = new YT.Player('video-content', {
          height: '450',
          width: '800',
          videoId: this.options.videoId,
          events: {
            'onStateChange': function(event) {
              if(event.data === 0) {            
                  $(".video-overlay").show();
              }
            }
          }
        });
    }
            
}

CAPITAN.page.show.excercise = {
    converter: null,
    
    init: function(element) {
        this.converter = new Markdown.Converter();
        element.html(this.converter.makeHtml(element.html()));        
    }
}