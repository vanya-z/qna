# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId')
    $('#answer_body_' + answer_id).hide();
    $('form#edit_answer_' + answer_id).show()
  $('.cancel-edit-answer-link').click (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId')
    $('#answer_body_' + answer_id).show();
    $('form#edit_answer_' + answer_id).hide()
