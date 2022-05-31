using Common;
using jobzcolud;
using jobzcolud.WebFront;
using MySql.Data.MySqlClient;
using Service;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobzCloud.WebFront
{
    public partial class JC16KoujinJougouSetting : System.Web.UI.Page
    {
        MySqlConnection con = null;
        public static string to, tomail;
        String strGuid = Guid.NewGuid().ToString();
        public String url;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoginId"] != null)
            {
                if (!IsPostBack)
                {
                    try
                    {
                        JC_ClientConnecction_Class jc = new JC_ClientConnecction_Class();
                        jc.loginId = Session["LoginId"].ToString();
                        con = jc.GetConnection();
                        DataTable dt_loginuser = jc.GetLoginUserCodeFromClientDB();
                        lblLoginUserCode.Text = dt_loginuser.Rows[0]["code"].ToString();

                        JC99NavBar navbar_Master = (JC99NavBar)this.Master;
                        navbar_Master.lnkbtnHome.Style.Add(" background-color", "rgba(46,117,182)");
                        navbar_Master.navbar2.Visible = false;

                        //20220309 Added エインドリ－ Start
                        #region getLoginID & Name
                        txtemailAdd.Text = Session["LoginId"].ToString();
                        txtPCharge.Text = dt_loginuser.Rows[0]["name"].ToString();
                        #endregion
                        //20220309 Added エインドリ－ End
                    }
                    catch
                    {
                        Response.Redirect("JC01Login.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("JC01Login.aspx");
            }

        }

      
        protected void tb_errorclear(object sender, EventArgs e)
        {
            if (txtemailAdd.Text != "")
                LB_Email_Error.Text = "";
        }

        protected void btnChangePwd_Click(object sender, EventArgs e)
        {
            LB_Email_Error.Text = "";
            LB_User_Error.Text = "";
            ifSentakuPopup.Style["width"] = "700px";
            ifSentakuPopup.Style["height"] = "365px"; /*20220315 Updated Phoo*/
            JC17PasswordHenkou.cur_mail = Session["LoginId"].ToString();
            SessionUtility.SetSession("HOME", "Master");
            ifSentakuPopup.Src = "JC17PasswordHenkou.aspx";
            mpeSentakuPopup.Show();

            updSentakuPopup.Update();
        }

        protected void lnkBukkenToroku_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC09BukkenSyousai.aspx");
        }

        protected void lnkMitumoriToroku_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC10MitsumoriTouroku.aspx");
        }

        protected void lnkMitumoriDirectCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC10MitsumoriTouroku.aspx");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            ifSentakuPopup.Src = "";
            mpeSentakuPopup.Hide();
            updSentakuPopup.Update();
        }

        protected void btnSavePwd_Click(object sender, EventArgs e)
        {
            ifSentakuPopup.Src = "";
            mpeSentakuPopup.Hide();
            updSentakuPopup.Update();

            Session["LoginId"] = null;
            //Response.Redirect("JC01Login.aspx");
            Response.Redirect("JC04Mailkakunin.aspx?id=JC17");
        }

        protected void lnkbtnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC07Home.aspx");
        }

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

        protected void lnkMitumoriTaCopyCreate_Click(object sender, EventArgs e)
        {
            ifShinkiPopup.Src = "JC12MitsumoriKensaku.aspx";
            mpeShinkiPopup.Show();
            updShinkiPopup.Update();
        }

        protected void lnkbtnLogOut_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC01Login.aspx");
        }

        protected void lnkbtnSetting_Click(object sender, EventArgs e)
        {
            Response.Redirect("JC26Setting.aspx");
        }


        protected void btnhozon_Click(object sender, EventArgs e)
        {
            LB_Email_Error.Text = "";
            LB_User_Error.Text = "";
            bool valid_mail = true;
            if (!TextUtility.IsValidEmailAddress(txtemailAdd.Text))
            {
                // エラーメセジを表示
                LB_Email_Error.Text = "ユーザーIDが正しくありません。";
                txtemailAdd.Focus();
                valid_mail = false;
            }
            else
            {

                //20211203 Updated エインドリ－・プ－プゥ (start)
                if (txtemailAdd.Text == "" && valid_mail == true)
                {
                    LB_Email_Error.Text = "ユーザーIDが存在しません。";
                    LB_User_Error.Text = "";
                    txtemailAdd.Focus();
                }
                else if (txtPCharge.Text == "")
                {
                    LB_User_Error.Text = "ユーザー名が存在しません。";
                    LB_Email_Error.Text = "";
                    txtPCharge.Focus();
                }
                else if (txtemailAdd.Text.Equals(Session["LoginId"].ToString()))  //ユーザー名のみ変更
                {
                    //Update UserName & Mail doesn't send
                    MySqlConnection cn = new MySqlConnection("Server=" + DBUtilitycs.Server + "; Database=" + DBUtilitycs.Database + "; User Id=" + DBUtilitycs.user + "; password=" + DBUtilitycs.pass);
                    string sql_update = "";
                    sql_update = @" update contacts as con";
                    sql_update += " join customers as cus";
                    sql_update += " on con.customer_id=cus.customer_id";
                    sql_update += " set con.contact_flg='0'";
                    sql_update += " ,con.contact_name='" + txtPCharge.Text + "'";
                    sql_update += " ,cus.guid_value=''";
                    sql_update += " where con.contact_email='" + txtemailAdd.Text + "'; ";

                    cn.Open();
                    MySqlCommand cs = new MySqlCommand(sql_update, cn);
                    cs.ExecuteNonQuery();
                    cn.Close();

                    JC_ClientConnecction_Class jc = new JC_ClientConnecction_Class();
                    jc.loginId = txtemailAdd.Text;
                    con = jc.GetConnection();
                    string update = " UPDATE m_j_tantousha SET " +
                            "sTANTOUSHA='" + txtPCharge.Text + "' " +
                           "WHERE sMAIL='" + txtemailAdd.Text + "';";

                    con.Open();
                    MySqlCommand cs1 = new MySqlCommand(update, con);
                    cs1.ExecuteNonQuery();
                    con.Close();
                    //Session["LoginId"] = null;
                    //Response.Redirect("JC01Login.aspx");
                    Response.Redirect("JC16KoujinJougouSetting.aspx"); //20220309 Added エインドリ－
                }
                else    //ログインID変更
                {
                    //Check Mail is already exist or not if not , send mail 
                    if (JC02Touroku_Class.MailAcc_Check(txtemailAdd.Text))
                    {
                        LB_Email_Error.Text = "このメールアドレスはすでに会員登録で使用されているメールアドレスです。";
                        valid_mail = false;
                        txtemailAdd.Focus();
                    }
                    else
                    {
                        //20220317 Added エインドリ－ Start

                        MySqlConnection cn = new MySqlConnection("Server=" + DBUtilitycs.Server + "; Database=" + DBUtilitycs.Database + "; User Id=" + DBUtilitycs.user + "; password=" + DBUtilitycs.pass);
                        string sql_update = "";
                        sql_update = @" update contacts as con";
                        sql_update += " join customers as cus";
                        sql_update += " on con.customer_id=cus.customer_id";
                        sql_update += " set con.contact_flg='0'";
                        sql_update += " ,con.contact_email='" + txtemailAdd.Text + "'";
                        sql_update += " ,con.contact_name='" + txtPCharge.Text + "'";
                        sql_update += " ,cus.guid_value=''";
                        sql_update += " where con.contact_email='" + Session["LoginId"].ToString() + "'; ";

                        cn.Open();
                        MySqlCommand cs = new MySqlCommand(sql_update, cn);
                        cs.ExecuteNonQuery();
                        cn.Close();

                        JC_ClientConnecction_Class jc = new JC_ClientConnecction_Class();
                        jc.loginId = txtemailAdd.Text;
                        con = jc.GetConnection();
                        string update = " UPDATE m_j_tantousha SET " +
                                "sTANTOUSHA='" + txtPCharge.Text + "'," + //20211102 Added By エインドリ・プ－プゥ
                               "sMAIL='" + txtemailAdd.Text + "' " +
                               "WHERE sMAIL='" + Session["LoginId"].ToString() + "';";

                        con.Open();
                        MySqlCommand cs1 = new MySqlCommand(update, con);
                        cs1.ExecuteNonQuery();
                        con.Close();
                        //20220317 Added エインドリ－ End

                        System.Threading.Thread.Sleep(1000);

                        //20220322 Update JOBZグラウド -> 見えるJOBZ in mail エインドリ－
                        #region　メール送信
                        url = HttpContext.Current.Request.Url.AbsoluteUri;
                        url = url.Substring(0, url.Length - 23);
                        //url = url + "JC04Mailkakunin.aspx?id=" + strGuid;
                        url = url + "JC04Mailkakunin.aspx?id=JC16"; //20220315 Updated エインドリ－
                          //url = url + "JC01Login.aspx?id=true";
                        string from, pass, messageBody = "";
                        MailMessage message = new MailMessage();
                        to = txtemailAdd.Text;
                        from = ConfigurationManager.AppSettings["SMTP_Sender"];
                        pass = ConfigurationManager.AppSettings["SMTP_Password"];
                        messageBody = "この度は見えるJOBZにご登録頂きまして誠にありがとうございます。" + "\n" + "２４時間以内に下記のリンクをクリックして認証を行ってください。" + "\n" + url;
                        message.To.Add(to);
                        //message.From = new MailAddress(from, "JOBZグラウド 運営チーム");
                        message.From = new MailAddress(from, ConfigurationManager.AppSettings["SMTP_SenderName"]); //20211203 Updated エインドリ－・プ－プゥ
                        message.Body = messageBody;
                        message.Subject = "見えるJOBZのメールアドレスの認証";
                        //SmtpClient smtp = new SmtpClient("smtp.gmail.com");
                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = ConfigurationManager.AppSettings["SMTP_Host"];
                        //smtp.Timeout = 300000;
                        smtp.Timeout = int.Parse(ConfigurationManager.AppSettings["SMTP_Timeout"]);
                        smtp.EnableSsl = true;
                        //smtp.Port = 587;
                        smtp.Port = int.Parse(ConfigurationManager.AppSettings["SMTP_Port"]);
                        smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                        smtp.UseDefaultCredentials = false;
                        ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
                        smtp.Credentials = new NetworkCredential(from, pass);
                        smtp.EnableSsl = true;
                        //20211203 Updated エインドリ－・プ－プゥ (End)
                        try
                        {
                            tomail = txtemailAdd.Text;
                            smtp.Send(message);
                            //20220317 エインドリ－ Comment
                            //JC01Login.old_email = Session["LoginId"].ToString();
                            //JC01Login.new_mail = txtemailAdd.Text;
                            //JC01Login.username = txtPCharge.Text;
                        }
                        catch (Exception ex)
                        {
                            Response.Write("<script>alert('" + ex.Message + "');</script>");
                        }

                        Response.Redirect("JC03Mail.aspx?id=JC16"); //20220315 Updated Id エインドリ－
                        #endregion
                    }
                }
                //Added By エインドリ－・プ－プゥ (End)
            }
        }
    }
}