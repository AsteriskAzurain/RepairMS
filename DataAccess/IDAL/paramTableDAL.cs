using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.IDAL
{
    public interface paramTableDAL
    {
        DataTable GetEntityDatatable();

        paramTable GetEntityById(int Id);

        int SaveEntity(paramTable entity);

        bool DeleteEntity(int Id);

        DataTable GetDataTabelByTypeId(int typeID);
    }
}
