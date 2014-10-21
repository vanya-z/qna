# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
comment = ->

  $(document).on 'click', '.edit-comment-link', (e) ->
    e.preventDefault()
    comment_id = $(this).data("commentId")
    $("#comment_body_" + comment_id).hide()
    $("#edit_comment_" + comment_id).show()
    return

  $(document).on 'click', '.cancel-edit-comment-link', (e) ->
    e.preventDefault()
    comment_id = $(this).data("commentId")
    $("#comment_body_" + comment_id).show()
    $("#edit_comment_" + comment_id).hide()
    return

$(document).ready(comment)
$(document).on('page:load', comment)