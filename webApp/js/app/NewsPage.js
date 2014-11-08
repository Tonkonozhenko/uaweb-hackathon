var NewsPage = function () {

    this.init();

};

NewsPage.prototype.init = function () {

    var _ = this;

    $("#newsContainer-backButton").click(function () {

        _.close();

    });

};

NewsPage.prototype.load = function (id) {

    location.hash = "#" + id;

    //$("#newsContainer").sidebar("toggle");

    $("#newsContainer").css("left", "0");

    $.get("http://172.29.8.74:3000/news/1.json", function (data) {

        $("#newsContainer-title").text(data["news_item"].title);
        $("#newsContainer-body").html(data["news_item"].text);

    });

};

NewsPage.prototype.close = function () {

    $("#newsContainer").css("left", "100%");

};