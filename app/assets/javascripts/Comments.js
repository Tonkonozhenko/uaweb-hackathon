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

        $.post("news/" + _.app.newsPage.currentID + "/comments.json", {
            "comment[text]": $("#comment-textarea").val()
        }).done(function (data) {
            data = data || {};
            console.log("COMMENT:", data);
            if (data["comment"]) {
                // todo: reload comments
            }
        });

    });

};
