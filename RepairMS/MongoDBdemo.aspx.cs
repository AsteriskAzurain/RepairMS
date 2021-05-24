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
            if (!IsPostBack)
            {
                employeeTable Antonio = eBLL.getEEinfoById(1);
                if (Antonio.employeeID == 0) testInsert();
            }
        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            testInsert2();
            testDelete();
        }

        private void testInsert()
        {
            employeeTable einfo = new employeeTable();
            einfo.employeeID = -1;
            einfo.employeeName = "Antonio";
            einfo.password = "111111";
            System.Diagnostics.Debug.WriteLine("----insert----");
            System.Diagnostics.Debug.WriteLine("Success? " + eBLL.testInsert(einfo).ToString());
            if (einfo.employeeID != 1) RadAjaxManager1.Alert("Antonio needs to be updated.");
        }

        private void testGetAll()
        {
            eBLL.testGetAll();
        }

        private void testGetOne()
        {
            int eid = 12;
            employeeTable einfo = eBLL.getEEinfoById(eid);
        }

        private void testInsert2()
        {
            System.Diagnostics.Debug.WriteLine("----insert----");
            employeeTable einfo = new employeeTable();
            einfo.employeeID = -1;
            einfo.employeeName = "Leila";
            einfo.password = "111111";
            System.Diagnostics.Debug.WriteLine("Success? " + eBLL.testInsert(einfo).ToString());
            System.Diagnostics.Debug.WriteLine(einfo.employeeID);

            System.Diagnostics.Debug.WriteLine("----update----");
            employeeTable eupd = new employeeTable();
            eupd = eBLL.getEEinfoById(1);
            eupd.password = "123456";
            System.Diagnostics.Debug.WriteLine("Success? " + eBLL.testUpdateOne(eupd).ToString());
            System.Diagnostics.Debug.WriteLine(eupd.password);

            System.Diagnostics.Debug.WriteLine("----update id12----");
            employeeTable eupd12 = new employeeTable();
            eupd12 = eBLL.getEEinfoById(12);
            eupd12.password = "123456";
            System.Diagnostics.Debug.WriteLine("Success? " + eBLL.testUpdateOne(eupd12).ToString());
            System.Diagnostics.Debug.WriteLine(eupd12.password);
        }

        private void testDelete()
        {
            System.Diagnostics.Debug.WriteLine("----delete----");
            int eid = 1;
            System.Diagnostics.Debug.WriteLine("Success? " + eBLL.testDeleteOne(eid).ToString());

            System.Diagnostics.Debug.WriteLine("----delete id20----");
            eid = 20;
            System.Diagnostics.Debug.WriteLine("Success? " + eBLL.testDeleteOne(eid).ToString());
        }

    }
}