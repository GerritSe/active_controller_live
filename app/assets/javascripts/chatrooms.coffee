# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

chatroom = ->
  unless $('#chatroom').length > 0
    return

  scrollToBottom = ->
    messages = $('.messages')
    messages.scrollTop(messages[0].scrollHeight)

  # scroll to bottom of chat window on page load
  scrollToBottom()

  source = new EventSource('/messages/events')
  source.addEventListener 'message', (e) ->
    message = $.parseJSON(e.data)
    $('.messages').append($('<div>').text(message.user + ': ' + message.message))
    scrollToBottom()

  chatroomId = $('#message_chatroom_id').val()

  $('form').submit (e) ->
    e.preventDefault()
    url = $(this).attr('action')
    $.post url,
      chatroom_id: chatroomId
      user: $('#message_user').val()
      message: $('#message_message').val()
    , null
    , 'json'
    .done (data) ->
      if data['status']
        $('#message_message').val('')
      else
        $('#message_message').flash(2, 'error')
    .fail ->
      $('#message_message').flash(2, 'error')

$(document).ready(chatroom)
$(document).on('page:load', chatroom) # turbolinks
