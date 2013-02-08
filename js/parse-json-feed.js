function parseFeed(jsonData) {
    var firstPost = jsonData.responseData.feed.entries[0];
    var postTitle = firstPost.title;
    var postTime = firstPost.publishedDate;
    var postLink = firstPost.link;
    var postTimeAgo = jQuery.timeago(Date.parse(postTime));
    $('.blog-data').html('<a href="' + postLink + '">' + postTitle + '</a> <em>(' + postTimeAgo + ')</em>');
}