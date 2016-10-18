//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require codemirror
//= require jquery.mousewheel-min
//= require mode/xml
//= require mode/javascript
//= require mode/css
//= require mode/htmlmixed
//= require addons/display/placeholder
//= require addons/display/fullscreen
//= require addons/fold/foldcode
//= require addons/fold/foldgutter
//= require addons/fold/brace-fold
//= require addons/fold/xml-fold
//= require addons/fold/markdown-fold
//= require addons/fold/comment-fold
//= require addons/scroll/simplescrollbars
//= require pagedown_bootstrap
//= require pagedown_init
//= require jquery_nested_form
//= require sweetalert.min
//= require Markdown.Extra
//= require highcharts.js
//= require no-data-to-display.js
//= require pages/form
//= require pages/show
//= require_self

$(document).ready(function() {
    $(".alert").fadeTo(4000, 500).slideUp(500, function(){
        $(this).alert('close');
    });
    $(".header-arrow a").on("click", function(e) {
        e.preventDefault();
        var elem = $(this).find(".hide");
        var elemClass = elem.attr("data-el");
        elem.toggleClass("hide");
        elem.siblings("." + elemClass).toggleClass("hide");
    });
    $(".switch").click(function() {
      $(".switch").toggleClass("on");
      $(".navigation").toggleClass("active");
    });
});
