using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Data.SqlClient;
using Ext.Net;

namespace ExtGridPanelPaging
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int RowCount, PageCount;

                StoreCustomers.DataSource = this.GetData(
                    1, 
                    1000, 
                    out RowCount, 
                    out PageCount);

                StoreCustomers.DataBind();
                lblPageCount.Text = PageCount.ToString();
            }
        }



        public void OnPageIndexChanged(object sender, DirectEventArgs e)
        {
            int RowCount, PageCount;
            int PageIndex = int.Parse(e.ExtraParams["pageIndex"].ToString());
            StoreCustomers.DataSource = this.GetData(
                PageIndex,
                1000,
                out RowCount,
                out PageCount);
            StoreCustomers.DataBind();
            lblPageCount.Text = PageCount.ToString();
        }




        public DataTable GetData
            (
            int PageIndex,
            int PageSize,
            out int RowCount,
            out int PageCount
            )
        {

            DataSet dataset = new DataSet();
            string execsql = string.Format(@"
                                DECLARE @RowCount int,@PageCount int
                                EXEC	[dbo].[GetCustomers]
                                        @PageIndex = {0},
		                                @PageSize = {1},
		                                @RowCount = @RowCount OUTPUT,
		                                @PageCount = @PageCount OUTPUT

                                SELECT	@RowCount as N'@RowCount',
		                                @PageCount as N'@PageCount'", 
                                        PageIndex, PageSize);

            using (SqlConnection connection = new SqlConnection(
                ConfigurationManager.ConnectionStrings["PagingDB"].ConnectionString))
            {
                using (SqlDataAdapter command = new SqlDataAdapter(
                    execsql, connection))
                {
                    connection.Open();
                    command.Fill(dataset);
                    connection.Close();
                }
            }


            DataTable tblCustomers = dataset.Tables[0];
            DataTable tblParameters = dataset.Tables[1];

            RowCount = int.Parse(tblParameters.Rows[0]["@RowCount"].ToString());
            PageCount = int.Parse(tblParameters.Rows[0]["@PageCount"].ToString());

            lblInfo.Text = 
                RowCount.ToString() + " Kayıt ," + 
                PageCount.ToString() + " Sayfa";
            return tblCustomers;
        }

    }
}
