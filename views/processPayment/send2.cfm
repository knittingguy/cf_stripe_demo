<cfif len(prc.errorMessage)>
    <div class="error">#prc.errorMessage#</div>
<cfelse>
    <cflocation url="#prc.url#" addtoken="false">
</cfif>






