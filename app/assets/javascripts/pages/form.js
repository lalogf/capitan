var CAPITAN = CAPITAN || {};
CAPITAN.page = {};

CAPITAN.page.form = {
    
    converter: null,
    editor_names: ["page_html","page_initial_state","page_solution"],
    editor: null,
    sections: ["video_fields","editor_fields","questions_fields","html_fields","slide_fields","exercise_fields"],
    
    showFields: function(sectionToShow) {
      $.each(this.sections,function(index,section) {
        $("."+section).hide();
      });
      $("."+sectionToShow).show();
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
        me.page_type_change($(this).val());
      });
      
      $.each(this.editor_names,function(index, editor_name) {
          me.loadEditor(editor_name,{
              lineWrapping: true,
              lineNumbers: true
          });
      });
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
            case 'closer':
            case 'opener':
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
}