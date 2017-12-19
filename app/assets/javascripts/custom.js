function AssignFunc(user, bug, project) {
    $.ajax({
        type: 'POST',
        url: '/bugs/assign',
        data: { user_id: user, bug_id: bug, project_id: project },
        success: function () {
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
        }
    });
}