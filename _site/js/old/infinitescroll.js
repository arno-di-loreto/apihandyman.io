// adapted by Arnaud Lauret for apihandyman.io from https://blog.codestack.de/2015/05/17/seo-friendly-infinite-scroll.html
function getNextPage() {
  // #pagination is the div containing older/newer links
  var pagination = $("#pagination");
  // gets the next URL
  var url = $("#next a").attr('href');
  // removing pagination div
  pagination.remove();
  try {
    // if there's no "next" in pagination div we stop here
    if (url) {
      // list.load use http instead of https with relative url (??), so forcing a full url
      if(url.indexOf('http') != 0) {
        //console.log(document.location.href.split('://')[0]);
        //console.log(document.location.host);
        var origin = document.location.href.split('://')[0] + '://' + document.location.host;
        console.log(origin);
        url = origin + url;
        console.log(url);
      }
      // showing a spinner while downloading
      $("#main").append("<div id=\"spinner\" class=\"center\"><i class=\"fa fa-spinner fa-spin fa-2x\"></i></div>");
      // adding a temp. dom object to load the next page
      var list = $("<div></div>");
      
      // Load only #main div
      var url_id = url + " #main";
      list.load(url_id, function(response, status, xhr) {
        // check if we doesn't get any error
        // removing spinner
        $("#spinner").remove();
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
        else {
          // if there's an error we put pagination back
          console.log('got an error when getting next page');
          console.log(status);
          console.log(response);
          $("#main").append(pagination);
        }
      });
    }
  }
  // just in case of an unexpected problem like browser compatibility...
  catch(error) {
    console.log('unexpected error');
    console.log(error);
    $("#main").append(pagination);
  }
}

$(window).scroll(function() {
  // get current scroll top in px, add window height and
  // check if this is greater than the document height minus 300
  if ($(window).scrollTop() + $(window).height() >= $(document).height() - 300) {
    getNextPage();
  }
});