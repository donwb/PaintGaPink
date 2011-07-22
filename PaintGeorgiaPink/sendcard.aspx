<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="sendcard.aspx.cs" Inherits="PaintGeorgiaPink.sendcard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="scripts/json2.js"></script>
    <script type="text/javascript" src="scripts/jquery.field.min.js"></script> 
    <script type="text/javascript" src="scripts/jquery.easing.1.1.js"></script>
    <script type="text/javascript" src="scripts/jcarousellite_1.0.1.min.js"></script>
    <title>You've Been Pinked</title>

    <link href="css/sendcard.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">

        var selectedImageId = 1;
        var rootURL = "";
        var phraseArray;

        $(document).ready(function () {

            createPhraseArray();
            $("#greetingCardText").html(phraseArray[1]);

            $("#imageChooser").jCarouselLite({
                btnNext: ".next",
                btnPrev: ".prev",
                speed: 800,
                easing: "backout"
            });

            $("#btnPreview").click(function () {

                if (validateForm()) {

                    var data = { CardStyleId: selectedImageId, SenderName: $("input[name='sender_name']").getValue(),
                        SenderEmail: $("input[name='sender_email']").getValue(), RecipientName: $("input[name='friends_name']").getValue(),
                        RecipientEmail: $("input[name='friends_email']").getValue(), Greeting: $("input[name='change_text']").getValue(),
                        Message: $("textarea[name='message_field']").getValue(), IsSent: false
                    };
                    var data = JSON.stringify(data);

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "PgpCardService.svc/Cards",
                        data: data,
                        dataType: "json",
                        success: resultCallback,
                        error: failCallBack

                    });
                } else {
                    alert("There are errors on the form.. please fix");
                }
            });


        });


        function validateForm() {
            
            
            var toEmail = $("input[name='friends_email']").getValue();
            var toEmailOk = (toEmail.indexOf('@') > -1);

            var forEmail = $("input[name='sender_email']").getValue();
            var forEmailOk = (forEmail.indexOf('@') > -1);

            var to = $("input[name='friends_name']").getValue();
            var from = $("input[name='sender_name']").getValue();
            var msg = $("textarea[name='message_field']").getValue();

            // gotta love boolean logic..
            return (forEmailOk && toEmailOk && (to.length > 0) && (from.length > 0) && (msg.length > 0));

            
        }


        function resultCallback(result) {
            var resultData = result["d"];
            window.location.href = "preview.aspx?CardId=" + resultData.CardId;
        }

        function failCallBack(XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.statusText + " error!!!");
        }

        function modGreeting() {
            var changeValue = $("input[name='change_text']").getValue();

            $("#textToChange").html(changeValue + ',');
        }

        function modFriend() {
            //alert($("input[name='change_text']").getValue());
            var changeValue = $("input[name='friends_name']").getValue();
            
            $("#friendsName").html(changeValue);
        }

        function modMessage() {
            var changeValue = $("textarea[name='message_field']").getValue();
            $("#message").html(changeValue);
        }

        function changeImage(imageName, imageID, phraseArrayIndex) {
            selectedImageId = imageID;
            $("#greetingCardImage").attr("src", "images/" + imageName);
            $("#greetingCardText").html(phraseArray[phraseArrayIndex]);
        }


        function createPhraseArray() {
            phraseArray = [
                "", //Stub to make this a 1 based array, don't ask.. I'm ashamed",
                "There is always a ray of hope, if you just look towards the horizon.",
                "You are my ray of sunshine.",
                "You are a part of my life's garden.",
                "Your garden can't grow without the rain.",
                "Sunflowers turn to the sun, that's why I always turn to you.",
                "You inspire me.",
                "I'm with you everyday.",
                "Marvel in life's daily miracles.",
                "Sometimes the journey is the destination.",
                "This life is not a dress rehearsal.",
                "To see the view, you must first make the climb.",
                "Each day is a new life. Seize it. Live it.",
                "Find peace in everything around you.",
                "Find strength and love from those around you.",
                "Rejoice in life's little gifts.",
                "See where the path may lead you.",
                "Let me be the wind beneath your sails.",
                "Always take some time for yourself.",
                "Thank you for being my friend.",
                "Last night I sent an angel to watch over you while you were sleeping, but it came back early! So I asked it why? It said that angels don't watch over other angels.",
                "True friends are hard to find, difficult to leave, and impossible to forget. Thank you for everything you do to support those impacted by breast cancer.",
                "If I could pull down the rainbow, I would write your name with it and put it back in the sky to let everyone know how colorful my life is with a friend like you.",
                "I asked God for a flower, He gave me a garden. Asked for a tree, He gave me a forest. Asked for a river, He gave me an ocean. I asked for a sister. He gave me you.",
                "You bring out the best in me. Thank you for being my mother.",
                "The road to a friend's house is never too long. Thank you for being my friend.",
                "Some people come into our lives and go quickly. Some stay for a while and leave footprints on our hearts. And we are never, ever, the same. Thank you for being in my life.",
                "Friendship is born at that moment when one person says to another, 'What you too? I thought I was the only one!'"
                ];


        }

</script>

    <style type="text/css">
        .style2
        {
            width: 115px;
        }
        .style3
        {
            width: 117px;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="carouselMain">
    <a href="#" class="prev">&nbsp</a> 
    <div id="imageChooser" class="carousel">
    <%--<img src="images/arrow_left.png" class="prev" alt="previous" />--%>
        <ul>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e1.jpg" alt="" width="290" height="170" onclick="changeImage('e1.jpg', 1, 1)"  /></div><br />There is always a ray of hope, if you just look towards the horizon.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e2.jpg" alt="" width="290" height="170"  onclick="changeImage('e2.jpg', 2, 2)" /></div><br />You are my ray of sunshine.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e3.jpg" alt="" width="290" height="170"  onclick="changeImage('e3.jpg', 3, 3)"  /></div><br />You are a part of my life's garden.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e4.jpg" alt="" width="290" height="170"   onclick="changeImage('e4.jpg', 4, 4)" /></div><br />Your garden can't grow without the rain.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e5.jpg" alt="" width="290" height="170"  onclick="changeImage('e5.jpg',5, 5)" /></div><br />Sunflowers turn to the sun, that's why I always turn to you.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e6.jpg" alt="" width="290" height="170"  onclick="changeImage('e6.jpg',6, 6)" /></div><br />You inspire me.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e7.jpg" alt="" width="290" height="170"  onclick="changeImage('e7.jpg',7, 7)" /></div><br />I'm with you everyday.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e8.jpg" alt="" width="290" height="170"  onclick="changeImage('e8.jpg',8, 8)" /></div><br />Marvel in life's daily miracles.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e9.jpg" alt="" width="290" height="170"  onclick="changeImage('e9.jpg',9, 9)" /></div><br />Sometimes the journey is the destination.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e10.jpg" alt="" width="290" height="170"  onclick="changeImage('e10.jpg',10, 10)" /></div><br />This life is not a dress rehearsal.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e11.jpg" alt="" width="290" height="170"  onclick="changeImage('e11.jpg',11, 11)" /></div><br />To see the view, you must first make the climb.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e12.jpg" alt="" width="290" height="170"  onclick="changeImage('e12.jpg',12, 12)" /></div><br />Each day is a new life. Seize it. Live it.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e13.jpg" alt="" width="290" height="170"  onclick="changeImage('e13.jpg',13, 13)" /></div><br />Find peace in everything around you.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e14.jpg" alt="" width="290" height="170"  onclick="changeImage('e14.jpg',14, 14)" /></div><br />Find strength and love from those around you.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e15.jpg" alt="" width="290" height="170"  onclick="changeImage('e15.jpg',15, 15)" /></div><br />Rejoice in life's little gifts.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e16.jpg" alt="" width="290" height="170"  onclick="changeImage('e16.jpg',16, 16)" /></div><br />See where the path may lead you.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e17.jpg" alt="" width="290" height="170"  onclick="changeImage('e17.jpg',17, 17)" /></div><br />Let me be the wind beneath your sails.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e18.jpg" alt="" width="290" height="170"  onclick="changeImage('e18.jpg',18, 18)" /></div><br />Always take some time for yourself.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e19.jpg" alt="" width="290" height="170"  onclick="changeImage('e19.jpg',19, 19)" /></div><br />Thank you for being my friend.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e20.jpg" alt="" width="290" height="170"  onclick="changeImage('e20.jpg',20, 20)" /></div><br /><div class="wordyCardText">Last night I sent an angel to watch over you while you were sleeping, but it came back early! So I asked it why? It said that angels don't watch over other angels.</div></div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e21.jpg" alt="" width="290" height="170"  onclick="changeImage('e21.jpg',21, 21)" /></div><br /><div class="wordyCardText">True friends are hard to find, difficult to leave, and impossible to forget. Thank you for everything you do to support those impacted by breast cancer.</div></div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e22.jpg" alt="" width="290" height="170"  onclick="changeImage('e22.jpg',22, 22)" /></div><br /><div class="wordyCardText">If I could pull down the rainbow, I would write your name with it and put it back in the sky to let everyone know how colorful my life is with a friend like you.</div></div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e23.jpg" alt="" width="290" height="170"  onclick="changeImage('e23.jpg',23, 23)" /></div><br /><div class="wordyCardText">I asked God for a flower, He gave me a garden. Asked for a tree, He gave me a forest. Asked for a river, He gave me an ocean. I asked for a sister. He gave me you.</div></div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e24.jpg" alt="" width="290" height="170"  onclick="changeImage('e24.jpg',24, 24)" /></div><br />You bring out the best in me. Thank you for being my mother.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e25.jpg" alt="" width="290" height="170"  onclick="changeImage('e25.jpg',25, 25)" /></div><br />The road to a friend's house is never too long. Thank you for being my friend.</div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e26.jpg" alt="" width="290" height="170"  onclick="changeImage('e26.jpg',26, 26)" /></div><br /><div class="wordyCardText">Some people come into our lives and go quickly. Some stay for a while and leave footprints on our hearts. And we are never, ever, the same. Thank you for being in my life.</div></div></li>
            <li><div class="imageContainer"><div class="imageBox" onmouseover="this.style.borderWidth='3px'" onmouseout="this.style.borderWidth='1px'">
                <img src="images/e27.jpg" alt="" width="290" height="170"  onclick="changeImage('e27.jpg',27, 27)" /></div><br /><div class="wordyCardText">Friendship is born at that moment when one person says to another, "What you too? I thought I was the only one!"</div></div></li>

        </ul>
    <%--<img src="images/arrow_right.png" class="next" alt="next" />--%>
    </div>
    <a href="#" class="next">&nbsp</a>
</div>
    
    <div class="dashedDivider"></div>

	<div class="image">
        <div class="previewImageSurround">
		    <img class="previewImageBox" id="greetingCardImage" src="images/e1.jpg" alt="" />
            <img class="previewImageBox" src="images/textbox.jpg" atl="" />
            <div class="greetingCardText" id="greetingCardText"></div>
        </div>
		<div class="greeting" id="textToChange"></div>
		<br/>
		<div class="friend" id="friendsName"></div>
		<br/>
		<div class="message" id="message"></div>
	</div>

    <div class="formBox">
        <div class="personalize">Personalize this card</div>
	    <div class="bodyText">

            <table>
                <tr>
                    <td class="style3">Friend's Name:</td>
                    <td><input type="text" name="friends_name" size="30" onchange="modFriend()" /></td>
                    <td class="style2">Friend's Email:</td>
                    <td><input type="text" name="friends_email" size="20" style="width: 171px"/></td>
                </tr>
                <tr>
                    <td colspan="4">Message</td>
                </tr>
                <tr>
                    <td colspan="4"><textarea onchange="modMessage()" name="message_field" 
                            style="width: 593px; height: 69px"></textarea></td>
                </tr>
                 
                <tr>
                    <td class="style3">Your Name:</td>
                    <td><input type="text" name="sender_name" size="20" style="width: 187px" /></td>
                    <td class="style2">Your Email:</td>
                    <td><input type="text" name="sender_email" size="20" style="width: 172px" /></td>
                </tr>
            </table>
	     </div>
	     
	     <div class="bodyText">
            <a style="color:Blue;text-decoration:underline;cursor:pointer" id="btnPreview" href="#bottom">Preview Card</a>
         </div>
     </div>
     
</asp:Content>
