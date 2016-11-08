// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  tinyMCE.init({
    selector: 'textarea.editor',
    height: 550,
    plugins: [
        "advlist autolink lists link charmap print preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime nonbreaking save table contextmenu directionality",
        "emoticons template paste textcolor colorpicker textpattern"
    ],

    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link",
    toolbar2: "fullscreen | forecolor backcolor | fontselect | fontsizeselect",
  });
});
