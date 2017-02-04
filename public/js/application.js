$(document).ready(function() {
  upVote();
  downVote();
  // voteBest();
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

var voteBest = function(){
  $('section.show-recipe').on('submit', 'form#choose-winner', function(e){
    e.preventDefault();
    var form = $('form#choose-winner');
    var url = form.attr('action');
    // var data = {best_answer: true}

    $.ajax({
      url: url,
      method: 'PUT'
    })
    .done(function(response){
      $('form#choose-winner').addClass('hidden')
      $('img#winner-icon').attr('src', response)
    })
  })
}
