﻿/*作成者：ナン
 *作成日：20210901
 */
using Common;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    public class JC25Shiharaihouhou_Class
    {
        MySqlConnection con = new MySqlConnection("Server=" + DBUtilitycs.Server + "; Database=" + DBUtilitycs.Database + "; User Id=" + DBUtilitycs.user + "; password=" + DBUtilitycs.pass);
        public string loginId { get; set; }

        public void ReadConn()
        {            
            con = new MySqlConnection("Server=" + DBUtilitycs.Server + "; Database=" + ConstantVal.DB_NAME + "; User Id=" + DBUtilitycs.user + "; password=" + DBUtilitycs.pass);

        }
        public DataTable ShiaraiListTable(string sqlstring)
        {
            ReadConn();
            DataTable dt = new DataTable();
            try
            {
                con.Open();
                using (MySqlDataAdapter adap = new MySqlDataAdapter(sqlstring, con))
                {
                    adap.Fill(dt);
                }
                con.Close();
            }
            catch
            {
                con.Close();
            }
            return dt;
        }

        public bool ShiaraiListListSql(string sqlStr)
        {
            ReadConn();
            int retval = 0;
            bool fret = false;
            try
            {
                MySqlCommand myCommand = new MySqlCommand(sqlStr, con);
                con.Open();
                retval = myCommand.ExecuteNonQuery();
                con.Close();
                if (retval == -1)
                {
                    fret = false;
                }
                else
                {
                    fret = true;
                }
            }
            catch
            {
                con.Close();
            }
            return fret;
        }
    }
}
