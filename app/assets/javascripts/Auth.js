/**
 * @param {App} app
 * @constructor
 */
var Auth = function (app) {

    this.app = app;

    this.init();

};

Auth.prototype.init = function () {

    var _ = this;

    $("#button-login").click(function () {
        $("#loginModal").modal("show");
    });

    $("#loginModal").submit(function () {

        var login = $("#loginModal input[name=login]").val(),
            password = $("#loginModal input[name=password]").val();

        if (login && password) {

            var success = function (data) {

                console.log(data);

            };

            $.ajax({
                type: "POST",
                url: "http://" + _.app.SERVER_HOSTNAME + ":" + _.app.SERVER_PORT + "/login",
                data: {
                    "user[email]": login,
                    "user[password]": password
                },
                success: success,
                dataType: "text/json"
            });

        }

    });

};