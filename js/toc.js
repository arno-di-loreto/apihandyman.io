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
    const toc = $('#toc')
    const tocScrollableParent = $('#toc')[0].parentElement
    console.log('parent scrollTop', tocScrollableParent.scrollTop)
    console.log('parent offsetTop', tocScrollableParent.offsetTop)
    const activeLevel1 = $("#toc .toc-level-1.active")
    if(activeLevel1.length > 0) {
      console.log('level 1 active', activeLevel1[0].innerText)
      console.log('level 1 active, offsetTop', activeLevel1[0].offsetTop)
      console.log('level 1 active, offsetHeight', activeLevel1[0].offsetHeight)
      const activeLevel2 = $("#toc .toc-level-2.active")
      if(activeLevel2.length > 0) {
        console.log('level 2 active', activeLevel2[0].innerText)
        console.log('level 2 active, offsetTop', activeLevel2[0].offsetTop)
        console.log('level 2 active, offsetHeight', activeLevel2[0].offsetHeight)
        const level2Top =  activeLevel2[0].offsetTop - tocScrollableParent.offsetTop;
        console.log('level 1 and level 2 active,  move to level2 top', level2Top)
        tocScrollableParent.scrollTop = level2Top
      }
      else {
        const level1Top = activeLevel1[0].offsetTop - tocScrollableParent.offsetTop;
        console.log('only level 1 active, move to', level1Top)
        // Move level 1 to top
        tocScrollableParent.scrollTop = level1Top
      }
      console.log('parent updated scrollTop', tocScrollableParent.scrollTop)
    }

    /*
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
    */
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