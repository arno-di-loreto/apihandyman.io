function offset(el) {
  var rect = el.getBoundingClientRect(),
  scrollLeft = window.pageXOffset || document.documentElement.scrollLeft,
  scrollTop = window.pageYOffset || document.documentElement.scrollTop;
  return { top: rect.top + scrollTop, left: rect.left + scrollLeft }
}

$(document).ready(function(){
  $('<div class="page-content-text-separator"></div>').insertBefore('.page-content-text h1')
})

$(window).scroll(function(){
  // Home page nav
  $('.navbar-home').toggleClass('scrolled', $(this).scrollTop() > $('.banner').height()-55)
  // Post nav
  //console.log('scrollTop', $(this).scrollTop())
  const titleBottom = offset($('.card-page-title .card-title')[0]).top /*+ $('.card-page-title .card-title').height()*/ - 55
  //console.log('titleBottom', titleBottom)
  $('.navbar-post-title').toggleClass('d-none', $(this).scrollTop() < titleBottom);
  //$('.navbar-page').toggleClass('scrolled', $(this).scrollTop() > 35);
});