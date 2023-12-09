<cfoutput>
    <form action="/processPayment/send2/" method="post">
        <table>
            <tr>
                <td><b>Item:</b> </td>
                <td>The Magnificent Autobiography of Monte Chan Sequel</td>
            </tr>
            <tr>
                <td><b>Price:</b></td>
                <td>USD $19.95</td>
            </tr>
            <tr>
                <td><b>Qty:</b> </td>
                <td>
                    <select name="qty">
                        <option value="0"> -- Please select -- </option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><input type="Submit"></td>
            </tr>

        </table>
    
    </form>
</cfoutput>

