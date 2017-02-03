$(document).ready(function() {
  upVote();
});

var upVote = function() {
  $('.vote-form').on('submit', function(e) {
    e.preventDefault();
    var $form = $(this);
    console.log($form);
    // var $form = $button.closest('form');
    var url = $form.attr('action');
    console.log(url);
    var method = $form.attr('method');
    var data = {up_vote: 'true'};

    $.ajax({
      url: url,
      method: method,
      data: data
    })
    .done(function(response) {
      console.log(response.upvotes);
      console.log($($form.find('span.up-points')));
      $($form.find('span.up-points')).html(response.upvotes);
    })
  })
}
