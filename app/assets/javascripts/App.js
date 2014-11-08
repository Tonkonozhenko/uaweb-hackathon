var App = function () {

  this.SERVER_HOSTNAME = location.hostname;
  this.SERVER_PORT = 3000;
  this.WS_PORT = 3333;

  this.newsPage = new NewsPage(this);

  this.server = new Server(this);

  this.comments = new Comments(this);

  this.auth = new Auth(this);

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

  var self = this;
  $.ajax({
    url: '/news.json',
    success: function (data) {
      data.news_items.forEach(function (news_item) {
        self.appendCard(news_item);
      });
    }
  });

//    this.appendCard({
//        id: 1,
//        title: "Breaking news",
//        text: "This is test"
//    });
//
//    this.appendCard({
//        id: 2,
//        title: "Breaking news 2",
//        text: "This is test, dasjkdh kadhj shdjk ahskjdh jasjd hakjs dhkjashjd hakjs hjka shdkj"
//    });
//
//    this.appendCard({
//        id: 3,
//        title: "You will not believe",
//        text: "Really, it is hard to believe"
//    });
//
//    this.appendCard({
//        id: 4,
//        title: "You won't really believe!",
//        text: "Too much text, too much text, too much text, too much text, too much text, " +
//            "too much text, too much text, too much text, too much text, too much text, " +
//            "too much text, too much text, too much text, too much text, too much text, " +
//            "too much text, too much text, too much text, too much text, too much text..."
//    });

};

App.prototype.currentColumn = 0;

App.prototype.appendCard = function (data) {

  var _ = this,
      d1 = $("<div></div>"),
      d2 = $("<div></div>"),
      d3 = $("<div class='card'></div>"),
      h1 = $("<h1></h1>"),
      a = $("<a href=\"#" + data.id + "\">" + data.title + "</a>"),
      img = $('<a></a>', {href: '#' + data.id}).append($('<img>', {src: data.image_url}));

  h1.append(a);
  d3.append(img);
  d3.append(h1);
  d2.append(d3);
  d1.append(d2);

  $("#newsFeedContainer").prepend(d1);

  a.on("click", function () {
    _.newsPage.load(data.id);
  });

  img.on("click", function () {
    _.newsPage.load(data.id);
  });

};