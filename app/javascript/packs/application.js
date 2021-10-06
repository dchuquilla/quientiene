// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
//import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
//Turbolinks.start()
ActiveStorage.start()

$(document).ready(function(){
  $(".owl-carousel").owlCarousel({
    loop:true,
    margin:10,
    items:1
  });
  if ($('.alert').length > 0) {
    setTimeout(function(){
      $('.alert').fadeOut('slow');
    }, 5000)
  }

  return $("#replacement_proposal_search").on("ajax:success", function(event) {
    var data, status, xhr;
    [data, status, xhr] = event.detail;
    return $("#previous-proposals").html(xhr.responseText);
  }).on("ajax:error", function(event) {
    return $("#replacement_proposal_search").append("<p>ERROR</p>");
  });
  

});