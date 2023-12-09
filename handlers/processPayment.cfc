component {
    property name="stripe" inject="stripe@stripecfml";

    function index(event, rc, prc) {
        prc.title = "process Payment";
        prc.welcomeMessage = "Succuess payment";
    }

    function way1(event, rc, prc) {
        if (rc.keyExists("session_id")) {
            /*
           prc.baseStripeURL = "https://api.stripe.com/v1/checkout/sessions/";
           prc.secretKey = "sk_test_51NNeI7HV9sqmfAskvN9GTcLLRXttToDFij8V0K2aJFQTlva2JCZbcTBfYEdEmKLlLnHkZb4ROHMiLYHObO3hBmr100rge9yPCv";
*/
            prc.baseStripeURL = "https://api.stripe.com/v1/checkout/sessions/#rc.session_id#";
            prc.secretKey = "sk_test_51NNeI7HV9sqmfAskvN9GTcLLRXttToDFij8V0K2aJFQTlva2JCZbcTBfYEdEmKLlLnHkZb4ROHMiLYHObO3hBmr100rge9yPCv";

            cfhttp(url=prc.baseStripeURL, result="prc.sessionRetreievalDetails", method="GET") {
                cfhttpparam (type="header" ,name="Authorization" ,value="Bearer #prc.secretKey#" );
            }
   
            if (prc.sessionRetreievalDetails.status_code == 200) {
                prc.sessionDetails = deserializeJSON(prc.sessionRetreievalDetails.fileContent);
            
                prc.payment_intent = prc.sessionDetails.payment_intent;

                prc.baseStripePaymentURL = "https://api.stripe.com/v1/payment_intents/#prc.payment_intent#";
                cfhttp(url=prc.baseStripePaymentURL, result="prc.paymentRetreievalDetails", method="GET") {
                    cfhttpparam (type="header" ,name="Authorization" ,value="Bearer #prc.secretKey#" );
                }  

                if (prc.paymentRetreievalDetails.status_code == 200) {
                    prc.paymentDetails = deserializeJSON(prc.paymentRetreievalDetails.fileContent);
                    prc.chargeID = prc.paymentDetails.latest_charge;
                    prc.baseStripeChargeURL = "https://api.stripe.com/v1/charges/#prc.chargeID#";
                    cfhttp(url=prc.baseStripeChargeURL, result="prc.chargeRetreievalDetails", method="GET") {
                        cfhttpparam (type="header" ,name="Authorization" ,value="Bearer #prc.secretKey#" );
                    }

                    if (prc.chargeRetreievalDetails.status_code == 200) {
                        prc.chargeDetails = deserializeJSON(prc.chargeRetreievalDetails.fileContent);
                    }
                } 
                   
            } 
      

           prc.welcomeMessage = "Succuess payment #rc.session_id#";
        } else {
            prc.welcomeMessage = "Invalid session";
        }

        prc.title = "process Payment way 1 " & prc.welcomeMessage;
       
    }  

    function way2(event, rc, prc) {
        if (rc.keyExists("session_id")) {
            prc.newSessionRetrieval = stripe.checkout.sessions.retrieve(
                session_id: rc.session_id
            );

            if (prc.newSessionRetrieval.status == 200) {
                prc.newPaymentInfo = stripe.paymentIntents.retrieve(
                    payment_intent_id: prc.newSessionRetrieval.content.payment_intent
                )

                if (prc.newPaymentInfo.status == 200) {
                    prc.newChargeInfo = stripe.charges.retrieve(
                        charge_id: prc.newPaymentInfo.content.latest_charge
                    )

                    writedump(prc.newChargeInfo);
                    abort;
                }

       

            }
          writedump(prc.newSessionRetrieval);
            abort;

        }
    } 

    function cancel(event, rc, prc) {
        prc.title = "payment process cancelled";
    }

    function cancel2(event, rc, prc) {
        prc.title = "payment process cancelled 2";
    }    

    function send(event, rc, prc) {
        if (rc.keyExists("qty")) {
            prc.baseStripeURL = "https://api.stripe.com/v1/checkout/sessions";
            prc.secretKey = "sk_test_51NNeI7HV9sqmfAskvN9GTcLLRXttToDFij8V0K2aJFQTlva2JCZbcTBfYEdEmKLlLnHkZb4ROHMiLYHObO3hBmr100rge9yPCv";

            cfhttp(url=prc.baseStripeURL, result="prc.sessionDetails", method="POST") {
                cfhttpparam (type="header" ,name="Authorization" ,value="Bearer #prc.secretKey#" );
                cfhttpparam (type="formfield", name="success_url", value="https://7fz9vtk6-52644.usw3.devtunnels.ms/processPayment/way1?session_id={CHECKOUT_SESSION_ID}");
                cfhttpparam (type="formfield", name="cancel_url", value="https://7fz9vtk6-52644.usw3.devtunnels.ms/processPayment/cancel");
                cfhttpparam (type="formfield", name="line_items[0][price_data][currency]", value="USD");
                cfhttpparam (type="formfield", name="line_items[0][price_data][product_data][name]", value="The Magnificent Autobiography of Monte Chan");
                cfhttpparam (type="formfield", name="line_items[0][price_data][unit_amount]", value="1995");
                cfhttpparam (type="formfield", name="line_items[0][quantity]", value="#rc.qty#");
                cfhttpparam (type="formfield", name="mode", value="payment");
            }

            if (prc.sessionDetails.status_code == 200) {
                prc.sessionDetails = deserializeJSON(prc.sessionDetails.fileContent);
                prc.session_id = prc.sessionDetails.id;
                prc.url = prc.sessionDetails.url;
            } 

            // prc.url = "/";
        } else {
            prc.url = "https://www.google.com";
        }
    } 

    function send2(event, rc, prc) {
        if (rc.keyExists("qty")) {
            prc.newSessionDetails = stripe.checkout.sessions.create(
                success_url: "https://7fz9vtk6-52644.usw3.devtunnels.ms/processPayment/way2?session_id={CHECKOUT_SESSION_ID}",
                cancel_url: "https://7fz9vtk6-52644.usw3.devtunnels.ms/processPayment/cancel2",
                mode: "payment",
                currency: "usd",
                line_items: [
                    {
                        price_data: {
                            currency: "usd",
                            product_data: {
                                name: "The Magnificent Autobiography of Monte Chan sequel"
                            },
                            unit_amount: 1995
                        },
                        quantity: rc.qty
                    }
                ]

            );
 
/*
            prc.baseStripeURL = "https://api.stripe.com/v1/checkout/sessions";
            prc.secretKey = "sk_test_51NNeI7HV9sqmfAskvN9GTcLLRXttToDFij8V0K2aJFQTlva2JCZbcTBfYEdEmKLlLnHkZb4ROHMiLYHObO3hBmr100rge9yPCv";

            cfhttp(url=prc.baseStripeURL, result="prc.sessionDetails", method="POST") {
                cfhttpparam (type="header" ,name="Authorization" ,value="Bearer #prc.secretKey#" );
                cfhttpparam (type="formfield", name="success_url", value="");
                cfhttpparam (type="formfield", name="cancel_url", value=");
                cfhttpparam (type="formfield", name="line_items[0][price_data][currency]", value="USD");
                cfhttpparam (type="formfield", name="line_items[0][price_data][product_data][name]", value="The Magnificent Autobiography of Monte Chan");
                cfhttpparam (type="formfield", name="line_items[0][price_data][unit_amount]", value="1995");
                cfhttpparam (type="formfield", name="line_items[0][quantity]", value="#rc.qty#");
                cfhttpparam (type="formfield", name="mode", value="payment");
            }
*/
            if (prc.newSessionDetails.status_code == 200) {

                prc.url = prc.newSessionDetails.content.url;
            } 

            // prc.url = "/";
        } 

    }
}