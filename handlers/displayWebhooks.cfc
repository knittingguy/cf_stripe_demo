component {
    function index(event, rc, prc) {
        prc.qryWebhooks = queryExecute("SELECT * FROM stripe_webhooks ORDER BY id DESC", {}, {datasource: "testCFStuff"});
    }
}