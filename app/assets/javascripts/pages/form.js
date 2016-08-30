var CAPITAN = CAPITAN || {};
CAPITAN.page = CAPITAN.page || {};

CAPITAN.page.form = {
    
    converter: null,
    editor_names: ["page_html","page_initial_state","page_solution"],
    editor: null,
    sections: ["video_fields","editor_fields","questions_fields","html_fields","slide_fields","exercise_fields"],
    
    showFields: function(pageType) {
        this.manageFields('page', pageType);
    },
    
    showMaterialFields: function(materialType) {
        this.manageFields('material', materialType);
    },
    
    manageFields: function(level, type) {
        var $pageActive = $("div[data-" + level + "-active='true']");
        $pageActive.addClass("hidden");
        $pageActive.removeProp("data-" + level + "-active");
        var $currentPage = $("div[data-" + level + "-type*='" + type + "']");
        $currentPage.attr("data-" + level + "-active", 'true');
        $currentPage.removeClass("hidden"); 
    },
    
    loadEditor: function(elementId,options) {
        var element = document.getElementById(elementId);
        if (element) {
            this.editor = CodeMirror.fromTextArea(element,options);
        }
    },
    
    init: function() {
      var me = this;
      $("#page_page_type").change(function() {
          me.showFields($(this).val());
      });
      
      $("#page_material_type").change(function() {
          me.showMaterialFields($(this).val());
      })
      
      $.each(this.editor_names,function(index, editor_name) {
          me.loadEditor(editor_name,{
              lineWrapping: true,
              lineNumbers: true
          });
      });
      
    //   var solution_visibility = $("#page_solution_visibility").val().split(",");
    //   if (solution_visibility.length !== 0) {
    //       $.each(solution_visibility, function(index, element) {
    //           if (element !== "") {
    //             var input = $(".checkbox-inline input[value="+element+"]");
    //             if (input !== null) { input.prop("checked",true); }
    //           }
    //       });
    //   }
      
    //   $(".page-submit-form").click(function(e) {
    //       var visibility = [];
    //       $(".checkbox-inline input").each(function(index,element) {
    //           if ($(element).is(':checked')) {
    //               visibility.push($(element).val());
    //           } else {
    //               visibility.push(0);
    //           }
    //       });
    //       $("#page_solution_visibility").val(visibility.join(","));
    //   });
    },
    
    page_type_change: function(page_type) {
        switch (page_type) {
            case 'video':
                this.showFields("video_fields");
                break;
            case 'editor':
                this.showFields("editor_fields");
                break;
            case 'questions':
                this.showFields("questions_fields");
                break;
            case 'html':    
                this.showFields("html_fields");
                break;
            case 'slides':
                this.showFields("slide_fields");
                break;
            case 'exercise':
                this.showFields("exercise_fields");
                break;                
        }    
    }
};