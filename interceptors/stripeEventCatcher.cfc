component extends="coldbox.system.Interceptor"{
	function onStripeCheckoutSessionCompleted( event, interceptData={} ){
        var totalAmt = arguments.interceptData.data.object.amount_total;
        var checkout_session_id = arguments.interceptData.data.object.id;

        queryExecute("
            INSERT INTO stripe_webhooks (webhook_data, amount_total, checkout_session_id)
            VALUES (:webhookdata, :totalAmt, :checkout_session_id)
        ", {
            webhookdata: { value= serializeJSON(arguments.interceptData.data), cfsqltype="cf_sql_text"},
            totalAmt: { value=totalAmt, cfsqltype="cf_sql_integer"},
            checkout_session_id: {value = checkout_session_id, cfsqltype="cf_sql_varchar"}
        }, {datasource="testCFStuff"});
        // writeLog( text="total amt #totalAmt# -- checkout session id #checkout_session_id#", type="Information", file="stripeLog.log");
        return serializeJSON({message: 'success'});
	}
}    