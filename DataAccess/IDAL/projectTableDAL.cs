using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.IDAL
{
    public interface projectTableDAL
    {
        DataTable GetEntityDatatable();

        projectTable GetEntityById(int Id);

        int SaveEntity(projectTable entity);

        bool DeleteEntity(int Id);

        int SetEntityStatus(int id, int status);

        DataTable GetDataTableByStatus(int status);
    }
}
