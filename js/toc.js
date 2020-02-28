/*
function synchronizeToc(scroll_position, height) {
  console.log('scroll_position', scroll_position)
  console.log('height', height)
  const percent_scroll = scroll_position/height
  console.log('scroll %', percent_scroll)

  let toc = $("#scrollable-toc")[0]
  let newTocScroll = toc.scrollHeight*percent_scroll
  console.log(newTocScroll)
  toc.scrollTop = newTocScroll
  console.log(document.activeElement)
}

window.addEventListener('scroll', function(e) {
  let body = document.body
  let html = document.documentElement
  let height = Math.max( body.scrollHeight, body.offsetHeight, 
                       html.clientHeight, html.scrollHeight, html.offsetHeight );
  synchronizeToc(window.scrollY, height)
});
*/

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

function updateTocBorder() {
  $('.left-column .above-active').each(function(index){
    $(this).removeClass('above-active')
  })
  $('.left-column .below-active').each(function(index){
    $(this).removeClass('below-active')
  })
  $("#toc .active").each(function(index){
    console.log($(this))
    let previous = $(this).prev()
    if(previous.hasClass('nav')){
      previous = previous.find('.nav-link:last-child')
    }
    if(!previous.hasClass('active')){
      previous.addClass('above-active')
    }

    let next = $(this).next()
    if(next[0] === undefined){
      next = $(this).parent().next()
    } else if(next.hasClass('nav')){
      next = next.find('.nav-link:first-child')
    }
    if(!next.hasClass('active')){
      next.addClass('below-active')
    }
  })
  const navLinks = $("#toc .nav-link")
  if($(navLinks[0]).hasClass('active')){
    $('.left-column').find('.toc-filler-top').addClass('above-active')
  }
  console.log($(navLinks[navLinks.length-1]))
  if($(navLinks[navLinks.length-1]).hasClass('active')){
    $('.left-column').find('.toc-filler-bottom').addClass('below-active')
  }
}

$(document).ready(function(){
  // Scroll TOC when needed in order to keep active element visible
  $(window).on('activate.bs.scrollspy', function () {
    updateTocBorder()
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

  $(document).on('scroll', function(){
    resetTocBorder()
  });
})