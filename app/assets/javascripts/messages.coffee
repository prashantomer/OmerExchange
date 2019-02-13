# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('form#new_message').on 'submit', (event) ->
    App.public_messages.speak $('#message_message').val()
    event.preventDefault()
    $(this).trigger("reset")
    return
