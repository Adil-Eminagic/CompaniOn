using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Dtos.Reminder
{
    public class ReminderUpsertDto : BaseUpsertDto
    {
        public int UserId { get; set; }

        public string? Type { get; set; } 

        public string? Message { get; set; }

        public DateTime? Time { get; set; }

        public bool? Repeat { get; set; }

        public bool isAcknowledged { get; set; }
    }
}
