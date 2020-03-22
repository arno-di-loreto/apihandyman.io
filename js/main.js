function offset(el) {
  var rect = el.getBoundingClientRect(),
  scrollLeft = window.pageXOffset || document.documentElement.scrollLeft,
  scrollTop = window.pageYOffset || document.documentElement.scrollTop;
  return { top: rect.top + scrollTop, left: rect.left + scrollLeft }
}

/*
$(document).ready(function(){
  $('<div class="page-content-text-separator"></div>').insertBefore('.page-content-text h1')
})
*/

$(window).scroll(function(){
  // Home page nav
  $('.navbar-home').toggleClass('scrolled', $(this).scrollTop() > $('.banner').height()-55)
  // Post nav
  //console.log('scrollTop', $(this).scrollTop())
  const titleBottom = offset($('.card-page-title .card-title')[0]).top /*+ $('.card-page-title .card-title').height()*/ - 55
  //console.log('titleBottom', titleBottom)
  $('.navbar-page-title').toggleClass('navbar-page-title-visible', $(this).scrollTop() > titleBottom);
  //$('.navbar-page').toggleClass('scrolled', $(this).scrollTop() > 35);
});

// Privacy message
$(document).ready(function(){
  showPrivacyMessage()
})

function showPrivacyMessage() {
  if(!localStorage.getItem('privacyPolicyAccepted')) {
    $('.privacy-message').toggleClass('d-none')
  }
}

function acceptPrivacyPolicy() {
  if(!localStorage.getItem('privacyPolicyAccepted')) {
    localStorage.setItem('privacyPolicyAccepted', true)
  }
  $('.privacy-message').toggleClass('d-none')
}

//Enabling tooltip everywhere
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})