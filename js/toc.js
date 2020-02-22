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
})