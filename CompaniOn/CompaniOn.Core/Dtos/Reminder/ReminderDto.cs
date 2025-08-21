using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Dtos.Reminder
{
    public class ReminderDto : BaseDto
    {
        public User User { get; set; } = null!;
        public int UserId { get; set; }

        public string Type { get; set; } // Medication, Appointment

        public string Message { get; set; }

        public DateTime Time { get; set; }

        public bool Repeat { get; set; }

        public bool isAcknowledged { get; set; }
    }
}
