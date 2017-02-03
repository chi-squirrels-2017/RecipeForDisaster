$(document).ready(function() {
  upVote();
  downVote();
  addCommentForm();
  addComment();
});

var upVote = function() {
  $('.upvote-form').on('submit', function(e) {
    e.preventDefault();
    var $form = $(this);
    var url = $form.attr('action');
    var method = $form.attr('method');
    var data = {up_vote: 'true'};

    $.ajax({
      url: url,
      method: method,
      data: data
    })
    .done(function(response) {
      $($form.find('span.up-points')).html(response.upvotes);
    })
  })
}

var downVote = function() {
  $('.downvote-form').on('submit', function(e) {
    e.preventDefault();
    var $form = $(this);
    var url = $form.attr('action');
    var method = $form.attr('method');
    var data = {up_vote: 'false'};

    $.ajax({
      url: url,
      method: method,
      data: data
    })
    .done(function(response) {

      $($form.find('span.down-points')).html(response.downvotes);
    })
  })
}

var addCommentForm = function() {
  $('.new-comment-button').on('click', function(e) {
    e.preventDefault();
   var $button = $(this);
    var url = $button.attr('href');
    var method = "get";

    $.ajax({
      url: url,
      method: method
    })
    .done(function(response) {
      $button.after(response);
      $button.hide();
    })
  })
}

var addComment = function() {
  $('.container').on('submit', '.new-comment-form', function(e) {
    e.preventDefault();
    $form = $(this);
    url = $form.attr('action');
    method = $form.attr('method');
    data = $form.serialize();

    $.ajax({
      url: url,
      method: method,
      data: data
    })
    .done(function(response) {
      $form.hide();
      $('.new-comment-button').show();
      $('.all-comments').append('<p>' + response.comment + '</p> <p>' + response.user + '</p>');
    })
  })
}

