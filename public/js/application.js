$(document).ready(function() {
  // upVote();
  // downVote();
  showRecipeForm();
  voteBest();
  // addCommentForm();
  // addComment();
  clickLogin();
  // submitLogin();
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

var voteBest = function(){
  $('div.container').on('submit', 'form#choose-winner', function(e){
    e.preventDefault();
    var form = $(this);
    var url = form.attr('action');
    console.log(this)
    // var data = {best_answer: true}
    $.ajax({
      url: url,
      method: 'PUT'
    })
    .done(function(response){
      $(form).before(response)
      $('form#choose-winner').addClass('hidden')
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
      $('.new-comment-button').show();
      console.log(response.user)
      console.log(response.comment)
      if (url.includes('recipes')) {
        $('.all-recipe-comments').append('<p>' + response.comment + '</p> <p>' + response.user + '</p>');
      } else {
        $('.all-comments').append('<p>' + response.comment + '</p> <p>' + response.user + '</p>');
      }
      $form.hide();
    })
  })
}

var clickLogin = function(){
  $('.login-button').on('click', function(e){
    e.preventDefault();
    var url = $(this).attr('href');

    $.ajax({
      url: url,
      method: "GET"
    })
    .done(function(){
      $('#login-partition').removeClass('hidden');
    })
  })
}

var submitLogin = function(){
  $('#login-partition').on('click', '#login-button', function(e){
    e.preventDefault();
    var form = $(this).closest('form');
    var url = $(form).attr('action');
    var method = $(form).attr('method');
    var data = $(form).serialize();

    $.ajax({
      method: method,
      url: url,
      data: data
    })
    .done(function(response){
      $('#login-partition').addClass('hidden');
      $('.main-page').html(response);
      $('.login-button').html("Welcome!");
    })
    .fail(function(response){
      $('#error-message').html(response.responseText);
    })
  })
}
