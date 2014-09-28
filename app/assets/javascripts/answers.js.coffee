# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.edit-answer-link').click (e) ->
    answer_id = $(this).data('answerId')
    $('#answer_body_' + answer_id).hide();
    $('form#edit_answer_' + answer_id).show()
    e.preventDefault();