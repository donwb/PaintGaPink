<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="pickup.aspx.cs" Inherits="PaintGeorgiaPink.pickup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <title>Pick up your card from Paint Georgia Pink</title>
    <link href="css/preview.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="scripts/jquery.jqURL.js"></script>

    <script type="text/javascript">
        var cardToLoad = "none";
        var firstPass = true;
        var intervalId;

        $(document).ready(function () {
            
            $("#card").hide();
            $("#cardImage").hide();

            intervalId = window.setInterval(flipCard, 14000);

        });

        function getCardData() {
            var id = $.jqURL.get('CardId');

            // This is just here for testing.. 
            if (id == null)
                id = 19;

            var url = "PgpCardService.svc/Cards(" + id + ")";

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
        }

        function flipCard() {
            if (firstPass) {
                $("#player").hide();
                $("#card").show();
                firstPass = false;
                window.clearInterval(intervalId);
                window.setInterval(flipCard, 3000);
                getCardData();
            } else {
                $("#card").hide();
                $("#cardImage").show();
                $("#previewCard").attr("src", cardToLoad);
            }

        }

    </script>
    
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
       </div>
   </div>
   
</asp:Content>
