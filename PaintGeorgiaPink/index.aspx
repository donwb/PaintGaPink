<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="PaintGeorgiaPink.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



<div id="wrapper">
   
    <div style="margin:auto">
        <img class="individualCards" src="images/e1.jpg" width="210" height="130" alt="" />
        <img class="individualCards"  width="210" height="130" src="images/e2.jpg" alt="" />
        <img class="individualCards"  width="210" height="130" src="images/e3.jpg" alt="" />
        <img class="individualCards"  width="210" height="130" src="images/e8.jpg" alt="" />
    </div>


    <div id="main">


        <div class="paragraph">
            
            <img style="margin-top:2px;margin-left:-20px; float:left" src="images/pinked.png"/ width="120" height="120" alt="You've Been Pinked" />
                
            <p>A <span style="color:#FF66CC;font-weight:bold;text-align:right;">You’ve Been Pinked</span> card is a simple, thoughtful way of 
            connecting with,   or acknowledging friends, family members, colleagues; anyone who has been touched by breast cancer.</p>

            <p><span style="color:#FF66CC;font-weight:bold;text-align:right;">You’ve Been Pinked</span> cards are delivered via e-mail and are free of charge, although your generous contribution goes to new Breast Friends
             initiatives such as this one.  Also our new on-line resource center which will be available 
             shortly for those seeking the latest information on breast cancer related products and services. Your financial support also
              helps established Breast Friends programming including One-To-One emotional support and practical assistance.
            </p>
        
            <p>Choose your card, add your message and <span style="color:#FF66CC;font-weight:bold;text-align:right;">Pink</span> someone today!</p>
          
        </div><!--end of left paragraph-->


        <div id="prayingcard">
            <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="400" height="207" id="card_rotate" align="middle">
	            <param name="allowScriptAccess" value="sameDomain" />
	            <param name="allowFullScreen" value="false" />
	            <param name="movie" value="card_rotate.swf" /><param name="quality" value="high" /><param name="wmode" value="transparent" /><param name="bgcolor" value="#ffffff" />	<embed src="card_rotate.swf" quality="high" wmode="transparent" bgcolor="#ffffff" width="400" height="207" name="card_rotate" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	        </object>
            <p style="text-align:center">This life is not a dress rehearsal</p>
            <a href="sendcard.aspx"><img style="margin-left:100px" src="images/pinksomeonebutton.png" alt="pink someone button" /></a>
        </div><!--end of praying card-->  

    </div><!--end of main-->
        
        
        
</div><!--end of wrapper-->

</asp:Content>
