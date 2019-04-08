$(document).on("turbolinks:load", function () {
  $("html, body").animate({
    scrollTop: $("#main-content").offset().top
  }, 1000);

  /** Config CKEditor */
  CKEDITOR.config.height = 650;

  /** Rreview image */
  var preview_image = function () {
    var readURL;
    $(".photo_upload").on("change", function (e) {
      return readURL(this);
    });
    return readURL = function (input) {
      var reader;
      if (input.files && input.files[0]) {
        reader = new FileReader();
      }
      reader.onload = function (e) {
        var swap;
        $(".image_to_upload").attr("src", e.target.result).removeClass("hidden");
        swap = $(".swap");
        if (swap) {
          return swap.removeClass("hidden");
        }
      };
      return reader.readAsDataURL(input.files[0]);
    };
  };
  $(document).ready(preview_image);
  $(document).on("turbolinks:load", preview_image);
});
