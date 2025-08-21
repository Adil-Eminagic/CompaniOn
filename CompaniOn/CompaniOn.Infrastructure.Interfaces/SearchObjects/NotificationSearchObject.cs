using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Interfaces.SearchObjects
{
    public class NotificationSearchObject : BaseSearchObject
    {
        public int? SenderId { get; set; }
        public int? ReceiverId { get; set; }
    }
}
