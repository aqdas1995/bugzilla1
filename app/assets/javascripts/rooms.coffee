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
        identity = document.getElementById('converation-title').getAttribute('data-identity')
        if identity == data['identity']
            messages = document.getElementById('messages')
            new_msg = '<div class="msg">
                            <div class="media-body">
                                <small class="pull-right time"><i class="fa fa-clock-o"></i>' + data['time'] + '</small>

                                <h5 class="media-heading">' + data['user'] + '</h5>
                                <small class="col-sm-11">' + data['message'] + '</small>
                            </div>
                        </div>'
            #messages.innerHTML += '<div class="message"><p>' + data['message'] + '</p></div>'
            existing = messages.innerHTML
            messages.innerHTML = new_msg + existing
        

    speak: (message, user, conversation) -> 
        @perform 'speak', message: message, user: user, conversation: conversation

    $(document).ready ->
        $('#Messages').toggleClass 'col-sm-12 col-sm-9' 
        main_div = document.getElementById('body')
        if main_div.className == 'container'
            main_div.className += ' fill'
        
        $('#send1').click ->
            message = document.getElementById('message')
            App.room.speak message.value
            message.value = ''
            return
        return
