using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Interfaces.SearchObjects
{
    public class ReminderSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }
        public string? Type { get; set; }
        public DateTime? Time { get; set; }
    }
}
