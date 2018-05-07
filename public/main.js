$(function () {
  'use strict'

  $('[data-toggle="offcanvas"]').on('click', function () {
    $('.offcanvas-collapse').toggleClass('open')
  })
})

$(".nav .nav-link").on("click", function(){
  $(".nav").find(".active").removeClass("active");
  $(this).addClass("active");
});