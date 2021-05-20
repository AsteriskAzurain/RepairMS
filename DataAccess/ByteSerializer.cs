using MongoDB.Bson.Serialization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    class ByteSerializer : IBsonSerializer
    {
        public Type ValueType
        {
            get
            {
                return typeof(byte);
            }
        }

        public object Deserialize(BsonDeserializationContext context, BsonDeserializationArgs args)
        {
            var b = (byte)context.Reader.ReadInt32();
            return b;
        }

        public void Serialize(BsonSerializationContext context, BsonSerializationArgs args, object value)
        {
            context.Writer.WriteInt32((int)(byte)value);
        }
    }
}
