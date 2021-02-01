using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.IDAL
{
    public interface repairmanTableDAL
    {
        DataTable GetEntityDatatable();

        repairmanTable GetEntityById(int Id);

        int SaveEntity(repairmanTable entity);

        void DeleteEntity(int Id);
    }
}
