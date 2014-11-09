/**
 * Main entry point for NGNews application.
 *
 * @constructor
 */
var App = function () {

    this.SERVER_HOSTNAME = location.hostname;
    this.SERVER_PORT = 3000;
    this.WS_PORT = 3333;

    this.newsPage = new NewsPage(this);

    this.server = new Server(this);

    this.comments = new Comments(this);

    this.auth = new Auth(this);

    this.sidebar = new Sidebar(this);

    this.init();

};

App.prototype.init = function () {

    $("#newsContainer").sidebar({
        transition: "push"
    }); //.sidebar("attach events", "#test");

    $(window).resize(function () {

    });

    $("#menuButton").click(function () {
        $("#menu").sidebar("toggle");
    });

    this.setMainNews();

};

/**
 * @param {number} cat
 */
App.prototype.setMainNews = function (cat) {

    var category,
        urlP = "";

    if (!isNaN(category = cat || parseInt(location.hash.slice(10)))) { // category-
        urlP = "?by_category[]=" + category;
    }

    var self = this;

    $("#newsFeedContainer").empty();

    $.ajax({
        url: '/news.json' + urlP,
        success: function(data) {
            data.news_items.forEach(function(news_item) {
                self.appendCard(news_item);
            });
        }
    });

};

App.prototype.appendCard = function (data) {

    var _ = this,
        d1 = $("<div></div>"),
        d2 = $("<div></div>"),
        d3 = $("<div class='card'></div>"),
        h1 = $("<h1></h1>"),
        rating = $('<div class="rating"><div class="ui striped progress" style="height: 28px;"><div class="bar" style="background: green; width: ' + (data.rating*100) + '%">' +
            '</div><div class="bar" style="background: red; width: ' + (100 - data.rating*100) + '%">' +
            '</div></div></div>'),
        a =  $("<a href=\"#" + data.id + "\">" + data.title + "</a>"),
        img = $('<img>', {src: data.image_url}),
        divider = $("<div class='ui divider'></div>");
//        p = $("<p>" + data.text + "</p>");

    rating.css("display", "none");
    h1.append(a);
    d3.append(img);
    d3.append(h1);
    if (data.rating !== 0.0) d3.append(rating);
    d3.append(divider);
//    d3.append(divider);
//    d3.append(p);
    d2.append(d3);
    d1.append(d2);

    $("#newsFeedContainer").prepend(d1);

    a.on("click", function () {

        _.newsPage.load(data.id);

    });

};