function AssignFunc(user, bug) {
    $.ajax({
        type: 'POST',
        url: '/bugs/assign',
        data: { user_id: user, bug_id: bug, id: bug },
        success: function (fnotice) {
            location.reload();
        },
        error: function (response){
            location.reload();
        }
    });
}

function removeUser(bug_user) {
    $.ajax({
        type: 'POST',
        url: '/bugs/unassign',
        data: { bug_user_id: bug_user },
        success: function () {
            location.reload();
        },
        error: function () {
            location.reload();
        } 
    });
}

function resolveBug(bug) {
    $.ajax({
        type: 'POST',
        url: '/bugs/resolve',
        data: { id: bug },
        success: function () {
            location.reload();
        },
        error: function () {
            location.reload();
        } 
    });
}

$(document).ready(function () {
    setTimeout(function () {
        $('#notice').slideUp("slow");
    }, 4000);
})
