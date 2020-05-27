/* global $*/
$(document).on('turbolinks:load', function() {
  $('.tab-group li').click(function() {
      var index = $('.tab-group li').index(this);
      $('.tab-group li').removeClass('is-active');
      $(this).addClass('is-active');
      $('.panel').removeClass('is-show').eq(index).addClass('is-show');
  });
});