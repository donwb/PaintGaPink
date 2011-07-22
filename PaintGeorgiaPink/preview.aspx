<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="preview.aspx.cs" Inherits="PaintGeorgiaPink.preview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Preview your card</title>

    <script type="text/javascript" src="scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="scripts/jquery.jqURL.js"></script>
    <script type="text/javascript" src="scripts/jquery.field.min.js"></script>

    <script type="text/javascript">
        var cardToLoad = "none";
        var firstPass = true;
        var cardFlipCount = 1; // valid values are 1,2,3
        var intervalId;
        var currentCardId;

        $(document).ready(function () {
            currentCardId = $.jqURL.get("CardId");

            $("#card").hide();
            $("#cardImage").hide();
            $("#addressInfo").hide();
            $("#saveSuccessful").hide();
            $("#googleButton").hide();

            //$("input[name='productTitle']").setValue("test");
            $("#pTitle").attr("value", "Paint Georgia Pink Card #" + $.jqURL.get("CardId"));

            intervalId = window.setInterval(flipCard, 14000);
            getCardData();

            $("#saveUserInfo").click(function () {

                if (validateForm()) {

                    var data = { CardId: currentCardId, Name: $("input[name='recipient_name']").getValue(),
                        Address1: $("input[name='address1']").getValue(), Address2: $("input[name='address2']").getValue(),
                        City: $("input[name='city']").getValue(), State: $("input[name='state']").getValue(),
                        Zip: $("input[name='zipcode']").getValue()
                    };

                    var data = JSON.stringify(data);

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "PgpCardService.svc/CardShippingInfoes",
                        data: data,
                        dataType: "json",
                        success: resultCallback,
                        error: failCallback

                    });
                } else {
                    alert("There are errors on the form.. please fix");
                }
            });

        });
            
        function validateForm() {
            var stateOk = (($("input[name='state'").getValue().length) == 2);
            var zip = $("input[name='zipcode'").getValue();
            var zipOk = (!(isNaN(zip))) && (zip.length == 5);
            alert(zip + ' and ' + zipOk);

            return (zipOk && stateOk);

        }

        function resultCallback(){
            alert("Saved!");
            $("#saveSuccessful").show();
        }

        function failCallback(XMLHttpRequest, textStatus, errorThrown) {
            alert("Save failed!" + XMLHttpRequest);
        }

        function hideSavedIcon() {
            $("#saveSuccessful").hide();
        }


        function getCardData() {
            var id = $.jqURL.get('CardId');

            var url = "PgpCardService.svc/Cards(" + id + ")?$expand=CardStyle";

            $.ajax({
                type: "GET",
                url: url,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    loadCard(msg.d);
                }
            });

        }

        function loadCard(cardData) {
            $("#greeting").html(cardData.Greeting);
            $("#friend").html(cardData.RecipientName);
            $("#message").html(cardData.Message);
            $("#from").html("From: " + cardData.SenderName);
            $("#fromEmail").html(cardData.SenderEmail);
            $("#toEmail").html("To: " + cardData.RecipientEmail);
            $("#previewCard").attr("src", "images/" + cardData.CardStyleId);
            cardToLoad = "images/e" + cardData.CardStyleId + ".jpg";
            $("#pImage").val("images/e" + cardData.CardStyleId + ".jpg");
            $("#greetingCardText").html(cardData.CardStyle.CardName);
        }

        function flipCard() {

            switch (cardFlipCount) {
                case 1:
                    $("#previewCard").attr("src", cardToLoad);
                    $("#player").hide();
                    $("#cardImage").show();
                    
                    window.clearInterval(intervalId);
                    intervalId = window.setInterval(flipCard, 3000);
                    cardFlipCount++
                    break;
                case 2:
                    $("#cardImage").hide();
                    $("#card").show();

                    window.clearInterval(intervalId);
                    window.setInterval(flipCard, 3000);
                    cardFlipCount++;
                    break;
                case 3:
                    $("#cardImage").show();
                    $("#card").hide();
            }
            
        }

        function purchaseChange() {
            var opt = document.getElementById('purchaseOptions').value;

            switch (opt) {
                case "free":
                    $("#sendCard").show();
                    $("#googleButton").hide();
                    $("#addressInfo").hide();
                    break
                case "e-card":
                    $("#sendCard").hide();
                    $("#googleButton").show();
                    $("#addressInfo").hide();
                    break
                case "physicalCard":
                    $("#sendCard").hide();
                    $("#googleButton").show();
                    $("#addressInfo").show();
                    break
            }

            
        }

        

    </script>
    
    <link href="css/preview.css" rel="stylesheet" type="text/css" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    

   <div class="container">
       <div class="image" id="player">
       <object type="application/x-shockwave-flash" width="500" height="300" wmode="transparent" data="ecard1.swf?file=video.flv&autoStart=true">
            <param name="movie" value="ecard1.swf?file=video.flv&autoStart=true"/>
            <param name="wmode" value="transparent"/>
       </object>
       </div>

       <div class="image" id="card">
            <img src="images/pinkgrad.jpg" height="300" width="500" alt="" />
            <div class="greeting" id="greeting"></div>
            <div class="friend" id="friend"></div>
            <div class="message" id="message"></div>
            <div class="from" id="from"></div>
            <div class="fromEmail" id="fromEmail"></div>
            <div class="toEmail" id="toEmail"></div>
       </div>

       <div class="image" id="cardImage">
            <img id="previewCard" src="" height="300" width="500" alt="" />
            <div id="greetingCardText" class="greetingCardText"></div>
       </div>
   </div>

  
   <div class="product">
        <select style="margin-top:20px" class="product-attr-custom" id="purchaseOptions" onchange="purchaseChange()">
            <option selected="selected" value="free">E-card -- No Donation -- Free</option>
            <option googlecart-set-product-price="5.00" value="e-card">E-card Only -- Donate $5.00</option>
            <option googlecart-set-product-price="10.00" value="physicalCard">E-card and Mailed Card -- $10.00</option>
        </select>

        <input id="pTitle" type="hidden" class="product-title" value="not this value" />
        <input id="pImage" type="hidden" class="product-image" value="images/e1.jpg" />
        <input type="hidden" class="product-price" value="5.00" />
        <div id="googleButton"><div style="margin-left:220px;margin-top:-23px" class="googlecart-add-button tabindex="0" role="button" title="Add to cart"></div></div>
        <div style="margin-left:220px;margin-top:-23px" id="sendCard" title="Add to cart">
            <asp:Button runat="server" ID="cmdSendCard" Text="Send Without Donation" OnClick="cmdSendCard_OnClick" />
        </div>
   </div>

   <div id="addressInfo">
       <div class="bodyText">
           <table width="500px">
                <tr>
                    <td>Recipient Name:</td>
                    <td><input style="margin-left:0px" type="text" name="recipient_name" size="40" onchange="hideSavedIcon()" /></td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td colspan="3"><input style="margin-left:0px;margin-top:5px" type="text" name="address1" size="40" onchange="hideSavedIcon()"  /></td>
            
                </tr>
                <tr>
                <td>&nbsp;</td>
                    <td colspan="3">
                        <input style="margin-left:0px;margin-top:2px; width: 248px;" 
                            type="text" name="address2" size="40" onchange="hideSavedIcon()"  /></td>
                </tr>
                <tr>
                    <td>City:</td>
                    <td><input style="margin-left:0px;margin-top:5px; width: 247px;" type="text" 
                            name="city" size="35" onchange="hideSavedIcon()" /></td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td><input type="text" name="state" size="2" style="width: 57px" onchange="hideSavedIcon()"  /></td>
                    <td>Zip:</td>
                    <td><input style="margin-left:0px;margin-top:2px" type="text" name="zipcode" size="9" onchange="hideSavedIcon()"  /></td>
                </tr>  
            </table>
            <a style="color:Blue;text-decoration:underline" id="saveUserInfo">Save address information</a>
            <div id="saveSuccessful" class="bodyText">
                <img src="images/checkbox.gif" alt="success" style="font-size:x-small" /> Address saved
            </div>
        </div>
    </div>
  
</asp:Content>
