<cfoutput>
#prc.title# 2<br/><br/>

</cfoutput>

<cfoutput>
#prc.newSessionRetrieval.content.payment_intent#
</cfoutput>
<br/><br/>
<cfif prc.keyExists("newChargeInfo")>

    <cfdump var="#prc.newChargeInfo#">


<cfoutput>
    <a href="#prc.newChargeInfo.content.receipt_url#" target="_blank">Payment receipt</a>

</cfoutput>
</cfif>