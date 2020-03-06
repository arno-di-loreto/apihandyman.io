$(document).ready(function(){
  $('<div class="page-content-text-separator"></div>').insertBefore('.page-content-text h1')
})

$(window).scroll(function(){
  $('.navbar-home').toggleClass('scrolled', $(this).scrollTop() > $('.banner').height()-55);
  $('.navbar-page').toggleClass('scrolled', $(this).scrollTop() > 35);
});