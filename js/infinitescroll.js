// adapted by Arnaud Lauret for apihandyman.io from https://blog.codestack.de/2015/05/17/seo-friendly-infinite-scroll.html
function getNextPage() {
  // #pagination is the div containing older/newer links
  var pagination = $("#pagination");
  // gets the next URL
  var url = $("#next a").attr('href');
  // hiding pagination div
  pagination.remove();
  if (url) {
    // adding a temp. dom object to load the next page
    var list = $("<div></div>");
    list.load(url + " #main", function(response, status, xhr) {
      // check if we doesn't get any error
      if ( status != "error" ) {
        // copy all childrens of our temp container to the real container
        // note: jQuery load will copy the #main node as well,
        // so use the childrens and move them
        var container = $("#main");
        list.children("#main").children().each(
          function(key, value){
            container.append(value);
          }
        );
      }
    });
  }
}

$(window).scroll(function() {
  // get current scroll top in px, add window height and
  // check if this is greater than the document height minus 300
  if ($(window).scrollTop() + $(window).height() >= $(document).height() - 300) {
    getNextPage();
  }
});