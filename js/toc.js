
function resetTocBorder() {
  const activeItems = $('#toc .active')
  if(activeItems.length === 0){
    $('.left-column .above-active').each(function(index){
      $(this).removeClass('above-active')
    })
    $('.left-column .below-active').each(function(index){
      $(this).removeClass('below-active')
    })
  }
}

function toggleToc() {
  $('.left-column').toggleClass('left-column-shown')
}

function toggleBackToTop() {
  const titleBottom = offset($('.card-page-title .card-title')[0]).top
  $('.navbar-bottom .back-to-top').toggleClass('d-none', $(this).scrollTop() < titleBottom)
}

$(document).ready(function(){
  // Scroll TOC when needed in order to keep active element visible
  $(window).on('activate.bs.scrollspy', function () {
    let activeItems = $("#toc .active")
    let lastActiveItem = activeItems[activeItems.length-1]
    // DIV around the #TOC
    let toc = $("#scrollable-toc")[0]
    let tocScroll = toc.scrollTop
    let itemTopInsideToc = lastActiveItem.offsetTop
    let itemBottomInsideToc = lastActiveItem.offsetTop + lastActiveItem.offsetHeight
    tocVisibleTop = toc.scrollTop
    tocVisibleBottom = tocScroll + toc.offsetHeight
    if (itemTopInsideToc <= tocVisibleTop){
      delta = itemTopInsideToc - tocVisibleTop
      toc.scrollTop = toc.scrollTop + delta
    }
    if(itemBottomInsideToc >= tocVisibleBottom){
      delta = itemBottomInsideToc - tocVisibleBottom
      toc.scrollTop = toc.scrollTop + delta
    }
  })

  $('.left-column-toggler').on('click', function(){
    $('.left-column').toggleClass('left-column-shown')
  })

  $('.left-column-hider').on('click', function(){
    $('.left-column').removeClass('left-column-shown')
  })

  $('.back-to-top').on('click', function() {
    document.body.scrollTop = 0
    document.documentElement.scrollTop = 0
  })

  $(window).scroll(toggleBackToTop)
  toggleBackToTop()
})