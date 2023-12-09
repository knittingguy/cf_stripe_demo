<cfoutput>
#prc.title#<br/><br/>

</cfoutput>

<cfoutput>
#prc.sessionDetails.payment_intent#
</cfoutput>
<br/><br/>
<cfif prc.keyExists("chargeDetails")>

    <cfdump var="#prc.chargeDetails#">


<cfoutput>
    <a href="#prc.chargeDetails.receipt_url#" target="_blank">Payment receipt</a>

</cfoutput>
</cfif>

