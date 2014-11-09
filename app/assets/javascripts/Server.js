/**
 * @param {App} app
 * @constructor
 */
var Server = function (app) {

    this.ADDRESS = "ws://" + app.SERVER_HOSTNAME + ":" + app.WS_PORT;

    /**
     * @type {App}
     */
    this.app = app;

    this.ws = null;

    this.init();

};

Server.prototype.init = function () {

    var _ = this;

    this.ws = new WebSocket(this.ADDRESS);

    this.ws.onopen = function () {
        console.info("WebSocket connection opened.");
    };

    this.ws.onclose = function () {
        console.info("WebSocket connection closed.");
    };

    this.ws.onerror = function (e) {
        console.info("WebSocket connection error:", e);
    };

    this.ws.onmessage = function (e) {
        try {
            _.onData.call(_, JSON.parse(e.data).news_item);
        } catch (e) { console.error("Unable to retrieve data from server.", e); }
    };

};

Server.prototype.onData = function (data) {

    this.app.appendCard(data);

};