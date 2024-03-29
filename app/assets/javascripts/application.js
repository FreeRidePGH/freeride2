// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
// require_tree .
//= require jquery.ui.button
//= require jquery.ui.dialog
//= require bootstrap.min
//= require fewpicker.jquery
$(document).ready(function(){
    // hack to see if we are adding a new bike
		      if ($('#colorInput').length) {
			  $("input#colorInput").fewPicker();			  
		      }


    if ($("[data-bike-color]").length) {
	var colorSwatchDiv = $("[data-bike-color]");
	colorSwatchDiv.css("backgroundColor", colorSwatchDiv.data("bike-color"));
    }
// show the notes textarea
    $("button[data-role=toggle]").click(function(){
	$("#newCommentWrap").toggle();
    });

   $('#alerts').delay(500).fadeIn('normal', function() {
      $(this).delay(2500).fadeOut();
   });
});

function inputFocus(i){
    if(i.value==i.defaultValue){ i.value=""; i.style.color="#000"; }
}
function inputBlur(i){
    if(i.value==""){ i.value=i.defaultValue; i.style.color="#888"; }
}
