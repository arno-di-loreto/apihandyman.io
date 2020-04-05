function offset(el) {
  var rect = el.getBoundingClientRect(),
  scrollLeft = window.pageXOffset || document.documentElement.scrollLeft,
  scrollTop = window.pageYOffset || document.documentElement.scrollTop;
  return { top: rect.top + scrollTop, left: rect.left + scrollLeft }
}

$(window).scroll(function(){
  if($('.row-banner').length > 0) {
    $('.main-navbar').toggleClass('scrolled', $(this).scrollTop() > $('.row-banner').height()-55)
  }
  console.log('nav fixed bottom', $('.nav-fixed-bottom'))
  const navTop = offset($('.nav-fixed-bottom')[0]).top
  const contentBottom = $('.main-content').height() + offset($('.main-content')[0]).top
  console.log('main content bottom', contentBottom)
  console.log('nav top', navTop)
  console.log('nav below content', navTop > contentBottom)
  
  //$('.nav-fixed-bottom').toggleClass('fixed-bottom', navTop > contentBottom) 
});

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
  $("[data-toggle='tooltip']").click(function(){
    $("[data-toggle='tooltip']").tooltip('hide');
  });
})

$( document ).ready(function() {

  showPrivacyMessage()

  const clipboardTextCopy = new ClipboardJS('.text-copy', {
    target: function(trigger) {
      return trigger
    }
  })

  clipboardTextCopy.on('success', function(e) {
    console.log('copied from ', e)
  });

  clipboardTextCopy.on('error', function(e) {
    console.error('🙇🏻‍♂️ something unexpectedly went wrong while copying with ClipboardJS 🙇🏻‍♂️')
    console.error('Action:', e.action)
    console.error('Trigger:', e.trigger)
  })
})