using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace KP
{
    public class User
    {
        public static int OnlinePerson;
        public static string car_id;
        public static int garage;
        //foreach (DataRow row in dt_user.Rows)
        //{
        //    var Ids = row.ItemArray;
        //    foreach (int id in Ids)
        //        user_id = id;
        //}
        public static string HashPassword(string password)
        {
            using (var hash = MD5.Create())
            {
                return string.Concat(hash.ComputeHash(Encoding.UTF8.GetBytes(password)).Select(x => x.ToString("X2")));
            }
        }
        
    }
}
