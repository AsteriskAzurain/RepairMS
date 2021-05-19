using DataAccess.BLL;
using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RepairMS
{
    public partial class MongoDBdemo : System.Web.UI.Page
    {
        public readonly employeeBLL eBLL = new employeeBLL();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            testGetOne();
        }

        private void testInsert()
        {
            employeeTable einfo = new employeeTable();
            einfo.employeeID = 12;
            einfo.employeeName = "Andy";
            einfo.password = "111111";
            System.Diagnostics.Debug.WriteLine("Success? " + eBLL.testInsert(einfo).ToString());
            System.Diagnostics.Debug.WriteLine(einfo.employeeID);
        }

        private void testGetAll()
        {
            eBLL.testGetAll();
        }

        private void testGetOne() {
            int eid = 12;
            employeeTable einfo = eBLL.testGetOne(eid);
        }

    }
}