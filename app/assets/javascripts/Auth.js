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

    var makeLogin = function (login) {

        $("#menu-register").remove();
        $("#menu-login").html("<i class=\"user icon\"></i>" + login);
        $("#loginModal").modal("hide");

    };

    var loginf = function (l) {

        l = l || {};

        var login = l.login || $("#loginModal input[name=login]").val(),
            password = l.password || $("#loginModal input[name=password]").val();

        if (login && password) {

            var success = function () {
                makeLogin(login);
            };

            console.log("Login with...", {
                "user[email]": login,
                "user[password]": password
            });

            $.post("http://" + _.app.SERVER_HOSTNAME + ":" + _.app.SERVER_PORT + "/login.json", {
                "user[email]": login,
                "user[password]": password
            }).done(success);

        }

    };

    $("#menu-login").click(function () {
        $("#loginModal").modal("show");
    });

    $("#menu-register").click(function () {
        $("#registerModal").modal("show");
    });

    $.get("http://" + _.app.SERVER_HOSTNAME + ":" + _.app.SERVER_PORT + "/current_user.json",
        function (d) {
            d = d["current_user"] || {};
            if (d.email) {
                makeLogin(d.email);
            }
        });

    $("#registerModal").submit(function () {

        var login = $("#registerModal input[name=login]").val(),
            p1 = $("#registerModal input[name=password]").val(),
            p2 = $("#registerModal input[name=confirmPassword]").val();

        if (p1 !== p2) return;
        if (login === "" || p1 === "") return;

        $("#registerModal").modal("hide");

        $.post("http://" + _.app.SERVER_HOSTNAME + ":" + _.app.SERVER_PORT + "/register.json", {
            "user[email]": login,
            "user[password]": p1,
            "user[password_confirmation]": p2
        }).done(function (e) {

            if ((e || {}).user) {
                loginf({
                    login: login,
                    password: p1
                });
            }

        });

    });

    $("#loginModal").submit(loginf);

};
