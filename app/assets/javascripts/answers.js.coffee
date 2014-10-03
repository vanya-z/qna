# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->

  $(document).on 'click', '.edit-answer-link', (e) ->
    e.preventDefault()
    answer_id = $(this).data("answerId")
    $("#answer_body_" + answer_id).hide()
    $("form#edit_answer_" + answer_id).show()
    return

  $(document).on 'click', '.cancel-edit-answer-link', (e) ->
    e.preventDefault()
    answer_id = $(this).data("answerId")
    $("#answer_body_" + answer_id).show()
    $("form#edit_answer_" + answer_id).hide()
    return

$(document).ready(ready)
$(document).on('page:load', ready)