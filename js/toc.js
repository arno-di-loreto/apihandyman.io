$(document).ready(function(){
  // Scroll TOC when needed in order to keep active element visible
  $(window).on('activate.bs.scrollspy', function () {
      let activeItems = $("#toc .active")
      let lastActiveItem = activeItems[activeItems.length-1]
      // DIV around the #TOC
      let toc = $(".toc")[0]
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
})