
function loadConversation(conversation, name, user, elem) {
    $.ajax({
        type: 'POST',
        url: '/conversations/fetch_messages',
        data: { id: conversation },
        success: function (data) {
            console.log(data);
            var message_div = document.getElementById('messages');
            message_div.innerHTML = '';
            data.forEach(function (msg) {
                console.log(msg)
                message_div.innerHTML += `
                        <div class="msg">
                            <div class="media-body">
                            <small class="pull-right time"><i class="fa fa-clock-o"></i> ${msg.time} </small>

                            <h5 class="media-heading"> ${msg.sender} </h5>
                            <small class="col-sm-11"> ${msg.content} </small>
                            </div >
                        </div >`;
            });
            var title = document.getElementById('converation-title');
            title.setAttribute("data-identity", conversation);
            title.innerHTML = name;
            var send_button = document.getElementById('send');
            send_button.addEventListener('click', function () {
                var message = document.getElementById('message');
                if (message.value != '') {
                    App.room.speak(message.value, user, conversation);
                    message.value = '';
                }
            });
            selected = document.getElementById('selected');
            if(selected !=  null)
                selected.removeAttribute("id");
            elem.parentElement.parentElement.setAttribute("id", "selected");
            // Get the modal
            var modal = document.getElementById('myModal');

            // Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];

            // When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
            var btn = document.getElementById("mybtn");
            btn.addEventListener('click', function () {
                modal.style.display = "block";
                $.ajax({
                    type: 'POST',
                    url: 'fetch_user',
                    data: {id: conversation},
                    success: function (data) {
                        console.log(data);
                        var table_body = document.getElementById('table-body');
                        table_body.innerHTML = '';
                        data.forEach(function (user) {
                            table_body.innerHTML += `
                            <tr>
                                <td> ${user.name} </td>
                                <td> ${user.email} </td>
                                <td> 
                                    <button class="btn btn-primary" onclick="addToConversation('${user.id}','${conversation}')">Add</button>
                                </td>
                            </tr>`;
                        });
                    }
                });

            });        
        }
    });
}

function addToConversation(user, conversation){
    $.ajax({
        type: 'POST',
        url: 'add_to_conversation',
        data: {conversation_id: conversation, user_id: user},
        success: function (){
            location.reload();
        }
    });
}

function showAdder(){
    // Get the modal
    var modal = document.getElementById('conv-adder');
    modal.style.display = "block";

    // Get the <span> element that closes the modal
    var span = document.getElementById("close");

    // When the user clicks on <span> (x), close the modal
    span.onclick = function () {
        modal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

}

function addConversation(user){
    name = document.getElementById('conversation-name').value;
    $.ajax({
        type: 'POST',
        url: 'create',
        data: { user_id: user, name: name},
        success: function () {
            location.reload();
        }
    });
}
