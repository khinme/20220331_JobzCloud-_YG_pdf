using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Common;
using Service;

namespace jobzcolud.WebFront
{
    public partial class JC99NavBar : System.Web.UI.MasterPage
    {
        public static bool insatsusettei;
        public string LoginName { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!this.IsPostBack)
            {
                if (Session["LoginId"] != null)
                {
                    JC99NavBar_Class Jc99 = new JC99NavBar_Class();
                    Jc99.loginId = Session["LoginId"].ToString();
                    ConstantVal.DB_NAME = Session["DB"].ToString();
                    Jc99.FindLoginName();
                    LoginName = Jc99.LoginName;
                    string sPath = Request.Url.AbsolutePath;
                    System.IO.FileInfo oInfo = new System.IO.FileInfo(sPath);
                    string sRet = oInfo.Name;
                    setNav2(sRet);
                    navbardrop2.InnerText = LoginName;  //20211025 MiMi Added
                }
                else
                {
                    Response.Redirect("JC01Login.aspx");
                }
             

            }
            
        }

        protected void lnkbtnHome_Click(object sender, EventArgs e)
        {           
            Response.Redirect("JC07Home.aspx", false);
            
        }
        protected void lnkBtnBukkenNew_Click(object sender, EventArgs e)
        {            
            SessionUtility.SetSession("cBukken", null);
            Response.Redirect("JC09BukkenSyousai.aspx", false);    
        }

        protected void lnkBtnBukkenList_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC30BukkenList.aspx", false); 
        }

        //protected void lnkBtnMitsumoriNew_Click(object sender, EventArgs e)
        //{
        //    SessionUtility.SetSession("cMitumori", null);
        //    Response.Redirect("JC10MitsumoriTouroku.aspx",false);           
        //}

        //protected void lnkBtnTaMitsuCopy_Click(object sender, EventArgs e)
        //{
        //    SessionUtility.SetSession("HOME", "Popup");
        //    ifShinkiPopup.Src = "JC12MitsumoriKensaku.aspx";
        //    mpeShinkiPopup.Show();
        //    updShinkiPopup.Update();
        //}

        protected void lnkBtnMitsumDirect_Click(object sender, EventArgs e)
        {
            SessionUtility.SetSession("cBukken", null);
            SessionUtility.SetSession("cMitumori", null);
            Response.Redirect("JC10MitsumoriTouroku.aspx", false);
        }
        protected void lnkBtnMitsuList_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC31MitsumoriList.aspx", false);
        }

        protected void lnkBtnUriage_Click(object sender, EventArgs e)
        {
        }

        protected void lnkBtnSetting_Click(object sender, EventArgs e)
        {
           
            Response.Redirect("JC26Setting.aspx");
        }
        protected void lnkbtnKojiSetting_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC16KoujinJougouSetting.aspx");
        }

        protected void lnkbtnLogoOut_Click(object sender, EventArgs e)
        {          
            Session["LoginId"] = null;
            Response.Redirect("JC01Login.aspx");
        }
        protected void lnkBtnUriageNew_Click(object sender, EventArgs e)
        {
            Session["linkValId"] = "uriage";
            insatsusettei = false;
            Response.Redirect("JC27UriageTouroku.aspx");
            
        }

        protected void lnkBtnUriageList_Click(object sender,EventArgs e)
        {
            Response.Redirect("JC34UriageList.aspx");
        }

        protected void setNav2(string pagename)
        {
           
            if (pagename == "JC07Home" || pagename=="JC34UriageList" ||  pagename == "JC30BukkenList" || pagename == "JC31MitsumoriList")
            {
                navbar2.Visible = false;
                lnkbtnSubBukken.Visible = false;
                lnkbtnSubMitsumori.Visible = false;
                lnkbtnSubMitsuPrint.Visible = false;
                lnkbtnSubMitsuUriage.Visible = false;
                LKB_Shousai.Visible = false;
                LKB_Settei.Visible = false;
                if (pagename == "JC07Home")
                {                    
                    lnkbtnHome.Style.Add(" background-color", "rgba(46,117,182)");
                }
                else if (pagename == "JC30BukkenList")
                {
                    navbardrop.Style.Add(" background-color", "rgba(46,117,182)");
                }
                else if (pagename == "JC31MitsumoriList")
                {
                    navbardrop1.Style.Add(" background-color", "rgba(46,117,182)");
                }
                else if (pagename == "JC34UriageList")
                {
                    //navbardrop_Uri.Style.Add(" background-color", "rgba(46,117,182)");
                    lnk_Uriage.Style.Add(" background-color", "rgba(46,117,182)");
                    LKB_Settei.Style.Add(" background-color", "rgb(242,242,242)");
                }
            }
            else if (pagename == "JC27UriageTouroku")
            {
                navbar2.Visible = true;
                lnkbtnSubBukken.Visible = false;
                lnkbtnSubMitsumori.Visible = false;
                lnkbtnSubMitsuPrint.Visible = false;
                lnkbtnSubMitsuUriage.Visible = false;
                LKB_Shousai.Visible = true;
                LKB_Settei.Visible = true;
                LKB_Shousai.Style.Add(" font-size", "14px");
                LKB_Settei.Style.Add(" font-size", "14px");
                LKB_Shousai.Height = 40;
                LKB_Settei.Height = 40;

                //navbardrop_Uri.Style.Add(" background-color", "rgba(46,117,182)");
                if (insatsusettei == false)
                {
                    LKB_Shousai.Style.Add(" background-color", "rgb(191,191,191)");
                }
                else
                {
                    LKB_Settei.Style.Add(" background-color", "rgb(191,191,191)");
                    LKB_Shousai.Style.Add(" background-color", "rgb(242,242,242)");
                }
                
            }
            
        }
        protected void LKB_Shousai_Click(object sender, EventArgs e)
        {
            insatsusettei = false;
            Response.Redirect("JC27UriageTouroku.aspx");
        }
        protected void LKB_Settei_Click(object sender, EventArgs e)
        {
            insatsusettei = true;
            Response.Redirect("JC27UriageTouroku.aspx");
        }

        #region 見積検索ぽポップアップ閉じる　　//20211014 MiMi Added
        protected void btn_CloseMitumoriSearch_Click(object sender, EventArgs e)
        {
            ifShinkiPopup.Src = "";
            mpeShinkiPopup.Hide();
            updShinkiPopup.Update();
            if (Session["cMitumori"] != null)
            {
                Response.Redirect("JC10MitsumoriTouroku.aspx");
            }
        }
        #endregion
    }
}