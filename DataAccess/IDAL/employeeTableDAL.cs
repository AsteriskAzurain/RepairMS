using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.IDAL
{
    public interface employeeTableDAL
    {
        DataTable GetEntityDatatable();

        employeeTable GetEntityById(int Id);

        int SaveEntity(employeeTable entity);

        void DeleteEntity(int Id);
    }
}
