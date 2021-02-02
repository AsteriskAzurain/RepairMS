using DataAccess.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RepairMS
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            projectDetailBLL bll = new projectDetailBLL();
            bll.assignRepairMan(1,1);
        }
    }
}