component extends="coldbox.system.Interceptor"{
	function onStripeCheckoutSessionCompleted( event, interceptData={} ){
        var totalAmt = arguments.interceptData.data.object.amount_total;
        var checkout_session_id = arguments.interceptData.data.object.id;
        writeLog( text="total amt #totalAmt# -- checkout session id #checkout_session_id#", type="Information", file="stripeLog.log");
        return serializeJSON({message: 'success'});
	}
}    