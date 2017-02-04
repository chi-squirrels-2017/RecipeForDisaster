$(document).ready(function() {
  upVote();
  downVote();
  showRecipeForm();
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

var showRecipeForm = function() {
  $('.new-recipe-button a').on('click', function(e) {
    e.preventDefault();

    var ajaxRequest = $.ajax({
      url: $(this).attr('href'),
      type: 'GET'
    });

    ajaxRequest.done( function(response) {
      $('#comment-header').before(response);
      $('.new-recipe-button').hide();
    });
  });

  $('.container').on('submit', '.new-recipe-form', function(e) {
    e.preventDefault();

    var ajaxSubmitRequest = $.ajax({
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      data: $(this).serialize()
    });

    ajaxSubmitRequest.done( function(response) {
      $('#new-recipe-partial').remove();
      $('.new-recipe-button').show();
      $('#recipe-end').before(response);
    });

  });

}

