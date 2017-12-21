# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#app/assets/javascripts/channels/room.coffee 
App.room = App.cable.subscriptions.create "RoomChannel", 
    connected: -> 
        # Called when the subscription is ready for use on the server 

    disconnected: -> 
        # Called when the subscription has been terminated by the server 

    received: (data) -> 
        messages = document.getElementById('messages')
        messages.innerHTML += '<div class="message"><p>' + data['message'] + '</p></div>'
        

    speak: (message) -> 
        @perform 'speak', message: message

    $(document).ready ->
        $('#send').click ->
            message = document.getElementById('message').value
            App.room.speak message
            return
        return
