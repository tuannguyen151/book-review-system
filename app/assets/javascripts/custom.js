$(document).on("turbolinks:load", function () {
  if ($("#main-content").length != 0) {
    $("html, body").delay(1000).animate({
      scrollTop: $("#main-content").offset().top
    }, 500);
  }

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

  /** DataTables purchase requests */
  $("#table-purchase-request").css("width", "100%");
  $("#table-purchase-request").DataTable({
    "scrollX": true,
    "language": {
      "lengthMenu": I18n.t("js.purchase_requests.l11") + " _MENU_ " +
        I18n.t("js.purchase_requests.l12"),
      "zeroRecords": I18n.t("js.purchase_requests.l2"),
      "info": I18n.t("js.purchase_requests.l31") + "_PAGE_ " +
        I18n.t("js.purchase_requests.l32") + " _PAGES_",
      "infoEmpty": I18n.t("js.purchase_requests.l4"),
      "infoFiltered": "(" + I18n.t("js.purchase_requests.l51") + " _MAX_ " +
        I18n.t("js.purchase_requests.l52") + ")",
      "search": I18n.t("js.purchase_requests.l6"),
      "paginate": {
        "first": I18n.t("js.purchase_requests.l7"),
        "last": I18n.t("js.purchase_requests.l8"),
        "next": I18n.t("js.purchase_requests.l9"),
        "previous": I18n.t("js.purchase_requests.l10")
      },
    },
  });
  $('.review-rating').raty({
    readOnly: true,
    score: function () {
      return $(this).attr('data-score');
    },
    path: '/assets/'
  });

  $('#rating-form').raty({
    path: '/assets/',
    scoreName: 'review[rate]'
  });

  $('.average-review-rating').raty({
    readOnly: true,
    path: '/assets/',
    score: function () {
      return $(this).attr('data-score')
    }
  });
  $(document).on("click", "#my-link", function (e) {
    $("#myDIV").css("display", "block");
    e.preventDefault();
  });

  $("#table-favorites").css("width", "100%");
  $("#table-favorites").DataTable({
    "scrollX": true,
    "language": {
      "lengthMenu": I18n.t("js.purchase_requests.l11") + " _MENU_ " +
        I18n.t("js.favorites.l12"),
      "zeroRecords": I18n.t("js.purchase_requests.l2"),
      "info": I18n.t("js.purchase_requests.l31") + "_PAGE_ " +
        I18n.t("js.purchase_requests.l32") + " _PAGES_",
      "infoEmpty": I18n.t("js.favorites.l4"),
      "infoFiltered": "(" + I18n.t("js.purchase_requests.l51") + " _MAX_ " +
        I18n.t("js.favorites.l52") + ")",
      "search": I18n.t("js.purchase_requests.l6"),
      "paginate": {
        "first": I18n.t("js.purchase_requests.l7"),
        "last": I18n.t("js.purchase_requests.l8"),
        "next": I18n.t("js.purchase_requests.l9"),
        "previous": I18n.t("js.purchase_requests.l10")
      },
    },
  });

  $("#table-readed-books").css("width", "100%");
  $("#table-readed-books").DataTable({
    "scrollX": true,
    "language": {
      "lengthMenu": I18n.t("js.purchase_requests.l11") + " _MENU_ " +
        I18n.t("js.readed_books.l12"),
      "zeroRecords": I18n.t("js.purchase_requests.l2"),
      "info": I18n.t("js.purchase_requests.l31") + "_PAGE_ " +
        I18n.t("js.purchase_requests.l32") + " _PAGES_",
      "infoEmpty": I18n.t("js.readed_books.l4"),
      "infoFiltered": "(" + I18n.t("js.purchase_requests.l51") + " _MAX_ " +
        I18n.t("js.readed_books.l52") + ")",
      "search": I18n.t("js.purchase_requests.l6"),
      "paginate": {
        "first": I18n.t("js.purchase_requests.l7"),
        "last": I18n.t("js.purchase_requests.l8"),
        "next": I18n.t("js.purchase_requests.l9"),
        "previous": I18n.t("js.purchase_requests.l10")
      },
    },
  });

  $("#table-reading-books").css("width", "100%");
  $("#table-reading-books").DataTable({
    "scrollX": true,
    "language": {
      "lengthMenu": I18n.t("js.purchase_requests.l11") + " _MENU_ " +
        I18n.t("js.reading_books.l12"),
      "zeroRecords": I18n.t("js.purchase_requests.l2"),
      "info": I18n.t("js.purchase_requests.l31") + "_PAGE_ " +
        I18n.t("js.purchase_requests.l32") + " _PAGES_",
      "infoEmpty": I18n.t("js.reading_books.l4"),
      "infoFiltered": "(" + I18n.t("js.purchase_requests.l51") + " _MAX_ " +
        I18n.t("js.reading_books.l52") + ")",
      "search": I18n.t("js.purchase_requests.l6"),
      "paginate": {
        "first": I18n.t("js.purchase_requests.l7"),
        "last": I18n.t("js.purchase_requests.l8"),
        "next": I18n.t("js.purchase_requests.l9"),
        "previous": I18n.t("js.purchase_requests.l10")
      },
    },
  });

  $(".following-search-form").on("keyup", function () {
    var user_id = $(this).data("user-id");
    $.getScript("/users/" + user_id + "/following?name=" + this.value);
  });

  $(".followers-search-form").on("keyup", function () {
    var user_id = $(this).data("user-id");
    $.getScript("/users/" + user_id + "/followers?name=" + this.value);
  });

  $("#content-search").on("keyup", function () {
    $.getScript("/user_book_searches?q=" + this.value);
  });

});
