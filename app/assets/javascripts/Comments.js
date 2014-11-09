/**
 * @param {App} app
 * @constructor
 */
var Comments = function (app) {

    this.app = app;

    this.init();

};

Comments.prototype.init = function () {

    var _ = this;

    $("#comment-submit").click(function () {

        if (_.app.auth.IS_LOGGED) {
            $.post("news/" + _.app.newsPage.currentID + "/comments.json", {
                "comment[text]": $("#comment-textarea").val()
            }).done(function (data) {
                data = data || {};
                console.log("COMMENT:", data);
                if (data["comment"]) {
                    _.app.newsPage.updateComments();
                }
            });
        } else {
            $("#registerModal").modal("show");
        }

    });

};
