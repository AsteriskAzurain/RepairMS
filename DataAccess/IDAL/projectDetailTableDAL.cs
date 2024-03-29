﻿using DataAccess.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.IDAL
{
    public interface projectDetailTableDAL
    {
        DataTable GetEntityDatatable();

        projectDetailTable GetEntityById(int Id);

        int SaveEntity(projectDetailTable entity);

        bool DeleteEntity(int Id);

        DataTable GetAllDetailByProjID(int projID);

        int SetEntityStatus(int id, int status);

        IList<projectDetailTable> getMyRepairProjectList(int rmID);

        IList<projectDetailTable> getMyProjectByQuery(int rmID, projectTable projInfo);
    }
}
