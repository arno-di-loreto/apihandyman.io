// init Infinite Scroll
$('.paginated-elements').infiniteScroll({
    path: '.pagination__next',
    append: '.paginated-element',
    status: '.scroller-status',
    hideNav: '.nav-pagination',
});