  <%@ Page Title="" Language="C#" MasterPageFile="~/WebFront/JC99NavBar.Master" CodeBehind="JC30BukkenList.aspx.cs" ValidateRequest="false"
    Inherits="jobzcolud.WebFront.JC30BukkenList" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <link href="Content/bootstrap.css" rel="stylesheet" />
        <asp:PlaceHolder runat="server">
            <%: Scripts.Render("~/bundles/modernizr") %>
            <%: Styles.Render("~/style/StyleBundle1") %>
            <%: Scripts.Render("~/scripts/ScriptBundle1") %>
            <%: Styles.Render("~/style/UCStyleBundle") %>  
            
          
        </asp:PlaceHolder>
        <webopt:BundleReference runat="server" Path="~/Content1/bootstrap" />
        <webopt:BundleReference runat="server" Path="~/Content1/css" />
        <link href="../Content1/bootstrap-theme.min.css" rel="stylesheet" />

        <style type="text/css">
           
            .grip {
                /*width: 100%;*/
                /*overflow: hidden;
                text-overflow: ellipsis;
                font-size: 13px;
                padding-top: 7px !important;
                 border-right:2px solid white;
                min-height:37px;
                padding-right:2px;*/
              
            }
            .JC30gvbukkencss {
                width: 1045px;
                max-width: 1045px;
                min-width: 1045px;
                justify-content:center;
               
            }
           
            .JC30ArrowCol {
                width: 2% !important;
             min-width:2% !important;
             max-width:2% !important;
                
            }
            
            .JC30CodeCol{
                
                width: 100px !important;
               
                min-width: 100px !important;
            max-width:100px !important;
            }

            .JC30BukkenMeiCol {
                width: 150px;
                min-width: 150px;
                max-width: 150px;
                /*max-width:200px;*/
            }

            .JC30BukkenBikoCol {
                width:200px;
             min-width:200px;
             max-width:200px;
                /*min-width: 15%;*/
                /*width:200px;
             min-width:200px;*/
                /*max-width: 200px;*/
            }

            .JC30BukkenMitsuCountCol {
                 width: auto;
             min-width:40px;
             max-width:40px;
                /*width: 40px;
                min-width: 40px;*/
                /*min-width: 40px;
                max-width: 40px;*/
            }

            .JC30BukkenTokuisakiCol {
                 width: 200px;
             min-width:14%;
             max-width:200px;
                /*width: 200px;
                min-width: 200px;*/
                /*min-width: 14%;
                max-width: 200px;*/
            }

            .JC30BukkenTokuisakiTantouCol {
                width: auto;
             min-width:11%;
             max-width:11%;
                /*width: 95px;
                min-width: 95px;
                max-width: 95px;*/
            }

            .JC30BukkenSakuseiBiCol {
                width: auto;
                min-width: 8%;
                max-width: 8%;
            }

            .JC30BukkenJishaTantouCol {
                  width: 8%;
             min-width:8%;
             max-width:8%;
                /*width: auto;
                min-width: 8%;
                max-width: 8%;*/
            }

            .JC30BukkengazoCol {
                width: auto;
             min-width:60px;
             max-width:60px;
                /*width: 60px;*/
                /*min-width: 60px;
                max-width: 60px;*/
            }
              
       

        
        .grid_header{
            overflow:auto;
            white-space:nowrap;
            
        }
        </style>
    </head>

    <body>
        
        <asp:PlaceHolder runat="server">
            <%: Scripts.Render("~/bundles/jqueryui") %>

        </asp:PlaceHolder>
       
        <div style="margin-top: 30px; " class="JC10MitumoriTourokuDiv">
            <div class="container-fluid bg-white " runat="server" style="">
                <div class="JC30AllBukkenListDiv">
                    <div class="left">

                        <asp:Button runat="server" ID="BT_Shinki" Text="物件を新規作成" AutoPostBack="false"
                            CssClass="BlueBackgroundButton JC07btnpadding" Width="130px" ForeColor="White" OnClick="btnBukkenNew_Click" />
                    </div>

                    <div class="JC30BukkenListDiv" runat="server" style="">
                       <%-- <table class="table1" style="margin-left: 20px;  height: 102px;">--%>
                        <table class="table1" style="margin-left: 65px;margin-top:10px;">
                            <%--<tr>
                                <td colspan="7">
                                    <asp:Label ID="lblKensakuJouken" runat="server" Text="検索条件" Font-Size="15px" Font-Bold="True"></asp:Label>
                                </td>
                            </tr>--%>
                            <tr>
                                <%--<td style="width: 60px"></td>--%>
                                <td>
                                    <asp:Label ID="lblcMitumori" runat="server" Text="物件コード" Font-Size="13px"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblTokuisaki" runat="server" Text="得意先" Font-Size="13px"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblTokuisakiTantousha" runat="server" Text="得意先担当者" Font-Size="13px"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblJishaTantousha" runat="server" Text="自社担当者" Font-Size="13px"></asp:Label>
                                </td>
                                <td colspan="3">
                                    <asp:Label ID="lbldMitumoriLabel" runat="server" Text="作成日" Font-Size="13px"></asp:Label>
                                </td>
                            </tr>
                            <tr style="height:43px;">
                               <%-- <td style="width: 60px"></td>--%>
                                <td>
                                    <asp:UpdatePanel ID="updcMitumori" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:TextBox ID="txtcBukken" runat="server" AutoPostBack="false" MaxLength="10" CssClass="form-control TextboxStyle JC30BukkenCodeTextBox" onkeypress="OnlyNumericEntry()"
                                                onkeyup="DeSelectText(this);" onfocus="this.setSelectionRange(this.value.length, this.value.length);" TextMode="Search" onchange="texboxchange()"></asp:TextBox>
                                        </ContentTemplate>
                                        <%--  <Triggers>
                                       <asp:AsyncPostBackTrigger ControlID="txtcBukken" EventName="TextChanged" /> 
                                  </Triggers>--%>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="updTokuisaki" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:TextBox ID="txtTokuisaki" runat="server" AutoPostBack="false" MaxLength="200" CssClass="form-control TextboxStyle JC30BukkenTokuisaki"
                                                onkeyup="DeSelectText(this);" onfocus="this.setSelectionRange(this.value.length, this.value.length);" onchange="texboxchange()" TextMode="Search"></asp:TextBox>
                                        </ContentTemplate>
                                        <%-- <Triggers>
                                       <asp:AsyncPostBackTrigger ControlID="txtTokuisaki" EventName="TextChanged" />
                                  </Triggers>--%>
                                    </asp:UpdatePanel>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="updTokuisakiTantou" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:TextBox ID="txtTokuisakiTantou" runat="server" AutoPostBack="false" MaxLength="200" CssClass="form-control TextboxStyle JC30BukkenTantousha"
                                                onkeyup="DeSelectText(this);" onfocus="this.setSelectionRange(this.value.length, this.value.length);" onchange="texboxchange()" TextMode="Search"></asp:TextBox>
                                        </ContentTemplate>
                                        <%-- <Triggers>
                                       <asp:AsyncPostBackTrigger ControlID="txtTokuisakiTantou" EventName="TextChanged" />
                                  </Triggers>   OnTextChanged="txtcMitumori_TextChanged"--%>
                                    </asp:UpdatePanel>
                                </td>
                                <td>

                                    <asp:UpdatePanel ID="updTantousha" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:TextBox ID="HiddenClear" runat="server" Value="" Style="display: none;" />
                                            <div style="display: none">
                                                <asp:DropDownList ID="DDL_Jyouken" runat="server" Visible="true"></asp:DropDownList>
                                                <asp:DropDownList ID="DDL_Tantousya" runat="server" Visible="true"></asp:DropDownList>
                                            </div>
                                            <asp:Button ID="btntantousha" Text="選択なし" Style="width: 120px; height: 28px;" runat="server" 
                                                OnClientClick="return forsubgridtantou()" OnClick="btnkensaku_Click" />

                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                </td>

                                <td>
                                   <asp:UpdatePanel ID="UpdJyouken" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                     <asp:UpdatePanel ID="updMitumoriStartDate" runat="server" UpdateMode="Conditional">
                                      <ContentTemplate>
                                          <asp:TextBox ID="ClearStartDate" runat="server" Value="" Style="display: none;" />
                                         <asp:Button ID="btnMitumoriStartDate" runat="server" Text="日付を設定" CssClass="JC10GrayButton" Width="90px" OnClientClick="return forsubgridate()" OnClick="btnMitumoriStartDate_Click" />
                                              <div id="divMitumoriStartDate" class="DisplayNone" runat="server">
                                              <asp:Label ID="lblMitumoriStart" runat="server" Text="" CssClass="GrayLabel"></asp:Label>
                                               <asp:Label ID="lblMitumoriStartDateYear" runat="server" CssClass="DisplayNone"></asp:Label>
                                                <asp:Button ID="btnMitumoriStartDateCross" CssClass="CrossBtnGray " runat="server" Text="✕" style="" OnClientClick=" return btnMitumoriStartDateCross_Click()" />
                                                </div>
                                      </ContentTemplate>
                                      </asp:UpdatePanel>
                                </td>
                                <td style="width:20px;">
                                      ～
                               </td>
                                <td>
                                     <asp:UpdatePanel ID="UpdMitumoriEndDate" runat="server" UpdateMode="Conditional">
                                      <ContentTemplate>
                                          <asp:TextBox ID="ClearEndDate" runat="server" Value="" Style="display: none;" />
                                         <asp:Button ID="btnMitumoriEndDate" runat="server" Text="日付を設定" CssClass="JC10GrayButton" Width="90px" OnClientClick="return forsubgridate()" OnClick="btnMitumoriEndDate_Click" />
                                              <div id="divMitumoriEndDate" class="DisplayNone" runat="server">
                                              <asp:Label ID="lblMitumoriEnd" runat="server" Text="" CssClass="GrayLabel"></asp:Label>
                                               <asp:Label ID="lblMitumoriEndDateYear" runat="server" CssClass="DisplayNone"></asp:Label>
                                                <asp:Button ID="btnMitumoriEndDateCross" CssClass="CrossBtnGray " runat="server" Text="✕" style="" OnClientClick="return btnMitumoriEndDateCross_Click()" />
                                                </div>
                                      </ContentTemplate>
                                      </asp:UpdatePanel>
                                </td>
                            </tr>

                        </table>

                        <div class="JC12ButtonDiv" style="margin-top: 0px; margin-bottom: 20px;">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Button ID="btnSearch" runat="server" CssClass=" BlueBackgroundButton JC12SearchBtn" Text="絞り込み"
                                        UseSubmitBehavior="false" Width="110px" OnClick="btnSearch_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <asp:Button ID="btnClear" runat="server" CssClass="JC10CancelBtn" Text="クリア"
                                UseSubmitBehavior="false" Width="110px" OnClientClick="return clearbtnclick()" />
                            <%--OnClick="btnClear_Click"OnClientClick="return clearbtnclick()"--%>
                        </div>
                    </div>

                </div>


                <%-- <div class="row" runat="server" >--%>
                <%--<div class="col-sm-8"></div>--%>
                <div class="container-fluid" float="left" style="margin-top: 5px; width: 1070px; max-width: 1070px; min-width: 1070px; padding-left: 0px;">
                    <asp:DropDownList ID="DropDownSearchList" runat="server" Visible="false"></asp:DropDownList>
                    <asp:UpdatePanel ID="updJoken" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <%-- <div style="padding-left:20px;padding-right:20px;margin-top:5px;max-width: 1330px !important;">--%>
                            <div class="container-fluid " float="left" style="margin-top: 5px; width: 1070px; max-width: 1070px; min-width: 1070px; border-top-left-radius: 0px;">
                                <%--<asp:Label ID="LB_Jouken" runat="server" Text="選択された条件" Font-Size="15px" Font-Bold="true"></asp:Label>--%>
                                <asp:Label ID="LB_Jouken" runat="server" Text="検索条件" Font-Size="15px" Font-Bold="true"></asp:Label>
                                <asp:Table ID="TB_SentakuJouken" align="left" runat="server" Style="margin-top: 2px; margin-left: 0px">
                                    <asp:TableRow>
                                        <asp:TableCell ID="TC_Jouken" runat="server">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <%-- </div>        --%>
                <div class="container-fluid " align="right" style="width: 1070px; max-width: 1070px; min-width: 1070px; padding-right: 0px">
                    <table style="margin-top: 10px; margin-bottom: 18px; margin-right: 0px;">
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="Updatelabel" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Label ID="lblHyojikensuu" runat="server" Text="1-20/500" Font-Size="13px" CssClass="JC12LblHyojikensuu"></asp:Label>

                                        <asp:TextBox ID="GridViewRowCount" runat="server" Value="" Style="display: none;" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td>
                                <asp:Label ID="lblHyoujikensuuLabel" runat="server" Text="表示件数" Font-Size="13px"></asp:Label>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="updHyojikensuu" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="DDL_Hyojikensuu" runat="server" Width="80px" AutoPostBack="True" Height="35px" CssClass="form-control JC12GridTextBox" Font-Size="14px" OnSelectedIndexChanged="DDL_Hyojikensuu_SelectedIndexChanged">
                                            <asp:ListItem Value="20" Selected="True">20件</asp:ListItem>
                                            <asp:ListItem Value="30">30件</asp:ListItem>
                                            <asp:ListItem Value="50">50件</asp:ListItem>
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Button ID="btnHyoujisetPopUp" runat="server" CssClass="JC12HyojiItemSettingBtn JC07btnpadding" Text="表示項目を設定"
                                            OnClientClick="return forsubgrid()" OnClick="btnBukkenHyoujiSetting_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="justify-content: center;padding-bottom:20px;">
              
                    <asp:Panel ID="pnlBukken" runat="server" >
                        <asp:UpdatePanel ID="updpnlBukken" UpdateMode="Conditional" ChildrenAsTriggers="False" runat="server">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="UpdateBukken" EventName="Click" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:Button ID="UpdateBukken" runat="server" Text="UpdateBukken" CssClass="Hidecss" OnClick="UpdateBukken_Click" />

                                <asp:TextBox ID="GV_Rowindex" runat="server" Value="" Style="display: none" />
                               <div class="d-flex justify-content-center" style ="background-color:white;padding:0px 40px 0px 40px;">               
                               <%--<div class="justify-content-center" style="overflow-x: auto;max-width: 1045px; min-width:1045px;">--%>
                               <div class="justify-content-center">
                                        <asp:GridView ID="gvBukkenOriginal" runat="server" AutoGenerateColumns="false" CellPadding="7" GridLines="None"
                                            ShowHeaderWhenEmpty="true" DataKeyNames="cBUKKEN" 
                                              AllowSorting="True" OnSorting="GV_Bukken_Sorting"
                                            cssClass="RowHover GridViewStyle">
                                            <EmptyDataRowStyle CssClass="JC30NoDataMessageStyle" />
                                            <HeaderStyle  BackColor="#F2F2F2" HorizontalAlign="Left" Height="37px" ForeColor="Black" />
                                            <%--<HeaderStyle Height="37px" BackColor="#e2e2e2" HorizontalAlign="Left" ForeColor="Black"  BorderColor="White" BorderWidth="2px"/> --%>
                                           <%-- <RowStyle CssClass="JC12GridItem" Height="37px" /> CssClass="JC30gvbukkencss  hover pointercss" --%>
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Image ID="imgArrow" runat="server" border="0" alt="" src="../Img/img-rightarrow.png" Style="width: 14px; height: 14px;min-width:14px;max-width:14px;" />

                                                        <asp:Panel ID="pnlSubBukken" runat="server" Style="display: none;">
                                                            <div style="padding: 5px;">
                                                                <asp:GridView ID="gvSubBukken" runat="server" AutoGenerateColumns="false" CellPadding="7" GridLines="None" Width="900px"
                                                                    DataKeyNames="cMITUMORI">
                                                                    <HeaderStyle BackColor="#F2F2F2" HorizontalAlign="Left" Height="37px" />
                                                                    <RowStyle CssClass="JC12GridItem" Height="37px" />
                                                                    <Columns>
                                                                        <asp:TemplateField ItemStyle-Width="35px">
                                                                            <ItemTemplate>
                                                                                <asp:Button ID="btnCopy" runat="server" Text="コ" CssClass="JC07GridCopyButton" Width="30px" Height="25px" CommandName="Copy" CommandArgument="<%# Container.DataItemIndex %>" OnClick="btnCopy_Click" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="35px" />
                                                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkbtn_cMitsumori" runat="server" Text='<%#Eval("見積コード") %>' OnClick="btnMitsuHyouji_Click"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <HeaderTemplate>
                                                                                <asp:Label ID="lbl_HSubcMitsumori" runat="server" Text="見積コード" CssClass="d-inline-block"></asp:Label>
                                                                            </HeaderTemplate>
                                                                            <HeaderStyle CssClass="JC28CodeHeaderCol" />
                                                                            <ItemStyle CssClass="JC28CodeCol" />
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <div class="JC12LabelItem" style="height: 35px;">
                                                                                    <asp:Label ID="lbl_sMitsumori" runat="server" CssClass="JC07Labelcss" Text='<%# Server.HtmlEncode((string)Eval("見積名"))%>'></asp:Label>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <HeaderTemplate>
                                                                                <asp:Label ID="lbl_HSubsMitsumori" runat="server" Text="見積名" CssClass="d-inline-block"></asp:Label>
                                                                            </HeaderTemplate>
                                                                            <HeaderStyle CssClass="JC28CodeHeaderCol" />
                                                                            <ItemStyle CssClass="JC28CodeCol" />
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <div class="JC12LabelItem" style="height: 35px;">
                                                                                    <asp:Label ID="lbl_sTANTOUSHA" runat="server" CssClass="JC07Labelcss" Text='<%# Server.HtmlEncode((string)Eval("営業担当"))%>'></asp:Label>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <HeaderTemplate>
                                                                                <asp:Label ID="lbl_HSubsTANTOUSHA" runat="server" Text="営業担当" CssClass="d-inline-block"></asp:Label>
                                                                            </HeaderTemplate>
                                                                            <HeaderStyle CssClass="JC28CodeHeaderCol" />
                                                                            <ItemStyle CssClass="JC28CodeCol" />
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <div class="JC12LabelItem" style="height: 35px;">
                                                                                    <asp:Label ID="lbl_dMITUMORISAKUSEI" runat="server" CssClass="JC07Labelcss" Text='<%#Eval("見積日") %>'></asp:Label>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <HeaderTemplate>
                                                                                <asp:Label ID="lbl_HSubdMITUMORISAKUSEI" runat="server" Text="見積日" CssClass="d-inline-block"></asp:Label>
                                                                            </HeaderTemplate>
                                                                            <HeaderStyle CssClass="JC28CodeHeaderCol" />
                                                                            <ItemStyle CssClass="JC28CodeCol" />
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <div class="JC12LabelItem" style="height: 35px;">
                                                                                    <asp:Label ID="lbl_nKINGAKU" runat="server" CssClass="JC07Labelcss" Text='<%#Eval("合計金額") %>'></asp:Label>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <HeaderTemplate>
                                                                                <asp:Label ID="lbl_HSubnKINGAKU" runat="server" Text="合計金額" CssClass="d-inline-block"></asp:Label>
                                                                            </HeaderTemplate>
                                                                            <HeaderStyle CssClass="JC28CodeHeaderCol" />
                                                                            <ItemStyle CssClass="JC28CodeCol" />
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <div class="JC12LabelItem" style="height: 35px;">
                                                                                    <asp:Label ID="lbl_cJYOTAI_MITUMORI" runat="server" CssClass="JC07Labelcss" Text='<%#Eval("見積状態") %>'></asp:Label>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <HeaderTemplate>
                                                                                <asp:Label ID="lbl_HSubJyoutai" runat="server" Text="見積状態" CssClass="d-inline-block"></asp:Label>
                                                                            </HeaderTemplate>
                                                                            <HeaderStyle CssClass="JC28CodeHeaderCol" />
                                                                            <ItemStyle CssClass="JC28CodeCol" />
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <div class="JC12LabelItem" style="height: 35px;">
                                                                                    <asp:Label ID="lbl_nMITUMORIARARI" runat="server" CssClass="JC07Labelcss" Text='<%#Eval("金額粗利") %>'></asp:Label>
                                                                                </div>
                                                                            </ItemTemplate>
                                                                            <HeaderTemplate>
                                                                                <asp:Label ID="lbl_HSubArari" runat="server" Text="金額粗利" CssClass="d-inline-block"></asp:Label>
                                                                            </HeaderTemplate>
                                                                            <HeaderStyle CssClass="JC28CodeHeaderCol" />
                                                                            <ItemStyle CssClass="JC28CodeCol" />
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <div class="dropdown">
                                                                                    <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown"
                                                                                        aria-haspopup="true" aria-expanded="false" style="border: 1px solid gainsboro; width: 20px; height: 20px; padding: 0px 3px 0px 1px; margin: 0;">
                                                                                    </button>
                                                                                    <div class="dropdown-menu fontcss " aria-labelledby="dropdownMenuButton" style="min-width: 1rem; width: 5rem;">
                                                                                        <asp:LinkButton ID="btnDelete" class="dropdown-item " runat="server" Text='削除' Style="margin-right: 10px" CommandArgument="<%# Container.DataItemIndex %>"  OnClick="btnDelete_Click" OnClientClick="EditSubGridClick()"></asp:LinkButton>
                                                                                    </div>
                                                                                </div>
                                                                                 <asp:Button ID="btnBukenSubDeleteOk" runat="server" Text="はい" class="BlueBackgroundButton DisplayNone" Width="100px" Height="36px" OnClick="btnBukenSubDeleteOk_Click" />
                                                                                 <asp:Button ID="btnBukenSubDeleteCancel" runat="server" Text="キャンセル" class="JC09GrayButton DisplayNone" Width="100px" Height="36px" />
                                                                            
                                                                                
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" />
                                                                            <ItemStyle Width="25px" />
                                                                        </asp:TemplateField>

                                                                    </Columns>

                                                                </asp:GridView>
                                                            </div>
                                                            <div style="padding-bottom: 10px;">
                                                                <%--                                                   <asp:Button ID="btnAddMitsumori" runat="server" Text="✛ 見積を追加" cssClass="BlueBackgroundButton JC07btnpadding" style="padding:0 15px 0 15px;" CommandArgument="<%# Container.DataItemIndex %>" OnClick="btnAddMitsumori_Click"/> --%>
                                                                <asp:Button ID="btnAddMitsumori" runat="server" Text="✛ 見積を追加" CssClass="BlueBackgroundButton JC07btnpadding" Style="padding: 0 15px 0 15px;" CommandName="Copy" CommandArgument="<%# Container.DataItemIndex %>" />
                                                                <asp:Button ID="btnTaMitsumori" runat="server" Text="✛ 他見積をコピーして追加" CssClass="BlueBackgroundButton JC07btnpadding" Style="padding: 0 15px 0 15px;" UseSubmitBehavior="False" CausesValidation="False" CommandArgument="<%# Container.DataItemIndex %>" OnClick="btnTaMitsumori_Click" />

                                                            </div>

                                                        </asp:Panel>
                                                  
                                                            </ItemTemplate>
                                                    <%--<HeaderStyle Width="21px"></HeaderStyle>--%>

                                                    <ItemStyle CssClass="JC30ArrowCol" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderStyle-CssClass="Hidecss">

                                                    <HeaderTemplate>
                                                        test
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <%--After PostBack Use this attribute, open Sub Grid --%>
                                                        <asp:TextBox ID="IsExpanded" runat="server" Value="" Style="width: 0px;" />
                                                        <%--Use　Request Form , get this value in class --%>
                                                        <input name="IsExpanded" value='0' style="width: 0px;" />
                                                    </ItemTemplate>

                                                    <ItemStyle CssClass="Hidecss" />

                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="コード" SortExpression="コード">
                                                    <ItemTemplate>
                                                         <div class="grip" style=" text-align: left; overflow: hidden;  display: -webkit-box;  -webkit-line-clamp: 1; -webkit-box-orient: vertical;word-break: break-all;">
                                                            <asp:LinkButton ID="lnkbtn_cBukken" runat="server" CssClass="JC07Labelcss" Text=' <%# Bind("コード") %>' OnClientClick="codebtnclick()" OnClick="btnBukkenHyouji_Click"></asp:LinkButton>
                                                        </div>
                                                    </ItemTemplate>
                                                  <%--  <HeaderTemplate>
                                                       
                                                        <asp:Label ID="lbl_HcBukken" runat="server" Text="コード" CssClass="d-inline-block"></asp:Label>
                                                
                                                            </HeaderTemplate>--%>
                                                      <HeaderStyle CssClass="JC30HeaderCol"></HeaderStyle>
                                                    <ItemStyle CssClass="JC30CodeCol" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="物件名" SortExpression="物件名">
                                                    <ItemTemplate>
                                                        <div class="grip" style=" text-align: left; padding-right: 4px;  overflow: hidden;  display: -webkit-box;  -webkit-line-clamp: 1; -webkit-box-orient: vertical;word-break: break-all;">
                                                            <asp:Label ID="lbl_sBukken" runat="server" CssClass="JC07Labelcss" Text='<%# Server.HtmlEncode((string)Eval("物件名"))%>' ToolTip='<%#Eval("物件名") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                   <%-- <HeaderTemplate>
                                                       
                                                        <asp:Label ID="lbl_HsBukken" runat="server" Text="物件名" CssClass="d-inline-block"></asp:Label>
                                                
                                                             </HeaderTemplate>--%>
                                                     <%-- <HeaderStyle CssClass="JC18HeaderCol" BorderColor="White" BorderWidth="2px"></HeaderStyle>--%>
                                                    <ItemStyle CssClass="JC30BukkenMeiCol"/>
                                                    <HeaderStyle CssClass="JC30HeaderCol" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="備考" SortExpression="備考">
                                                    <ItemTemplate>
                                                        <div class="grip" style=" text-align: left; padding-right: 4px;  overflow: hidden;  display: -webkit-box;  -webkit-line-clamp: 1; -webkit-box-orient: vertical;word-break: break-all;">
                                                            <asp:Label ID="lbl_sBiko" runat="server" CssClass="JC07Labelcss" Text='<%# Server.HtmlEncode((string)Eval("備考"))%>' ToolTip='<%#Eval("備考") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                    <%--<HeaderTemplate>
                                                     
                                                        <asp:Label ID="lbl_HsBiko" runat="server" Text="備考" CssClass="d-inline-block"></asp:Label>
                                                            </HeaderTemplate>--%>

                                                      <%--<HeaderStyle CssClass="JC18HeaderCol" BorderColor="White" BorderWidth="2px"></HeaderStyle>--%>
                                                    <ItemStyle CssClass="JC30BukkenBikoCol" />
                                                    <HeaderStyle CssClass="JC30HeaderCol"  />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="見積" SortExpression="見積">
                                                    <ItemTemplate>
                                                        <div class="grip" style=" text-align: left; padding-right: 4px;  overflow: hidden;  display: -webkit-box;  -webkit-line-clamp: 1; -webkit-box-orient: vertical;word-break: break-all;">
                                                            <asp:Label ID="lbl_nMitsumori" runat="server" CssClass="JC07Labelcss" Text='<%#Eval("見積")%>' ToolTip='<%#Eval("見積") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                    <%--<HeaderTemplate>
                                                        <asp:Label ID="lbl_HnMitsumori" runat="server" Text="見積" CssClass="d-inline-block"></asp:Label>
                                                
                                                            </HeaderTemplate>--%>
                                                     <%--<HeaderStyle CssClass="JC18HeaderCol" BorderColor="White" BorderWidth="2px"></HeaderStyle>--%>
                                                    <ItemStyle CssClass="JC30BukkenMitsuCountCol" />
                                                    <HeaderStyle CssClass="JC30HeaderCol" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="得意先名" SortExpression="得意先名">
                                                    <ItemTemplate>
                                                        <div class="grip" style=" text-align: left; padding-right: 4px;  overflow: hidden;  display: -webkit-box;  -webkit-line-clamp: 1; -webkit-box-orient: vertical;word-break: break-all;">
                                                            <asp:Label ID="lbl_sTokuisaki" runat="server" CssClass="JC07Labelcss" Text='<%# Server.HtmlEncode((string)Eval("得意先名"))%>' ToolTip='<%#Eval("得意先名") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                   <%-- <HeaderTemplate>
                                                       
                                                        <asp:Label ID="lbl_HsTokuisaki" runat="server" Text="得意先名" CssClass="d-inline-block"></asp:Label>
                                                  
                                                            </HeaderTemplate>--%>
                                                   <%--  <HeaderStyle CssClass="JC18HeaderCol" BorderColor="White" BorderWidth="2px"></HeaderStyle>--%>
                                                    <ItemStyle CssClass="JC30BukkenTokuisakiCol" />
                                                    <HeaderStyle CssClass="JC30HeaderCol" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="得意先担当" SortExpression="得意先担当">
                                                    <ItemTemplate>
                                                        <div class="grip" style=" text-align: left; padding-right: 4px;  overflow: hidden;  display: -webkit-box;  -webkit-line-clamp: 1; -webkit-box-orient: vertical;word-break: break-all;">
                                                            <asp:Label ID="lbl_sTokuiTantou" runat="server" CssClass="JC07Labelcss" Text='<%# Server.HtmlEncode((string)Eval("得意先担当"))%>' ToolTip='<%#Eval("得意先担当") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                   <%-- <HeaderTemplate>
                                                        <asp:Label ID="lbl_HsTokuiTantou" runat="server" Text="得意先担当" CssClass="d-inline-block"></asp:Label>
                                                 
                                                            </HeaderTemplate>--%>
                                                      <%--<HeaderStyle CssClass="JC18HeaderCol" BorderColor="White" BorderWidth="2px"></HeaderStyle>--%>
                                                    <ItemStyle CssClass="JC30BukkenTokuisakiTantouCol" />
                                                    <HeaderStyle CssClass="JC30HeaderCol" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="物件作成日" SortExpression="物件作成日">
                                                    <ItemTemplate>
                                                        <div class="grip" style=" text-align: left; padding-right: 4px;  overflow: hidden;  display: -webkit-box;  -webkit-line-clamp: 1; -webkit-box-orient: vertical;word-break: break-all;">
                                                            <asp:Label ID="lbl_dSakuseibi" runat="server" CssClass="JC07Labelcss" Text='<%#Eval("物件作成日") %>' ToolTip='<%#Eval("物件作成日") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                    <%--<HeaderTemplate>
                                                   
                                                        <asp:Label ID="lbl_HdSakuseibi" runat="server" Text="物件作成日" CssClass="d-inline-block"></asp:Label>
                                                   
                                                            </HeaderTemplate>--%>
                                                      <%--<HeaderStyle CssClass="JC18HeaderCol" BorderColor="White" BorderWidth="2px"></HeaderStyle>--%>
                                                    <ItemStyle CssClass="JC30BukkenSakuseiBiCol" />
                                                    <HeaderStyle CssClass="JC30HeaderCol" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="自社担当" SortExpression="自社担当">
                                                    <ItemTemplate>
                                                        <div class="grip" style=" text-align: left; padding-right: 4px;  overflow: hidden;  display: -webkit-box;  -webkit-line-clamp: 1; -webkit-box-orient: vertical;word-break: break-all;">
                                                            <asp:Label ID="lbl_sJishaTantou" runat="server" CssClass="JC07Labelcss" Text='<%# Server.HtmlEncode((string)Eval("自社担当"))%>' ToolTip='<%#Eval("自社担当") %>'></asp:Label>
                                                        </div>
                                                    </ItemTemplate>
                                                    <%--<HeaderTemplate>
                                                      
                                                        <asp:Label ID="lbl_HsJishaTantou" runat="server" Text="自社担当" CssClass="d-inline-block"></asp:Label>
                                                   
                                                            </HeaderTemplate>--%>
                                                     <%-- <HeaderStyle CssClass="JC18HeaderCol" BorderColor="White" BorderWidth="2px"></HeaderStyle>--%>
                                                    <ItemStyle CssClass="JC30BukkenJishaTantouCol" />
                                                    <HeaderStyle CssClass="JC30HeaderCol" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="画像">
                                                    <ItemTemplate>
                                                        <asp:Panel ID="pnl_image" runat="server" Style="display: none">
                                                            <asp:Image ID="img_bukken" runat="server" CssClass="imagecss" Visible='<%# Eval("file64string").ToString() != "../Img/imgerr.png" %>' ImageUrl='<%# Eval("file64string") %>' />
                                                        </asp:Panel>
                                                        <asp:Panel ID="pnl_showimage" runat="server">
                                                            <asp:Image ID="img_popupBukken" runat="server" CssClass="popupHover" Height="30px" Width="30px" Visible='<%# Eval("file64string").ToString() != "../Img/imgerr.png"  %>' ImageUrl='<% # Eval("file64string") %>' />
                                                        </asp:Panel>
                                                        <asp:HoverMenuExtender ID="hme_image" runat="server" PopupControlID="pnl_image" TargetControlID="pnl_showimage" PopupPosition="Bottom">
                                                        </asp:HoverMenuExtender>
                                                    </ItemTemplate>
                                                   <%-- <HeaderTemplate>
                                                       
                                                        <asp:Label ID="lbl_Himage" runat="server" Text="画像" CssClass="d-inline-block"></asp:Label>
                                                            </HeaderTemplate>--%>
                                                    <%-- <HeaderStyle CssClass="JC18HeaderCol" BorderColor="White" BorderWidth="2px"></HeaderStyle>--%>
                                                    <ItemStyle CssClass="JC30BukkengazoCol" />
                                                    <HeaderStyle CssClass="JC30HeaderCol" />
                                                </asp:TemplateField>

                                            </Columns>
                                            <EmptyDataTemplate>
                                                該当するデータがありません。
                                            </EmptyDataTemplate>
                                        </asp:GridView>

                                        <asp:GridView ID="gvBukken" runat="server" AutoGenerateColumns="false" CellPadding="0" GridLines="None" 
                                            HeaderStyle-CssClass="GVFixedHeader" RowStyle-CssClass="GridRow"
                                            cssClass="JC30gvbukkencss hover pointercss GridViewStyle"  AllowSorting="true" OnSorting="GV_Bukken_Sorting" OnRowCreated="GV_Bukken_RowCreated"
                                             ShowHeaderWhenEmpty="true" OnPageIndexChanging="GV_Mitumori_PageIndexChanging" DataKeyNames="cBUKKEN" OnRowDataBound="gvBukken_RowDataBound" OnRowCommand="GV_Mitsumori_Original_RowCommand">

                                            <HeaderStyle  BackColor="#F2F2F2" HorizontalAlign="Left" Height="37px" ForeColor="Black" CssClass="grid_header"/>
                                           <%-- <RowStyle CssClass="JC12GridItem" Height="37px" />HeaderStyle-CssClass="GVFixedHeader" RowStyle-CssClass="GridRow"--%>
                                             <RowStyle CssClass="JC12GridItem" Height="37px" />
                                            <Columns>
                                                <asp:TemplateField HeaderStyle-CssClass="Hidecss">

                                                    <HeaderTemplate>
                                                        test
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <%--After PostBack Use this attribute, open Sub Grid --%>
                                                        <asp:TextBox ID="IsExpanded" runat="server" Value="" Style="width: 0px;" />
                                                        <%--Use　Request Form , get this value in class --%>
                                                        <input name="IsExpanded" value='0' style="width: 0px;" />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="0px" />
                                                    <ItemStyle CssClass="Hidecss" />

                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnCopy" runat="server" Text="コ" CssClass="JC30GrayButton" Width="30px" Height="25px" CommandName="Copy" CommandArgument="<%# Container.DataItemIndex %>" OnClick="btnCopy_Click" />

                                                        <asp:LinkButton ID="lnkbtn_cMitsumori" runat="server" Text='<%#Eval("見積コード") %>' OnClick="btnMitsuHyouji_Click"></asp:LinkButton>

                                                        <div class="dropdown">
                                                            <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown"
                                                                aria-haspopup="true" aria-expanded="false" style="border: 1px solid gainsboro; width: 20px; height: 20px; padding: 0px 3px 0px 1px; margin: 0;">
                                                            </button>
                                                            <div class="dropdown-menu fontcss " aria-labelledby="dropdownMenuButton" style="min-width: 1rem; width: 5rem;">
                                                               
                                                          <asp:LinkButton ID="btnDelete" class="dropdown-item " runat="server" Text='削除' Style="margin-right: 10px" CommandArgument="<%# Container.DataItemIndex %>"  OnClick="btnDelete_Click" OnClientClick="EditSubGridClick()"></asp:LinkButton>
                                                                                    </div>
                                                                                </div>
                                                                                 
                                                        <div style="padding-bottom: 10px;">
                                                            <%--  <asp:Button ID="btnAddMitsumori"  runat="server" Text="✛ 見積を追加"  cssClass="BlueBackgroundButton JC09SaveBtn " commandName="Copy"
                                                style="padding:0 15px 0 15px;" CommandArgument="<%# Container.DataItemIndex %>"  OnClick="btnAddMitsumori_Click" /> --%>
                                                            <asp:Button ID="btnAddMitsumori" runat="server" Text="✛ 見積を追加" CssClass="BlueBackgroundButton JC09SaveBtn " CommandName="Copy"
                                                                Style="padding: 0 15px 0 15px;" CommandArgument="<%# Container.DataItemIndex %>" />
                                                            <asp:Button ID="btnTaMitsumori" runat="server" Text="✛ 他見積をコピーして追加" CssClass="BlueBackgroundButton JC09SaveBtn "
                                                                Style="padding: 0 15px 0 15px;" OnClientClick="javascript:window.location.reload()"
                                                                OnClick="btnTaMitsumori_Click" />

                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EmptyDataRowStyle CssClass="JC30NoDataMessageStyle" />
                                            <EmptyDataTemplate>
                                                該当するデータがありません。
              
                                            </EmptyDataTemplate>
                                             <RowStyle Height="37px" CssClass="JC12GridItem"  />
                            
                                   <%-- <AlternatingRowStyle CssClass="gvRowStyle" />--%>
                                        </asp:GridView>
                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" GridLines="None" CssClass="JC30gvbukkencss"
                                            ShowHeaderWhenEmpty="true" ShowHeader="False" AllowPaging="True" OnPageIndexChanging="GV_Mitumori_PageIndexChanging" DataKeyNames="cBUKKEN" OnRowDataBound="gvPgBukken_RowDataBound">


                                            <RowStyle Height="0px" />
                                            <PagerStyle Font-Size="14px" HorizontalAlign="Center" CssClass="GridPager" VerticalAlign="Middle" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="&lt;" LastPageText="&gt;" />
                                        </asp:GridView>
                                    </div>

                                </div>

                               <div  style="display:block; position:absolute">
                               <asp:TextBox ID="OpenSubgrid_Delete" runat="server" Value=""  style="display:none;"/> 
                                    <asp:TextBox ID="tamitsumoriId" runat="server" Value="" style="display:none;"/>
                             
                           </div>
                            </ContentTemplate>

                        </asp:UpdatePanel>
                    </asp:Panel>
                     <%--<asp:TextBox ID="OpenSubgrid_delete" runat="server" Value="" Style="display: block" />--%>
                    <asp:TextBox ID="bukkencodeflag" runat="server" Value="" Style="display: none;" />
                    <asp:TextBox ID="subgridcall" runat="server" Value="" Style="display: none" />
                    <asp:Button ID="Button1" runat="server" Text="Button" OnClick="btnDateChange_Click" Style="display: none;" />
                    <div style="display: none; position: absolute">

                        <asp:TextBox ID="HiddenBukkenId" runat="server" Value="" Style="display: none;" />

                        <asp:TextBox ID="MitsuCD_flag" runat="server" Value="" Style="display: none;" />
                        <asp:Button ID="btnBukkenHyouji" runat="server" Text="物件表示" Style="display: none;" OnClick="btnBukkenHyouji_Click" />

                    </div>

                    <div style="display: none; position: absolute">
                        <asp:TextBox ID="selectedindex" runat="server" Value="" Style="display: none;" />
                        <asp:Button ID="btndropdwonselect" runat="server" Text="物件表示" Style="display: none;" OnClick="btndropdwonselect_Click" />

                    </div>
                    <div>
                          <asp:UpdatePanel ID="upddatePopup" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Button ID="btndatePopup" runat="server" Text="Button" CssClass="DisplayNone" />
                <asp:ModalPopupExtender ID="mpedatePopup" runat="server" TargetControlID="btndatePopup"
                    PopupControlID="pnldatePopupScroll" BackgroundCssClass="PopupModalBackground" BehaviorID="pnldatePopupScroll"
                    RepositionMode="RepositionOnWindowResize">
                </asp:ModalPopupExtender>
                <asp:Panel ID="pnldatePopupScroll" runat="server" Style="display: none;" CssClass="PopupScrollDiv">
                    <asp:Panel ID="pnldatePopup" runat="server">
                        <iframe id="ifdatePopup" runat="server" class="NyuryokuIframe RadiusIframe" scrolling="no" style="max-width: 260px; min-width: 260px; max-height: 365px; min-height: 365px;"></iframe>
                        <asp:Button ID="btnCalendarClose" runat="server" Text="Button" CssClass="DisplayNone" OnClick="btnCalendarClose_Click" />
                        <asp:Button ID="btnCalendarSettei" runat="server" Text="Button" CssClass="DisplayNone" OnClick="btnCalendarSettei_Click" />
                        <asp:Button ID="btnTokuisakiClose" runat="server" Text="Button" Style="display: none" />
                          <asp:TextBox ID="opensubgriddate" runat="server" Value="" Style="display:none" />

                    </asp:Panel>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="updSentakuPopup" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Button ID="btnSentakuPopup" runat="server" Text="Button" CssClass="DisplayNone" />
                                <asp:ModalPopupExtender ID="mpeSentakuPopup" runat="server" TargetControlID="btnSentakuPopup"
                                    PopupControlID="pnlSentakuPopupScroll" BackgroundCssClass="PopupModalBackground" BehaviorID="pnlSentakuPopupScroll">
                                </asp:ModalPopupExtender>
                                <asp:Panel ID="pnlSentakuPopupScroll" runat="server" Style="display: none; overflow-x: hidden; overflow-y: hidden;" CssClass="PopupScrollDiv">
                                    <asp:Panel ID="pnlSentakuPopup" runat="server">
                                        <iframe id="ifSentakuPopup" runat="server" scrolling="no" class="NyuryokuIframe" style="border-radius: 0px;"></iframe>
                                        <asp:Button ID="btnClose" runat="server" Text="Button" Style="display: none" OnClick="btnClose_Click" />
                                        <asp:Button ID="btnJishaTantouSelect" runat="server" Text="Button" Style="display: none" OnClick="btnJishaTantouSelect_Click" />
                                        <asp:TextBox ID="OpenSubgridTantou" runat="server" Value="" Style="display: none" />
                                    </asp:Panel>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>


                        <asp:UpdatePanel ID="updHyoujiSet" runat="server" UpdateMode="Conditional">
                            <%-- <Triggers>
                             <asp:AsyncPostBackTrigger ControlID="btnHyoujiSetting" EventName="Click" />
                        </Triggers>--%>
                            <ContentTemplate>
                                <asp:Button ID="btnHyoujiSetting" runat="server" Text="Button" Style="display: none" OnClientClick="" />
                                <asp:ModalPopupExtender ID="mpeHyoujiSetPopUp" runat="server" TargetControlID="btnHyoujiSetting"
                                    PopupControlID="pnlHyoujiSetPopUpScroll" BehaviorID="pnlHyoujiSetPopUpScroll" BackgroundCssClass="PopupModalBackground">
                                </asp:ModalPopupExtender>
                                <asp:Panel ID="pnlHyoujiSetPopUpScroll" runat="server" CssClass="PopupScrollDiv">
                                    <%--Style="display: none; width:950px; height:98vh; margin-left:17%"--%><%--remove style and add media query in <style></style> by テテ--%>
                                    <asp:Panel ID="pnlHyoujiSetPopUp" runat="server">
                                        <iframe id="ifpnlHyoujiSetPopUp" runat="server" class="HyoujiSettingIframe" allowtransparency="true"></iframe>
                                        <%--style="width: 940px;height:94vh;background-color:white"--%> <%--remove style and add media query in <style></style> by テテ--%>
                                        <asp:Button ID="btnHyoujiClose" runat="server" Text="Button" CssClass="DisplayNone" OnClick="btnHyoujiSettingClose_Click" /><%--20211108 テテ added--%>
                                        <asp:Button ID="btnHyoujiSave" runat="server" Text="Button" CssClass="DisplayNone" OnClick="btnHyoujiSettingSave_Click" /><%--20211110 テテ added--%>
                                        <asp:TextBox ID="OpenSubgrid" runat="server" Value="" Style="display: none" />

                                    </asp:Panel>
                                </asp:Panel>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="updShinkiPopup" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Button ID="btnShinkiPopup" runat="server" Text="Button" Style="display: none" />
                                <asp:ModalPopupExtender ID="mpeShinkiPopup" runat="server" TargetControlID="btnShinkiPopup"
                                    PopupControlID="pnlShinkiPopupScroll" BackgroundCssClass="PopupModalBackground" BehaviorID="pnlShinkiPopupScroll"
                                    RepositionMode="none ">
                                </asp:ModalPopupExtender>
                                <asp:Panel ID="pnlShinkiPopupScroll" runat="server" Style="display: none; height: 100%; overflow: hidden;" CssClass="PopupScrollDiv">
                                    <asp:Panel ID="pnlShinkiPopup" runat="server">
                                        <iframe id="ifShinkiPopup" runat="server" scrolling="yes" style="height: 100vh; width: 100vw;"></iframe>
                                        <asp:TextBox ID="Opensubgridmitsu" runat="server" Value="" Style="display: none" />
                                        <asp:Button ID="btn_CloseMitumoriSearch" runat="server" Text="Button" CssClass="DisplayNone" OnClick="btn_CloseMitumoriSearch_Click" />
                                    </asp:Panel>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
         <script src="../Scripts/jquery-3.5.1.js"></script> 
         <script src="../Scripts/colResizable-1.6.min.js" type="text/javascript"></script>
    <script src="../Scripts/cookie.js" type="text/javascript"></script>
    <script type="text/javascript">
                            
                                 function codebtnclick() {
                                      document.getElementById("<%= bukkencodeflag.ClientID %>").value = "1";
                                 }
                                 function texboxchange() {
                                    // alert("ok");
                                      var cMitumori = document.getElementById("<%= txtcBukken.ClientID %>").value;
                                     if (cMitumori != "") {
                                         document.getElementById("<%= txtcBukken.ClientID %>").value = cMitumori.padStart(10, '0');
                                     }
                                     return false; // this will call textbox changed event.
                                 }
                                 function btnMitumoriStartDateCross_Click() {
                                   
                                     document.getElementById("<%= lblMitumoriStart.ClientID %>").Text = "";
                                     document.getElementById("<%= ClearStartDate.ClientID %>").value = "1";
                                     document.getElementById("<%= divMitumoriStartDate.ClientID %>").style.display = "none";
                                     document.getElementById("<%= btnMitumoriStartDate.ClientID %>").style.display = "block";
                                    document.getElementById("<%= tamitsumoriId.ClientID %>").value = "0";  
                                     return false;
                                 }
                                  function btnMitumoriEndDateCross_Click() {
                                    document.getElementById("<%= tamitsumoriId.ClientID %>").value = "0";  
                                      document.getElementById("<%= lblMitumoriEnd.ClientID %>").Text = "";
                                     document.getElementById("<%= ClearEndDate.ClientID %>").value = "1";
                                     document.getElementById("<%= divMitumoriEndDate.ClientID %>").style.display = "none";
                                     document.getElementById("<%= btnMitumoriEndDate.ClientID %>").style.display = "block";
                                     return false;
                                 }
                                 function clearbtnclick(){
                                    
                                     document.getElementById("<%= txtcBukken.ClientID %>").value = "";
                                     document.getElementById("<%= txtTokuisaki.ClientID %>").value = "";
                                     document.getElementById("<%= txtTokuisakiTantou.ClientID %>").value = "";
                                     document.getElementById("<%= btntantousha.ClientID %>").value = "選択なし";
                                     document.getElementById("<%= btntantousha.ClientID %>").className = "JC30TantouKensakuBtnNull";
                                     document.getElementById("<%= lblMitumoriEnd.ClientID %>").Text = "";
                                     document.getElementById("<%= lblMitumoriEnd.ClientID %>").value = "";
                                     document.getElementById("<%= divMitumoriEndDate.ClientID %>").style.display = "none";
                                     document.getElementById("<%= btnMitumoriEndDate.ClientID %>").style.display = "block";
                                      document.getElementById("<%= lblMitumoriStart.ClientID %>").Text = "";
                                      document.getElementById("<%= lblMitumoriStart.ClientID %>").value = "";
                                     document.getElementById("<%= divMitumoriStartDate.ClientID %>").style.display = "none";
                                     document.getElementById("<%= btnMitumoriStartDate.ClientID %>").style.display = "block";
                                     document.getElementById("<%= HiddenClear.ClientID %>").value = "1";

                                     return false;
                                 }
                                 function forsubgrid(){
                                     document.getElementById("<%= OpenSubgrid.ClientID %>").value = "1";
                                     document.getElementById("<%= subgridcall.ClientID %>").value = "1";
                                     document.getElementById("<%= tamitsumoriId.ClientID %>").value = "0";  
                                     return true;
                                 }
                                 function forsubgridate(){
                                     document.getElementById("<%= opensubgriddate.ClientID %>").value = "1";
                                     document.getElementById("<%= subgridcall.ClientID %>").value = "1";
                                     document.getElementById("<%= tamitsumoriId.ClientID %>").value = "0";  
                                     return true;
                                 }
                                 function forsubgridtantou() {
                                     document.getElementById("<%= tamitsumoriId.ClientID %>").value = "0";  
                                     document.getElementById("<%= OpenSubgridTantou.ClientID %>").value = "1";
                                     document.getElementById("<%= subgridcall.ClientID %>").value = "1";
                                     return true;
                                 }
                                   function EditSubGridClick() {
            document.getElementById("<%= tamitsumoriId.ClientID %>").value = "1";
            document.getElementById("<%= OpenSubgrid_Delete.ClientID %>").value = "1";
        }
           

                                <%-- $(document).ready(function () {
                                     // var userLang = navigator.language || navigator.userLanguage;
                                     var options = $.extend({},
                                         $.datepicker.regional["ja"], {
                                             dateFormat: "yy/mm/dd",
                                             beforeShow: function () {
                                                 $(".ui-datepicker").css('font-size', 14)
                                             },
                                             changeMonth: true,
                                             changeYear: true,
                                             highlightWeek: true,
                                             onSelect: function () {
                                             }
                                         }
                                     );
                                     $("#<%= txtBukkenStartDate.ClientID%>").datepicker(options);
                                     $("#<%= txtBukkenEndDate.ClientID%>").datepicker(options);

                                 });--%>
</script>
                <script type="text/javascript"> 
                    $(function () {

                        //スクロール・バー配置の記憶
                        $(window).scroll(function () {
                            // sessionStorage.scrollTop = $(this).scrollTop();
                            sessionStorage.scrollTop = $(this).scrollTop();
                        });
                        $(document).ready(function () {
                            sessionStorage.scrollTop = $(this).scrollTop(0);
                        });
                        $(document).ready(function () {
                            if (sessionStorage.scrollTop != "undefined") {
                                $(window).scrollTop(sessionStorage.scrollTop);
                            }
                            var G_rowcount = document.getElementById("<%= GridViewRowCount.ClientID %>").value;

                            if(G_rowcount != "0") {
                                $('[id*=gvBukken] tr td').on('click', function () {
                                    
                                        var b_flag = document.getElementById("<%= bukkencodeflag.ClientID %>").value;
                                        // alert(b_flag);
                                        var col = $(this).parent().children().index($(this));
                                        var title = $(this).closest("table").find("th").eq(col).text();

                                        title = title.trim();
                                        if (b_flag != "1") {
                                            var row = $(this).parent();
                                            $("[id*=gvBukken] tr").each(function () {

                                                if ($(this)[0] != row[0]) {
                                                    $("td", this).removeClass("JC07Selected_row");
                                                }
                                            });

                                            //色付ける
                                            $("td", row).each(function () {
                                                if (!$(this).hasClass("JC07Selected_row")) {
                                                    $(this).addClass("JC07Selected_row");

                                                } else {
                                                    $(this).removeClass("JC07Selected_row");

                                                }
                                            });
                                            $("[id*=gvSubBukken] td", row).each(function () {
                                                $(this).removeClass("JC07Selected_row");

                                            });

                                            //行を展開する
                                            var expandvalue = $(this).closest("tr").find("[name*='IsExpanded']").val();
                                            var col = $(this).parent().children().index($(this));
                                            if (expandvalue == "1") {

                                                $(this).closest("tr").next().remove();
                                                var row = $(this).closest("tr");

                                                row.find("[name*='IsExpanded']").val("0");
                                                // $("[src*=img-buttonarrow]", $(this).closest("tr")).attr("src", "/Img/img-rightarrow.png");
                                                $("[id*=imgArrow]", $(this).closest("tr")).attr("src", "/Img/img-rightarrow.png");
                                            }
                                            else {
                                                //alert("Open");
                                                $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $("[id*=pnlSubBukken]", $(this).closest("tr")).html() + "</td></tr>");
                                                var row = $(this).closest("tr");
                                                row.find("[name*='IsExpanded']").val("1");
                                                // $("[src*=img-rightarrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");
                                                $("[id*=imgArrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");
                                                //  $("#imgArrow" ).attr("src", "/Img/img-buttonarrow.png");  
                                            }
                                            // imgArrow}
                                        }
                                    
                                });
                                $('[id*=gvBukken] tr td').hover(function () {
                                    var col = $(this).parent().children().index($(this));

                                    var row = $(this).parent();
                                    $("[id*=gvBukken] tr").each(function () {
                                        if ($(this)[0] != row[0]) {
                                            $("td", this).removeClass("JC07Selected_row");
                                        }
                                    });

                                    //色付ける
                                    $("td", row).each(function () {
                                        if (!$(this).hasClass("JC07Selected_row")) {
                                            $(this).addClass("JC07Selected_row");

                                        } else {
                                            $(this).removeClass("JC07Selected_row");

                                        }
                                    });
                                    $("[id*=gvSubBukken] td", row).each(function () {
                                        $(this).removeClass("JC07Selected_row");

                                    });

                                });

                                //物件詳細にあるコピー、削除したあと、物件詳細を表示する
                                $("[id*=IsExpanded]").each(function () {
                                   
                                    if ($(this).val() == "1") {
                                         alert("hehe")
                                        $(this).closest("tr").find("[name*='IsExpanded']").val("1");
                                        $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $("[id*=pnlSubBukken]", $(this).closest("tr")).html() + "</td></tr>")
                                      //  $("[src*=img-rightarrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");
                                       $("[id*=imgArrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");
                                    }
                                });
                            }
                        });
                    });
                 
                   
                    //after parital render jquery is not woking 
                     var parameter = Sys.WebForms.PageRequestManager.getInstance();

                    parameter.add_endRequest(function () {
                        if (sessionStorage.scrollTop != "undefined") {
                            $(window).scrollTop(sessionStorage.scrollTop);
                        }
                        var G_rowcount = document.getElementById("<%= GridViewRowCount.ClientID %>").value;

                        if (G_rowcount != "0") {
                            //物件リスト一覧行をクリックすると、行の色を変更する 
                            $('[id*=gvBukken] tr td').on('click', function () {
                                 var btnId = document.getElementById("<%= tamitsumoriId.ClientID %>").value;   
                           
                                if (btnId != 1) {
                                    var col = $(this).parent().children().index($(this));
                                    var title = $(this).closest("table").find("th").eq(col).text();
                                    var b_flag = document.getElementById("<%= bukkencodeflag.ClientID %>").value;
                                    if (b_flag != "1") {
                                        var row = $(this).parent();
                                        $("[id*=gvBukken] tr").each(function () {
                                            if ($(this)[0] != row[0]) {
                                                $("td", this).removeClass("JC07Selected_row");
                                            }
                                        });

                                        //色付ける
                                        $("td", row).each(function () {
                                            if (!$(this).hasClass("JC07Selected_row")) {
                                                $(this).addClass("JC07Selected_row");

                                            } else {
                                                $(this).removeClass("JC07Selected_row");

                                            }
                                        });
                                        $("[id*=gvSubBukken] td", row).each(function () {
                                            $(this).removeClass("JC07Selected_row");

                                        });

                                        //行を展開する
                                        var expandvalue = $(this).closest("tr").find("[name*='IsExpanded']").val();
                                        var col = $(this).parent().children().index($(this));
                                        if (expandvalue == "1") {

                                            $(this).closest("tr").next().remove();
                                            var row = $(this).closest("tr");
                                            row.find("[name*='IsExpanded']").val("0");
                                            //$("[src*=img-buttonarrow]", $(this).closest("tr")).attr("src", "/Img/img-rightarrow.png");
                                            $("[id*=imgArrow]", $(this).closest("tr")).attr("src", "/Img/img-rightarrow.png");

                                        }
                                        else {

                                            $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $("[id*=pnlSubBukken]", $(this).closest("tr")).html() + "</td></tr>");
                                            var row = $(this).closest("tr");
                                            row.find("[name*='IsExpanded']").val("1");
                                            //$("[src*=img-rightarrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");
                                            $("[id*=imgArrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");
                                        }
                                    }

                                }
                            });
                            //mouse hover すると行に色を付ける
                            $('[id*=gvBukken] tr td').hover(function () {
                                var btnId = document.getElementById("<%= tamitsumoriId.ClientID %>").value;   
                           
                                if (btnId != 1) {
                                    var col = $(this).parent().children().index($(this));

                                    var row = $(this).parent();
                                    $("[id*=gvBukken] tr").each(function () {
                                        if ($(this)[0] != row[0]) {
                                            $("td", this).removeClass("JC07Selected_row");
                                        }
                                    });

                                    //色付ける
                                    $("td", row).each(function () {
                                        if (!$(this).hasClass("JC07Selected_row")) {
                                            $(this).addClass("JC07Selected_row");

                                        } else {
                                            $(this).removeClass("JC07Selected_row");

                                        }
                                    });
                                    $("[id*=gvSubBukken] td", row).each(function () {
                                        $(this).removeClass("JC07Selected_row");

                                    });
                                }
                                else
                             {
                                   document.getElementById("<%= tamitsumoriId.ClientID %>").value = "0";
                             }
                            });

                            //物件詳細にあるコピー、削除したあと、物件詳細を表示する
                            $("[id*=IsExpanded]").each(function () {
                                //alert("Ok");
                                var expandvalue = $(this).closest("tr").find("[name*='IsExpanded']").val();
                                var row = $(this).closest("tr");
                                var flag = document.getElementById("<%= OpenSubgrid.ClientID %>").value;
                                var flagtantou = document.getElementById("<%= OpenSubgridTantou.ClientID %>").value;
                                var flagmitsu = document.getElementById("<%= Opensubgridmitsu.ClientID %>").value;
                                var flagdate = document.getElementById("<%= opensubgriddate.ClientID %>").value;
                                var flagdelete = document.getElementById("<%= OpenSubgrid_Delete.ClientID %>").value;
                                var flagdel = document.getElementById("<%= tamitsumoriId.ClientID %>").value;
                               
                                 if ($(this).val() == "1") {
                                    if (flagdel == "1") {
                                        $(this).closest("tr").find("[name*='IsExpanded']").val("1");
                                        $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $("[id*=pnlSubBukken]", $(this).closest("tr")).html() + "</td></tr>")
                                        // $("[src*=img-rightarrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");
                                        $("[id*=imgArrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");
                                    }
                                }
                               
                                if (flagdel != "1") {
                                    if (expandvalue == "1") {
                                        if (flag != "1") {
                                            if (flagtantou != "1") {
                                                if (flagmitsu != "1") {
                                                    if (flagdate != "1") {

                                                        $(this).closest("tr").find("[name*='IsExpanded']").val("1");
                                                        $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $("[id*=pnlSubBukken]", $(this).closest("tr")).html() + "</td></tr>")

                                                        $("[id*=imgArrow]", $(this).closest("tr")).attr("src", "/Img/img-buttonarrow.png");

                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            });
                        }
                    } );
                     
            </script> 
         <script type="text/javascript">
    //         $(function () {
                
    //     //        if ($.cookie('colWidthBukkenList') != null) {
                    
    //     //    var columns = $.cookie('colWidthBukkenList').split(',');
    //     //    var i = 0;
    //     //    $('.GridViewStyle th').each(function () {
    //     //        $(this).width(columns[i++]);
    //     //    });
    //     //}         
                   
    //     $(".GridViewStyle").colResizable({
    //         liveDrag: true,
    //         resizeMode: 'overflow',
    //         postbackSafe: true,
    //         partialRefresh: true,
    //         flush: true,
    //         gripInnerHtml: "<div class='grip'></div>",
    //         draggingClass: "dragging",
    //         onResize: onSampleResized
    //     });

    //     });


    //    var onSampleResized = function (e)
    //    {
    //        var columns = $(e.currentTarget).find("th");
    //         var msg = "";
    //         var date = new Date();
    //         date.setTime(date.getTime() + (60 * 20000));
    //        columns.each(function ()
    //        {
    //            msg += $(this).width() + ",";
    //        })
            
    //        $.cookie("colWidthBukkenList", msg, { expires: date }); // expires after 20 minutes
    //    }; 

    //var prm = Sys.WebForms.PageRequestManager.getInstance();
    //    if (prm != null)
    //    {
    //        prm.add_endRequest(function (sender, e)
    //        {
    //            if (sender._postBackSettings.panelsToUpdate != null)
    //            {
    //                //if ($.cookie('colWidthBukkenList') != null)
    //                //{
    //                //    var columns = $.cookie('colWidthBukkenList').split(',');
    //                //    var i = 0;
    //                //    $('.GridViewStyle th').each(function ()
    //                //    {
    //                //        $(this).width(columns[i++]);
    //                //    });
    //                //}         


    //                $(".GridViewStyle").colResizable({
    //                    liveDrag: true,
    //                    resizeMode: 'overflow',
    //                    postbackSafe: true,
    //                    partialRefresh: true,
    //                    flush: true,
    //                    gripInnerHtml: "<div class='grip'></div>",
    //                    draggingClass: "dragging",
    //                    onResize: onSampleResized
    //                });
    //            }
    //        });
    //    };
</script>

    </body >
         <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
 <script src="../Scripts/cloudflare-jquery-ui-i18n.min.js"></script>
    </html>
</asp:Content>
