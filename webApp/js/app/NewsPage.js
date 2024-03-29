/**
 * @param {App} app
 * @constructor
 */
var NewsPage = function (app) {

    /**
     * @type {App}
     */
    this.app = app;

    this.currentID = 0;

    this.init();

};

NewsPage.prototype.init = function () {

    var _ = this,
        newsID;

    $("#newsContainer-backButton").click(function () {

        _.close();

    });

    $("#newsContainer-believeButton").click(function () {

        $.post("http://" + _.app.SERVER_HOSTNAME + ":" + _.app.SERVER_PORT + "/news/" + _.currentID + "/like",
            function () {
            console.log("Sent believe.");
        });

    });

    $("#newsContainer-notBelieveButton").click(function () {

        $.post("news/" + _.currentID + "/dislike", function () {
            console.log("Sent not believe.");
        });

    });

    if (!isNaN(parseInt(newsID = location.hash.slice(1)))) {
        this.load(newsID);
    }

};

NewsPage.prototype.load = function (id) {

    location.hash = "#" + id;

    //$("#newsContainer").sidebar("toggle");

    $("#newsContainer").css("left", "0");

    $.get("http://" + this.app.SERVER_HOSTNAME + ":" + this.app.SERVER_PORT
        + "/news/1.json", function (data) {

        data = data["news_item"];

        $("#newsContainer-title").text(data["title"]);
        $("#newsContainer-body").html(data["text"]);

        if (data["liked"]) {
            $("#newsContainer-believeButtons .negative").addClass("disabled").disable();
        }

        if (data["disliked"]) {
            $("#newsContainer-believeButtons .positive").addClass("disabled").disable();
        }

    });

};

NewsPage.prototype.close = function () {

    $("#newsContainer").css("left", "100%");
    location.hash = "";

};