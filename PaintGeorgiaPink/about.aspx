<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="PaintGeorgiaPink.about" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


<div id="wrapper">
    <div id="content">

        <div id="logo"><img src="images/pinked.png"/></div><!--logo-->


        <div id="disclaimer"><p>"You've Been Pinked" is an online service provided by <a href="https://www.breastfriends.org">Breast Friends, Inc.,</a> 
        a Georgia 501 (c)(3) non-profit orginization.</p></div>

    </div><!--end of content-->


    <div id="main">

        <h1>About Us</h1>

        <div class="paragraph">
            <p><span1>Breast Friends</span1> is an Atlanta-based breast cancer support network that provides 
            individual support, practical assistance, and information and resources for breast cancer patients, their family, 
            and friends. Our program is staffed by breast cancer survivors, private citizens, and professionals in the community who have a 
            special interest in breast cancer.</p>

            <span1>Contact Us</span1>
            <p>Breast Friends, Inc.<br />
            180 Allen Road NE<br />
            Suite 305 North<br />
            Atlanta, GA 30328</p>

            <p>404.252.1061 - office<br  />
            888.880.8436 - fax</p>

            <p><a href="mailto: support@breastfriends.org">support@breastfriends.org</p>
        </div>

        <!--end of left paragraph-->

        <div id="prayingcard">
            <img src="images/prayingcard.png" />
        </div>
        <!--end of praying card-->

    </div><!--end of main-->
</div><!--end of wrapper-->

</asp:Content>
