// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.easing
//= require twitter/bootstrap
//= require freelancer
//= require jqBootstrapValidation
//= require jquery.magnific-popup
//= require contact_me
//= require forms_validations
//= require turbolinks
//= require_tree .

function AssignFunc(user, bug, project) {
    $.ajax({
        type: 'POST',
        url: '/bugs/assign',
        data: { user_id: user, bug_id: bug, project_id: project},
        success: function(){
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

function resolveBug(bug){
    $.ajax({
        type: 'POST',
        url: '/bugs/resolve',
        data: { id: bug },
        success: function(){
            location.reload();
        }
    });
}
