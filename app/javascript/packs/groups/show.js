$(document).ready(function(){
  $('#js-comment-icon').on('click', function(event){
    event.preventDefault();
    $('html, body').animate({
      scrollTop: $('#js-new-comment-body').offset().top
    }, 500);
  });
});