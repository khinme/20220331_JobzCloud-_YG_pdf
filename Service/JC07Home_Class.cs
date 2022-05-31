/*作成者：ナン
 *作成日：20210901
 */
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common;
namespace Service
{
    public class JC07Home_Class
    {
        //MySqlConnection M_con = new MySqlConnection("Server=" + DBUtilitycs.Server + "; Database=" + DBUtilitycs.Database + "; User Id=" + DBUtilitycs.user + "; password=" + DBUtilitycs.pass);
        MySqlConnection con = new MySqlConnection();
        public string cListId { get; set; }
        public string bukkenId { get; set; }
        public string mitsumoriId { get; set; }
        public string loginId { get; set; }
        public string bukkenList { get; set; }
        public string mitsumoriList { get; set; }

        public string sortkomoku = "";　//ルインマー 20220329
        public void ReadConn()
        {
            con = new MySqlConnection("Server=" + DBUtilitycs.Server + "; Database=" + ConstantVal.DB_NAME + "; User Id=" + DBUtilitycs.user + "; password=" + DBUtilitycs.pass);

        }
        public DataTable HomeBukken()
        {
            ReadConn();
            JC99NavBar_Class jc99class = new JC99NavBar_Class();
            jc99class.loginId = loginId;
            jc99class.FindLoginName();

            string str_query = BukkenKomuku();
            DataTable dt_bukken = new DataTable();
            string str_bukken = "";

            str_bukken = " SELECT ifnull(rb.cBUKKEN,'') as cBUKKEN";
            str_bukken += ",if(count(rbs.cMITUMORI) =0,null,count(rbs.cMITUMORI)) as cCountMitsu ";
            str_bukken += str_query;
            str_bukken += ",ifnull(mf.cFILE, '') as cFILE ";
            str_bukken += ",ifnull(mf.sFILE, '') as sFILE ";
            str_bukken += ",ifnull(mf.sPATH_SERVER_SOURCE, '') as sPATH_SERVER_SOURCE ";
            str_bukken += ", '' as file64string ";
            str_bukken += "  from r_bukken as rb";
            str_bukken += " left join r_bu_mitsu as rbs on rb.cBUKKEN = rbs.cBUKKEN ";
            str_bukken += " left join m_j_tantousha as mt ";
            str_bukken += " on rb.cTANTOUSHA = mt.cTANTOUSHA ";
            str_bukken += " Left JOIN m_bu_file mbf on mbf.cBUKKEN = rb.cBUKKEN  and mbf.cFILE = rb.cFILE and mbf.fVISABLE = 1 ";
            str_bukken += " LEFT JOIN m_File mf ON mf.cFILE = mbf.cFILE ";
            str_bukken += " Where mt.cTANTOUSHA = '" + jc99class.login_Code + "'";
            str_bukken += " group by rb.cBUKKEN order by dBUKKEN desc limit 10; ";
            con.Open();
            using (MySqlDataAdapter adap = new MySqlDataAdapter(str_bukken, con))
            {
                adap.Fill(dt_bukken);
            }
            con.Close();

            return dt_bukken;
        }
      

        #region SearchNameReplace
        public string SearchNameReplace(String str)
        {
            string s = str;
            if (str.Contains("\\"))
            {
                s = s.Replace("\\", "\\\\\\\\");
            }
            if (str.Contains("%"))
            {
                s = s.Replace("%", "\\%");
            }
            if (str.Contains("'"))
            {
                s = s.Replace("'", "\\'");
            }
            if (str.Contains("’"))
            {
                s = s.Replace("’", "\\’");
            }
            return s;
        }
        #endregion
        public DataTable Bukken(string sql1, string sql2, string sql3, string sql4, string sql5, int offset, int limitrow, string sortexpression, string direction)
        {
            ReadConn();
            JC99NavBar_Class jc99class = new JC99NavBar_Class();
            jc99class.loginId = loginId;
            jc99class.FindLoginName();
            sortkomoku = sortexpression;
            string str_query = BukkenKomuku();
            DataTable dt_bukken = new DataTable();
            string str_bukken = "";

            if (sortkomoku == "")
            {
                sortkomoku = "rb.cBUKKEN";
            }
            if (str_query != "")
            {
                //rb.cBUKKEN as cBUKKEN,
                str_bukken = " SELECT rb.cBUKKEN as cBUKKEN,if(count(rbs.cMITUMORI) =0,null,count(rbs.cMITUMORI)) as cCountMitsu ";
                str_bukken += str_query;
                str_bukken += ", '' as file64string ,rb.cBUKKEN, mf.cFILE, mf.sFILE, mf.sPATH_SERVER_SOURCE ";
                str_bukken += "  from r_bukken as rb";
                str_bukken += " LEFT join r_bu_mitsu as rbs on rb.cBUKKEN = rbs.cBUKKEN ";
                str_bukken += " LEFT JOIN m_bu_file mbf on  rb.cBUKKEN = mbf.cBUKKEN  and mbf.cFILE = rb.cFILE and mbf.fVISABLE=1 ";
                str_bukken += " LEFT JOIN m_File mf On mf.cFILE = mbf.cFILE  ";
                str_bukken += " LEFT join m_j_tantousha as mt ";
                str_bukken += " on rb.cTANTOUSHA = mt.cTANTOUSHA ";
                str_bukken += " where 1=1 " + sql1 + sql2 + sql3 + sql4 + sql5;
                // str_bukken += " group by rb.cBUKKEN order by rb.cBUKKEN desc LIMIT " + limitrow + " OFFSET " + offset + ";  ";
                str_bukken += " group by rb.cBUKKEN order by " + sortkomoku + " " + direction + " LIMIT " + limitrow + " OFFSET " + offset + ";  ";
                try
                {

                    using (MySqlDataAdapter adap = new MySqlDataAdapter(str_bukken, con))
                    {

                        adap.Fill(dt_bukken);
                    }

                }
                catch (Exception ex)
                {

                }
            }

            return dt_bukken;
        }
        public DataTable BukkenPg(string sql1, string sql2, string sql3, string sql4, string sql5)
        {
            ReadConn();
            JC99NavBar_Class jc99class = new JC99NavBar_Class();
            jc99class.loginId = loginId;
            jc99class.FindLoginName();

            string str_query = BukkenKomuku();
            DataTable dt_bukken = new DataTable();
            string str_bukken = "";
            if (str_query != "")
            {
                //str_bukken = " SELECT * FROM  ( ";
                //str_bukken += " SELECT rb.cBUKKEN as cBUKKEN,if(count(rbs.cMITUMORI) =0,null,count(rbs.cMITUMORI)) as cCountMitsu, ";
                //str_bukken += str_query;
                //str_bukken += ", '' as file64string ";
                //str_bukken += "  from r_bukken as rb";
                //str_bukken += " left join r_bu_mitsu as rbs on rb.cBUKKEN = rbs.cBUKKEN ";
                //str_bukken += " left join m_j_tantousha as mt ";
                //str_bukken += " on rb.cTANTOUSHA = mt.cTANTOUSHA ";
                //str_bukken += " where 1=1 " + sql1 + sql2 + sql3 + sql4 + sql5;
                //str_bukken += " group by rb.cBUKKEN order by dCREATE desc )dt1 ";
                //str_bukken += " LEFT JOIN( ";
                //str_bukken += " SELECT rb.cBUKKEN, mf.cFILE, mf.sFILE, mf.sPATH_SERVER_SOURCE ";
                //str_bukken += " FROM r_bukken rb ";
                //str_bukken += " LEFT JOIN m_bu_file mbf on mbf.cFILE = rb.cFILE ";
                //str_bukken += " LEFT JOIN m_File mf On mf.cFILE = mbf.cFILE ";
                //str_bukken += " Where rb.cFILE IS NOT NULL and mbf.fVISABLE = 1)  dt2 on dt1.cBUKKEN = dt2.cBUKKEN ;";
                //using (MySqlDataAdapter adap = new MySqlDataAdapter(str_bukken, con))
                //{
                //    adap.Fill(dt_bukken);
                //}

                str_bukken = " SELECT rb.cBUKKEN as cBUKKEN ";
                str_bukken += "  from r_bukken as rb";
                str_bukken += " LEFT join r_bu_mitsu as rbs on rb.cBUKKEN = rbs.cBUKKEN ";
                str_bukken += " LEFT JOIN m_bu_file mbf on  rb.cBUKKEN = mbf.cBUKKEN  and mbf.cFILE = rb.cFILE and mbf.fVISABLE=1 ";
                str_bukken += " LEFT JOIN m_File mf On mf.cFILE = mbf.cFILE  ";
                str_bukken += " LEFT join m_j_tantousha as mt ";
                str_bukken += " on rb.cTANTOUSHA = mt.cTANTOUSHA ";
                str_bukken += " where 1=1 " + sql1 + sql2 + sql3 + sql4 + sql5;
                str_bukken += " group by rb.cBUKKEN order by rb.cBUKKEN desc ;  ";
                try
                {

                    //using (MySqlDataAdapter adap = new MySqlDataAdapter(str_bukken, con))
                    //{

                    //    adap.Fill(dt_bukken);
                    //}
                    con.Open();
                    MySqlCommand command = new MySqlCommand(str_bukken, con);

                    // Setting command timeout to 10 seconds
                    command.CommandTimeout = 0;
                    try
                    {
                        MySqlDataAdapter adap = new MySqlDataAdapter(command);
                        adap.Fill(dt_bukken);
                    }
                    catch (Exception ex)
                    {

                    }
                    con.Close();
                }
                catch (Exception ex)
                {

                }
            }

            return dt_bukken;
        }

        public DataTable KomokuSetting()
        {
            ReadConn();
            DataTable dt_komoku = new DataTable();
            try
            {
                string komokusql = "SELECT sHYOUJI FROM m_hyoujikomoku where cLIST='" + cListId + "' and fHYOUJI=0 order by nORDER;";
                con.Open();
                using (MySqlDataAdapter adap = new MySqlDataAdapter(komokusql, con))
                {
                    adap.Fill(dt_komoku);
                }
                con.Close();
            }
            catch
            {
                con.Close();
            }
            return dt_komoku;
        }

        public string BukkenKomuku()
        {
            string str_komoku = "";
            Boolean komokuflag = false;
            cListId = "1";
            DataTable Bukkenkomokudt = KomokuSetting();

            foreach (DataRow dr in Bukkenkomokudt.Rows)
            {
                if (dr["sHYOUJI"].ToString() == "物件コード")
                {

                    str_komoku += " , ifnull(rb.cBUKKEN,'') as 'コード'";
                    // label_joken.Contains("作成日start")

                    if (dr["sHYOUJI"].ToString().Contains(sortkomoku))
                    {
                        komokuflag = true;
                        sortkomoku = "rb.cBUKKEN";
                    }
                }
                if (dr["sHYOUJI"].ToString() == "物件名")
                {

                    str_komoku += ",  ifnull(rb.sBUKKEN,'') as '" + dr["sHYOUJI"] + "'";
                    if (dr["sHYOUJI"].ToString() == sortkomoku)
                    {
                        komokuflag = true;
                        sortkomoku = "rb.sBUKKEN";
                    }
                }
                if (dr["sHYOUJI"].ToString() == "備考")
                {

                    str_komoku += ",ifnull( sBIKOU,'') as '" + dr["sHYOUJI"] + "'";
                    if (dr["sHYOUJI"].ToString() == sortkomoku)
                    {
                        komokuflag = true;
                        sortkomoku = "sBIKOU";
                    }
                }
                if (dr["sHYOUJI"].ToString() == "見積")
                {
                    komokuflag = true;
                    str_komoku += ", if(count(rbs.cMITUMORI) =0,null,count(rbs.cMITUMORI)) as '" + dr["sHYOUJI"] + "'";
                    if (dr["sHYOUJI"].ToString() == sortkomoku)
                    {
                        sortkomoku = "rbs.cMITUMORI";
                    }
                }
                if (dr["sHYOUJI"].ToString() == "得意先名")
                {

                    str_komoku += ", ifnull(sTOKUISAKI,'') as '" + dr["sHYOUJI"] + "'";
                    if (dr["sHYOUJI"].ToString() == sortkomoku)
                    {
                        komokuflag = true;
                        sortkomoku = "sTOKUISAKI";
                    }
                }
                if (dr["sHYOUJI"].ToString() == "得意先担当")
                {

                    str_komoku += ", ifnull(sTOKUISAKI_TAN,'') as '" + dr["sHYOUJI"] + "'";
                    if (dr["sHYOUJI"].ToString() == sortkomoku)
                    {
                        komokuflag = true;
                        sortkomoku = "sTOKUISAKI_TAN";
                    }
                }
                if (dr["sHYOUJI"].ToString() == "自社担当")
                {

                    str_komoku += ", ifnull(mt.sTANTOUSHA,'') as '" + dr["sHYOUJI"] + "'";
                    if (dr["sHYOUJI"].ToString() == sortkomoku)
                    {
                        komokuflag = true;
                        sortkomoku = "mt.sTANTOUSHA";
                    }
                }
                if (dr["sHYOUJI"].ToString() == "物件作成日")
                {

                    str_komoku += ", ifnull(date_format(dCREATE,'%Y/%m/%d'),'') as '" + dr["sHYOUJI"] + "'";
                    if (dr["sHYOUJI"].ToString() == sortkomoku)
                    {
                        komokuflag = true;
                        sortkomoku = "dCREATE";
                    }
                }
                if (dr["sHYOUJI"].ToString() == "画像")
                {
                    // komokuflag = true;
                    str_komoku += ", '' as '画像'";
                }
            }
            if (komokuflag != true)
            {
                sortkomoku = "";
            }
            return str_komoku;
        }

        public DataTable SubBukkenData()
        {
            ReadConn();
            DataTable dt_subBukken = new DataTable();
            try
            {
                string sqlmitsumori = "SELECT ifnull(rm.cMITUMORI,'') as cMITUMORI ";
                //sqlmitsumori += motsumoriSetting;
                sqlmitsumori += " ,ifnull(rm.cMITUMORI ,'') as '見積コード',ifnull(rm.sMITUMORI,'')as '見積名'";
                sqlmitsumori += " ,ifnull(mjt.sTANTOUSHA,'') as '営業担当'";
                sqlmitsumori += " ,ifnull(date_format(rm.dMITUMORISAKUSEI,'%Y/%m/%d'),'') as '見積日'";
                sqlmitsumori += " , FORMAT(rm.nKINGAKU, 'C0') 合計金額";
                sqlmitsumori += " ,case IFNULL(rm.cJYOTAI_MITUMORI,'') ";
                sqlmitsumori += " when '00' then '失注' when '01' then '見積提出済'";
                sqlmitsumori += " when '02' then '受注' when '03' then '完了' ";
                sqlmitsumori += " when '04' then '見積作成中'";
                sqlmitsumori += " when '05' then 'キャンセル'";
                sqlmitsumori += " when '06' then '売上済み' else '' end   as 見積状態";
                sqlmitsumori += " ,FORMAT(rm.nMITUMORIARARI, 'C0') 金額粗利 ";
                sqlmitsumori += " FROM r_bukken rb ";
                sqlmitsumori += " left join r_bu_mitsu as rbm on rb.cBUKKEN = rbm.cBUKKEN";
                sqlmitsumori += " join r_mitumori as rm on rm.cMITUMORI = rbm.cMITUMORI";
                sqlmitsumori += " left join m_j_tantousha as mjt on rm.cEIGYOTANTOSYA = mjt.cTANTOUSHA ";
                sqlmitsumori += " where rb.cBUKKEN = " + bukkenId + " order by rm.dMITUMORISAKUSEI desc; ";
                con.Open();
                using (MySqlDataAdapter adap = new MySqlDataAdapter(sqlmitsumori, con))
                {
                    adap.Fill(dt_subBukken);
                }
                con.Close();
            }
            catch
            {
                con.Close();
            }
            return dt_subBukken;

        }

        public bool MitsumoriCopy()
        {
            ReadConn();
            JC99NavBar_Class jc99class = new JC99NavBar_Class();
            jc99class.loginId = loginId;
            jc99class.FindLoginName();
            int retval = 0;
            bool fcopy = false;
            try
            {
                DataTable dt_MiMax = new DataTable();
                string mistu_code = "";
                string sqlStr = "SELECT ifnull(max(cMITUMORI),0) as id FROM r_bu_mitsu order by cMITUMORI desc;";
                con.Open();
                using (MySqlDataAdapter adap = new MySqlDataAdapter(sqlStr, con))
                {
                    adap.Fill(dt_MiMax);
                }
                con.Close();
                if (dt_MiMax.Rows.Count > 0)
                {
                    mistu_code = (Convert.ToInt32(dt_MiMax.Rows[0][0].ToString()) + 1).ToString();
                    mistu_code = mistu_code.PadLeft(10, '0');
                }

                //r_mitumori　見積データ
                string sqlmitsuCopy = "";
                sqlmitsuCopy += "INSERT INTO r_mitumori (SELECT ('" + mistu_code + "') as cMITUMORI,('01') as cMITUMORI_KO,cTOKUISAKI,sTOKUISAKI,sTOKUISAKITEL,sTOKUISAKIFAX,sTOKUISAKIYUBIN,";
                sqlmitsuCopy += " null as sTOKUISAKI_TAN,sTOKUISAKI_TAN_Jun,null sTOKUISAKI_TANBUMON,null sTOKUISAKI_YAKUSHOKU,null sTOKUISAKI_KEISYO,";
                sqlmitsuCopy += " cEIGYOTANTOSYA,null as cSEISAKUTANTOSYA,cSAKUSEISYA,(SELECT NOW()) as dMITUMORISAKUSE,sMITUMORI ,";
                sqlmitsuCopy += " cBUMON,null as sBIKOU,sMITUMORINOKI,'3ヶ月間' as sMITUMORIYUKOKIGEN,'01' as cSHIHARAI,fSAMA,'御社指定場所' as sUKEWATASIBASYO,nKINGAKU,nTOKUISAKIKAKERITU,";
                sqlmitsuCopy += "nMITUMORIARARI,nMITUMORINEBIKI,(nKINGAKU*10/100) as nMITUMORISYOHIZE,'0' nHENKOU,null as cSHIGOTO,(SELECT NOW()) dHENKOU,cHENKOUSYA,(nKINGAKU+(nKINGAKU*10/100)) nKINGAKU_G,";
                sqlmitsuCopy += "nMITUMORINEBIKI_G,nTANKA_G,nKIRI_G,nSIIRE_G,'04' cJYOTAI_MITUMORI,cSEIKYUSAKI,sSEIKYUSAKI,null cSEIKYUSAKI_TKC,cSEIKYU_YUUBIN,sSEIKYU_JUUSHO1,null sSEIKYU_JUUSHO2,";
                sqlmitsuCopy += "sSEIKYU_TEL,sSEIKYU_FAX,sSEIKYU_TAN,null sSEIKYU_TAN_Jun,null sSEIKYU_TANBUMON,null sSEIKYU_KEISYO,null sSEIKYU_YAKUSYOKU,";
                sqlmitsuCopy += "cSHIHARAI_SEIKYU,sSHIMEBI,null sSEIKYU_BIKOU,'10' as sSEIKYU_SHIHARAIBI,sSEIKYU_SHIHARAIGETU,fHYOUJI,fYOUKOU,'01' cSHIHARAI_STOKUI,'締め支払' sSHIHARAI_STOKUI,sTOKUISAKIJUSYO,";
                sqlmitsuCopy += "null YU_dURIYOTEI,null YU_dJISSEKINOUKI,null dJISSEKINOUKI,null dYOTEINOUKI,null dKETSUTEI,fSYUUKEI,null dINVOICE,null dSEIKYUUSHO,null as sMEMO,null as cKYOTEN,";
                sqlmitsuCopy += "cPJ,fNO,null as dURIAGEYOTEI,null as dKANRYOUYOTEI,'0.00' as nURIAGEKINGAKU,nKAZEIKINGAKU,fKAKUTEI,null as sKOUMOKU1,null as sKOUMOKU2,null as sKOUMOKU3,";
                sqlmitsuCopy += "null as sKOUMOKU4,fGKANRYOU,null as cKAKUDO,fSAKUSEISYA,'50.00' nRIIRITSU,null as sMITUMORIKENMEI FROM r_mitumori WHERE cMITUMORI = '" + mitsumoriId + "'); ";

                //r_bu_mitsu 物件デーブルーとと見積テーブルの連係
                sqlmitsuCopy += "INSERT INTO r_bu_mitsu (SELECT cBUKKEN, ('" + mistu_code + "') as cMITUMORI,(SELECT NOW()) dHENKOU,cHENKOUSYA FROM r_bu_mitsu WHERE cBUKKEN ='" + bukkenId + "' and cMITUMORI='" + mitsumoriId + "');";

                //h_mitumori 見積履歴
                sqlmitsuCopy += "INSERT INTO h_mitumori (cMITUMORI, cMITUMORI_KO, nJUNBAN, sNAIYOU, dHENKOU, cHENKOUSYA) VALUES ('" + mistu_code + "', '01', '1', '新規入力', Now(), '" + JC99NavBar_Class.Login_Tan_Code + "'); ";

                //r_mitumori_m 見積商品
                sqlmitsuCopy += "INSERT INTO r_mitumori_m (SELECT ('" + mistu_code + "') as cMITUMORI,('01') as cMITUMORI_KO,nGYOUNO,cSYOUHIN,sSYOUHIN_R,nTANKA,nSURYO,sTANI,nSIIRETANKA,nKINGAKU,nRITU,";
                sqlmitsuCopy += "(SELECT NOW()) dHENKOU,cHENKOUSYA,cSHIIRESAKI,sSHIIRESAKI,nSIIREKINGAKU,nSIKIRITANKA,nSIKIRIKINGAKU,nINSATSU_GYO,cSYOUSAI,sSETSUMUI,fJITAIS,fJITAIQ,";
                sqlmitsuCopy += "rowNO,sMEMO,fCHECK,fgentankatanka,sKUBUN FROM r_mitumori_m WHERE  cMITUMORI='" + mitsumoriId + "');";

                MySqlCommand myCommand = new MySqlCommand(sqlmitsuCopy, con);
                con.Open();
                retval = myCommand.ExecuteNonQuery();
                if (retval != -1)
                {
                    fcopy = true;
                }
                con.Close();
            }
            catch
            {
                con.Close();
            }
            
            return fcopy;
        }

        public string cMitumori()
        {
            ReadConn();
            DataTable dt_MiMax = new DataTable();
            string mistu_code = "";
            try
            {
                string sqlStr = "SELECT ifnull(max(cMITUMORI),0) as id FROM r_bu_mitsu order by cMITUMORI desc;";
                con.Open();
                using (MySqlDataAdapter adap = new MySqlDataAdapter(sqlStr, con))
                {
                    adap.Fill(dt_MiMax);
                }

                if (dt_MiMax.Rows.Count > 0)
                {
                    mistu_code = (Convert.ToInt32(dt_MiMax.Rows[0][0].ToString())).ToString();
                    mistu_code = mistu_code.PadLeft(10, '0');
                }
                con.Close();
            }
            catch
            {
                con.Close();

            }
            return mistu_code;
        }

        public bool MitsumoriDelete()
        {
            ReadConn();
            int retval = 0;
            bool fdelete = false;
            try
            {
                string sqlmitsuDel = "";
                sqlmitsuDel += "DELETE from r_bu_mitsu where cBUKKEN='" + bukkenId + "' and cMITUMORI='" + mitsumoriId + "';";
                sqlmitsuDel += "DELETE from h_mitumori where cMITUMORI='" + mitsumoriId + "';";
                sqlmitsuDel += "DELETE from r_mitumori where cMITUMORI='" + mitsumoriId + "';";
                sqlmitsuDel += "DELETE from r_mitumori_m where cMITUMORI='" + mitsumoriId + "';";

                //関連している売上も削除

                MySqlCommand myCommand = new MySqlCommand(sqlmitsuDel, con);
                con.Open();
                retval = myCommand.ExecuteNonQuery();
                con.Close();
                if (retval != -1)
                {
                    fdelete = true;
                }
            }
            catch
            {
                con.Close();
            }
            return fdelete;
        }

        public string MitsumoriKoumokuSetting()
        {
            string str_komoku = "";
            string motsumoriSetting = "";
            cListId = "2";
            DataTable dt = KomokuSetting();
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["sHYOUJI"].ToString() == "見積コード")
                {
                    str_komoku += " , ifnull(rm.cMITUMORI,'') as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "見積名")
                {
                    str_komoku += " , ifnull(rm.sMITUMORI,'') as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "社内メモ")
                {
                    str_komoku += " , ifnull(rm.sMEMO,'') as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "見積書備考")
                {
                    str_komoku += " , ifnull(rm.sBIKOU,'') as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "得意先名")
                {
                    str_komoku += " , ifnull(rm.sTOKUISAKI,'') as '" + dr["sHYOUJI"] + "' ";
                }
                if (dr["sHYOUJI"].ToString() == "得意先担当")
                {
                    str_komoku += " , ifnull(rm.sTOKUISAKI_TAN,'') as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "見積日")
                {
                    str_komoku += " , ifnull(date_format(rm.dMITUMORISAKUSEI,'%Y/%m/%d'),'') as '" + dr["sHYOUJI"] + "' ";
                }
                if (dr["sHYOUJI"].ToString() == "営業担当")
                {
                    str_komoku += " , ifnull(mjt.sTANTOUSHA,'') as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "見積状態")
                {
                    str_komoku += " ,case IFNULL(rm.cJYOTAI_MITUMORI, '') ";
                    str_komoku += " when '00' then '失注' when '01' then '見積提出済'";
                    str_komoku += " when '02' then '受注' when '03' then '完了' ";
                    str_komoku += " when '04' then '見積作成中' when '05' then 'キャンセル'";
                    str_komoku += " when '06' then '売上済み'";
                    str_komoku += " else '' end  as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "合計金額")
                {
                    str_komoku += " , FORMAT(rm.nKINGAKU, 'C0') as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "粗利")
                {
                    str_komoku += " , FORMAT(rm.nMITUMORIARARI, 'C0') as '金額粗利' ";
                }

                if (dr["sHYOUJI"].ToString() == "作成者")
                {
                    str_komoku += " , ifnull(mjt1.sTANTOUSHA,'')  as '" + dr["sHYOUJI"] + "'";
                }
                if (dr["sHYOUJI"].ToString() == "画像")
                {
                    str_komoku += " ,  ''  as '" + dr["sHYOUJI"] + "'";
                }
            }
            return str_komoku;
        }

        public DataTable HomeMitsumori()
        {
            DataTable dt_mitsumori = new DataTable();
            try
            {
                ReadConn();
                JC99NavBar_Class jc99class = new JC99NavBar_Class();
                jc99class.loginId = loginId;
                jc99class.FindLoginName();
                string motsumoriSetting = MitsumoriKoumokuSetting();
               
                String sqlmitsumori = "";
                sqlmitsumori += "SELECT ifnull(rm.cMITUMORI,'') as cMITUMORI ";
                sqlmitsumori += motsumoriSetting;
                sqlmitsumori += " ,ifnull(mf.cFILE, '') as cFILE ";
                sqlmitsumori += " ,ifnull(mf.sFILE, '') as sFILE  ";
                sqlmitsumori += " ,ifnull(mf.sPATH_SERVER_SOURCE, '') as sPATH_SERVER_SOURCE ";
                sqlmitsumori += " , '' as file64string ";
                sqlmitsumori += " FROM  r_mitumori as rm ";
                sqlmitsumori += " LEFT JOIN m_j_tantousha as mjt on rm.cEIGYOTANTOSYA = mjt.cTANTOUSHA ";
                sqlmitsumori += " LEFT JOIN m_j_tantousha as mjt1 on rm.cSAKUSEISYA = mjt1.cTANTOUSHA ";
                sqlmitsumori += " LEFT JOIN m_mitsu_file mmf ON mmf.cMITUMORI = rm.cMITUMORI  and mmf.fVISABLE = '1' and mmf.fINSATSU = '1' ";
                sqlmitsumori += " LEFT JOIN m_file mf ON mf.cFILE = mmf.cFILE ";
                sqlmitsumori += " Where rm.cEIGYOTANTOSYA ='" + jc99class.login_Code + "'";
                sqlmitsumori += " order by rm.cMITUMORI desc Limit 10 ";
                con.Open();
                using (MySqlDataAdapter adap = new MySqlDataAdapter(sqlmitsumori, con))
                {
                    adap.Fill(dt_mitsumori);
                }
                con.Close();
            }
            catch
            {
                con.Close();
            }
            
            
            return dt_mitsumori;
        }

       /* public DataTable Mitsumori()
        {
            ReadConn();
            JC99NavBar_Class jc99class = new JC99NavBar_Class();
            jc99class.loginId = loginId;
            jc99class.FindLoginName();
            string motsumoriSetting = MitsumoriKoumokuSetting();
            DataTable dt_mitsumori = new DataTable();
            if (motsumoriSetting != "")
            {
                String sqlmitsumori = "";
                sqlmitsumori += "SELECT rm.cMITUMORI as cMITUMORI, ";
                sqlmitsumori += motsumoriSetting;
                sqlmitsumori += " ,ifnull(mf.cFILE, '') as cFILE ";
                sqlmitsumori += " ,ifnull(mf.sFILE, '') as sFILE  ";               
                sqlmitsumori += " ,ifnull(mf.sPATH_SERVER_SOURCE, '') as sPATH_SERVER_SOURCE ";
                sqlmitsumori += " , '' as file64string ";
                sqlmitsumori += " FROM  r_mitumori as rm ";
                sqlmitsumori += " LEFT JOIN m_j_tantousha as mjt on rm.cEIGYOTANTOSYA = mjt.cTANTOUSHA ";
                sqlmitsumori += " LEFT JOIN m_j_tantousha as mjt1 on rm.cSAKUSEISYA = mjt1.cTANTOUSHA ";
                sqlmitsumori += " LEFT JOIN m_mitsu_file mmf ON mmf.cMITUMORI = rm.cMITUMORI  and mmf.fVISABLE = '1' and mmf.fINSATSU = '1' ";
                sqlmitsumori += " LEFT JOIN m_file mf ON mf.cFILE = mmf.cFILE ";
                sqlmitsumori += " Where rm.cEIGYOTANTOSYA ='" + jc99class.login_Code + "'";
                sqlmitsumori += " order by rm.cMITUMORI desc Limit 10 ";

                using (MySqlDataAdapter adap = new MySqlDataAdapter(sqlmitsumori, con))
                {
                    adap.Fill(dt_mitsumori);
                }
            }

            return dt_mitsumori;
        }*/

        public DataTable MitsumoriList(string searchSql)
        {
            DataTable dt_mitsumori_list = new DataTable();
            MySqlConnection cn_customer = new MySqlConnection("Server=" + DBUtilitycs.Server + "; Database=" + ConstantVal.DB_NAME + "; User Id=" + DBUtilitycs.user + "; password=" + DBUtilitycs.pass);
            try
            {
                   string str_mitumori = "select * from "
                     + "(select "
                    + " ifnull(m.cMITUMORI, '') as 見積コード,"
                    + " ifnull(m.sMITUMORI, '') as 見積名,"
                    + " ifnull(mjt.sTANTOUSHA, '') as 営業担当,"
                    + "	ifnull(mt.sTANTOUSHA, '') as 作成者,"
                    + " date_format(m.dMITUMORISAKUSEI, '%y/%m/%d') as 見積日,"
                    + " ifnull(m.nKINGAKU, '') as 合計金額,"
                    + " case IFNULL(m.cJYOTAI_MITUMORI, '')"
                    + " when '00' then '失注' when '01' then '見積提出済' when '02' then '受注' when '03' then '完了'  when '04' then '見積作成中' when '05' then 'キャンセル' when '06' then '売上済み' else '' end as 見積状態,"
                    + " ifnull(CC.nMITUMORIARARI, 0) 金額粗利,"
                    + " ifnull(m.sMEMO, '') as 社内メモ,"
                    + " ifnull(m.sBIKOU, '') as 見積書備考,"
                    + " ifnull(m.sTOKUISAKI, '') as 得意先名,"
                    + " ifnull(m.sTOKUISAKI_TAN, '') as 得意先担当,"
                    + "'' as 画像,"
                    + " '' as file64string "
                    + " from r_mitumori m"
                    + " LEFT JOIN (SELECT b.cMITUMORI as cmitu, b.cBUKKEN as cBUKKEN, sum(c.nMITUMORIARARI) nMITUMORIARARI from R_BUKKEN as r_bukken"
                    + " LEFT JOIN r_bu_mitsu b ON b.cBUKKEN = r_bukken.cBUKKEN LEFT JOIN m_file mfb ON mfb.cFILE = r_bukken.cFILE"
                    + " LEFT JOIN R_MITUMORI c ON b.cMITUMORI = c.cMITUMORI GROUP BY c.cMITUMORI) CC ON m.cMITUMORI = CC.cMITU"
                    + " left join m_j_tantousha mjt ON m.cEIGYOTANTOSYA = mjt.cTANTOUSHA"
                    + " left join m_j_tantousha as mt ON m.cSAKUSEISYA = mt.cTANTOUSHA"
                    + " where 1 = 1 "
                    + " AND ifnull(m.fHYOUJI, '0') = '0'";
                if (searchSql != "")
                {
                    str_mitumori += searchSql;
                }
                str_mitumori += " group by m.cMITUMORI";
                str_mitumori += " order by CC.cBUKKEN DESC, m.cMITUMORI DESC)dt1";
                str_mitumori += " LEFT JOIN(SELECT rm.cMITUMORI, mf.cFILE, mf.sFILE, mf.sPATH_SERVER_SOURCE ";
                str_mitumori += " FROM r_mitumori rm ";
                str_mitumori += " LEFT JOIN m_mitsu_file mmf on mmf.cMITUMORI = rm.cMITUMORI ";
                str_mitumori += " LEFT JOIN m_file mf on mf.cFILE = mmf.cFILE ";
                str_mitumori += " Where mmf.fVISABLE = 1) dt2 on dt1.見積コード = dt2.cMITUMORI ";
                str_mitumori += " group by 見積コード order by 見積コード desc";
                using (MySqlDataAdapter adap = new MySqlDataAdapter(str_mitumori, cn_customer))
                {
                    adap.Fill(dt_mitsumori_list);
                }
                cn_customer.Close();
            }
            catch
            {
                cn_customer.Close();
            }

            return dt_mitsumori_list;
        }
        public DataTable MitsumoriList_syouhin(string searchSql)
        {
            DataTable dt_mitsumori_list = new DataTable();
            MySqlConnection cn_customer = new MySqlConnection("Server=" + DBUtilitycs.Server + "; Database=" + ConstantVal.DB_NAME + "; User Id=" + DBUtilitycs.user + "; password=" + DBUtilitycs.pass);
            try
            {
                string str_mitumori = "select * from "
                    + "(select "
                   + " ifnull(m.cMITUMORI, '') as 見積コード,"
                   + " ifnull(m.sMITUMORI, '') as 見積名,"
                  + " ifnull(mjt.sTANTOUSHA, '') as 営業担当,"
                   + "	ifnull(mt.sTANTOUSHA, '') as 作成者,"
                   + " date_format(m.dMITUMORISAKUSEI, '%y/%m/%d') as 見積日,"
                   + " ifnull(m.nKINGAKU, '') as 合計金額,"
                   + " case IFNULL(m.cJYOTAI_MITUMORI, '')"
                   + " when '00' then '失注' when '01' then '見積提出済' when '02' then '受注' when '03' then '完了'  when '04' then '見積作成中' when '05' then 'キャンセル' when '06' then '売上済み' else '' end as 見積状態,"
                   + " ifnull(CC.nMITUMORIARARI, 0) 金額粗利,"
                   + " ifnull(m.sMEMO, '') as 社内メモ,"
                   + " ifnull(m.sBIKOU, '') as 見積書備考,"
                   + " ifnull(m.sTOKUISAKI, '') as 得意先名,"
                   + " ifnull(m.sTOKUISAKI_TAN, '') as 得意先担当,"
                   + "'' as 画像,"
                   + " '' as file64string "
                   + " from r_mitumori m"
                   + " LEFT JOIN (SELECT b.cMITUMORI as cmitu, b.cBUKKEN as cBUKKEN, sum(c.nMITUMORIARARI) nMITUMORIARARI from R_BUKKEN as r_bukken"
                   + " LEFT JOIN r_bu_mitsu b ON b.cBUKKEN = r_bukken.cBUKKEN LEFT JOIN m_file mfb ON mfb.cFILE = r_bukken.cFILE"
                   + " LEFT JOIN R_MITUMORI c ON b.cMITUMORI = c.cMITUMORI GROUP BY c.cMITUMORI) CC ON m.cMITUMORI = CC.cMITU"
                   + " left join m_j_tantousha mjt ON m.cEIGYOTANTOSYA = mjt.cTANTOUSHA"
                   + " left join r_mitumori_m rmm on m.cMITUMORI = rmm.cMITUMORI"
                   + " left join m_syouhin syouhin on rmm.cSYOUHIN = syouhin.cSYOUHIN"
                   + " left join m_j_tantousha as mt ON m.cSAKUSEISYA = mt.cTANTOUSHA"
                   + " where 1 = 1 "
                   + " AND ifnull(m.fHYOUJI, '0') = '0'";
                if (searchSql != "")
                {
                    str_mitumori += searchSql;
                }
                str_mitumori += " group by m.cMITUMORI";
                str_mitumori += " order by CC.cBUKKEN DESC, m.cMITUMORI DESC)dt1";
                str_mitumori += " LEFT JOIN(SELECT rm.cMITUMORI, mf.cFILE, mf.sFILE, mf.sPATH_SERVER_SOURCE ";
                str_mitumori += " FROM r_mitumori rm ";
                str_mitumori += " LEFT JOIN m_mitsu_file mmf on mmf.cMITUMORI = rm.cMITUMORI ";
                str_mitumori += " LEFT JOIN m_file mf on mf.cFILE = mmf.cFILE ";
                str_mitumori += " Where mmf.fVISABLE = 1) dt2 on dt1.見積コード = dt2.cMITUMORI ";
                str_mitumori += " group by 見積コード order by 見積コード desc";
                using (MySqlDataAdapter adap = new MySqlDataAdapter(str_mitumori, cn_customer))
                {
                    adap.Fill(dt_mitsumori_list);
                }
                cn_customer.Close();
            }
            catch
            {
                cn_customer.Close();
            }

            return dt_mitsumori_list;
        }

        /*public DataTable imgMitsumoriTable()
        {
            ReadConn();
            DataTable dt = new DataTable();
            string sql = " SELECT rm.cMITUMORI ";
            sql += " ,mf.sPATH_SERVER_SOURCE ";
            sql += "  FROM r_mitumori rm";
            sql += " LEFT JOIN m_mitsu_file mmf on mmf.cMITUMORI = rm.cMITUMORI  ";
            sql += " LEFT JOIN m_file mf on mf.cFILE = mmf.cFILE";
            sql += " Where mmf.fVISABLE = 1 and rm.cMITUMORI in (" + mitsumoriList + ")";
            using (MySqlDataAdapter adap = new MySqlDataAdapter(sql, con))
            {
                adap.Fill(dt);
            }
            return dt;
        }*/

        public string FindBukkenID()
        {
            string retval = "";
            try
            {
                ReadConn();
                DataTable dt = new DataTable();               
                string sql = "";
                sql = "SELECT cBUKKEN from r_bu_mitsu where cMITUMORI='" + mitsumoriId + "'";
                con.Open();
                using (MySqlDataAdapter adap = new MySqlDataAdapter(sql, con))
                {
                    adap.Fill(dt);
                }
                con.Close();
                if (dt.Rows.Count > 0)
                {
                    retval = dt.Rows[0]["cBUKKEN"].ToString();

                }
            }
            catch
            {
                con.Close();
            }
            return retval;
        }
    }
}