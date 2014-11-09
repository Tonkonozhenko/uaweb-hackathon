/**
 * @param {App} app
 * @constructor
 */
var Sidebar = function (app) {

    this.app = app;

    this.init();

};

Sidebar.prototype.init = function () {

    var _ = this;

    $(".news-categories").click(function () {

        var c = parseInt($(this).attr("href").split("-")[1]);

        _.app.setMainNews(c);

    });

    $.get() //sidebar-categories

};