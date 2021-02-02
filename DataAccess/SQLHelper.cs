using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public static class SQLHelper
    {
        private static readonly string connStr = System.Web.Configuration.WebConfigurationManager.AppSettings["CONN_DB"];

        /// <summary>执行添删改查的方法</summary>
        /// <returns>影响条数</returns>
        public static int ExecuteonQuery(string sql, params SqlParameter[] pms)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (pms != null)
                    {
                        cmd.Parameters.AddRange(pms);
                    }
                    conn.Open();
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        /// <summary>返回单个对象</summary>
        /// <returns>返回查询结果的第一行第一列的值</returns>
        public static object ExecuteScalar(string sql, params SqlParameter[] pms)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (pms != null)
                    {
                        cmd.Parameters.AddRange(pms);
                    }
                    conn.Open();
                    return cmd.ExecuteScalar();
                    //当select语句无记录返回时，ExecuteScalar()返回NULL值，无法再将null值赋给任何对象或者变量，否则出现异常
                }
            }
        }

        /// <summary>
        /// 执行查询多行多列的数据的方法
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="pms"></param>
        /// <returns></returns>
        public static SqlDataReader ExecuteReader(string sql, params SqlParameter[] pms)
        {
            SqlConnection con = new SqlConnection(connStr);
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                if (pms != null)
                {
                    cmd.Parameters.AddRange(pms);
                }
                try
                {
                    con.Open();
                    return cmd.ExecuteReader(CommandBehavior.CloseConnection);
                }
                catch (Exception)
                {
                    con.Close();
                    con.Dispose();
                    throw;
                }
            }
        }

        /// <summary>执行返回DataTable</summary>
        /// <returns>返回查询结果DataTable</returns>
        public static DataTable ExecuteDataTable(string sql, params SqlParameter[] pms)
        {
            DataTable dt = new DataTable();
            using (SqlDataAdapter adapter = new SqlDataAdapter(sql, connStr))
            {
                adapter.Fill(dt);
            }
            return dt;
        }

        /// <summary>DataReader转泛型</summary>
        /// <typeparam name="T">传入的实体类</typeparam>
        /// <param name="objReader">DataReader对象</param>
        public static IList<T> ReaderToList<T>(this IDataReader objReader)
        {
            List<T> list = new List<T>();
            Type modelType = typeof(T); //获取传入的数据类型
            while (objReader.Read())    //遍历DataReader对象
            {
                //使用与指定参数匹配最高的构造函数，来创建指定类型的实例
                T model = Activator.CreateInstance<T>();
                for (int i = 0; i < objReader.FieldCount; i++)
                {
                    if (!IsNullOrDBNull(objReader[i]))  //判断字段值是否为空或不存在的值
                    {
                        //匹配字段名
                        PropertyInfo pi = modelType.GetProperty(objReader.GetName(i), BindingFlags.GetProperty | BindingFlags.Public | BindingFlags.Instance | BindingFlags.IgnoreCase);
                        if (pi != null) pi.SetValue(model, CheckType(objReader[i], pi.PropertyType), null); //绑定实体对象中同名的字段  
                    }
                }
                list.Add(model);
            }
            return list;
        }

        /// <summary>
        /// 对可空类型进行判断转换(*要不然会报错)
        /// </summary>
        /// <param name="value">DataReader字段的值</param>
        /// <param name="conversionType">该字段的类型</param>
        private static object CheckType(object value, Type conversionType)
        {
            if (conversionType.IsGenericType && conversionType.GetGenericTypeDefinition().Equals(typeof(Nullable<>)))
            {
                if (value == null) return null;
                System.ComponentModel.NullableConverter nullableConverter = new System.ComponentModel.NullableConverter(conversionType);
                conversionType = nullableConverter.UnderlyingType;
            }
            return Convert.ChangeType(value, conversionType);
        }

        /// <summary>
        /// 判断指定对象是否是有效值
        /// </summary>
        private static bool IsNullOrDBNull(object obj)
        {
            return (obj == null || (obj is DBNull)) ? true : false;
        }

        /// <summary>
        /// DataReader转模型
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="objReader"></param>
        public static T ReaderToModel<T>(this IDataReader objReader)
        {

            using (objReader)
            {
                if (objReader.Read())
                {
                    Type modelType = typeof(T);
                    int count = objReader.FieldCount;
                    T model = Activator.CreateInstance<T>();
                    for (int i = 0; i < count; i++)
                    {
                        if (!IsNullOrDBNull(objReader[i]))
                        {
                            PropertyInfo pi = modelType.GetProperty(objReader.GetName(i), BindingFlags.GetProperty | BindingFlags.Public | BindingFlags.Instance | BindingFlags.IgnoreCase);
                            if (pi != null)
                            {
                                pi.SetValue(model, CheckType(objReader[i], pi.PropertyType), null);
                            }
                        }
                    }
                    return model;
                }
            }
            return default(T);
        }
    }
}
