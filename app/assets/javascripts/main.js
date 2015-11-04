var delay;
var editor;
var converter;

$(document).ready(function () {
    $("video").on("ended", function() {
       $(".video-overlay").show();
    });
    
    $(".rewind-video").click(function(e) {
        e.preventDefault();
        var video = $("video");
        video.currentTime = 0;
        video.get(0).play();
        $(".video-overlay").hide();
    });
    
    if (document.getElementById("code") !== null) {
      editor = CodeMirror.fromTextArea(document.getElementById("code"), {
        lineNumbers: true
      });
      
      editor.on("change", function() {
        clearTimeout(delay);
        delay = setTimeout(updatePreview, 300);
      });
      
      setTimeout(updatePreview, 300);
    }
    
    converter = new Markdown.Converter();
});

function updatePreview() {
  var previewFrame = document.getElementById('preview');
  var preview =  previewFrame.contentDocument ||  previewFrame.contentWindow.document;
  preview.open();
  preview.write(editor.getValue());
  preview.close();
}