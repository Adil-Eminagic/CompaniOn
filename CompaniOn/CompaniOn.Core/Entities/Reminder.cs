using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Entities
{
    [Table("Reminder")]
    public class Reminder:BaseEntity
    {

        [ForeignKey("UserId")]
        public User User { get; set; }
        public int UserId { get; set; }

        public string Type { get; set; } // Medication, Appointment

        public string Message { get; set; }

        public DateTime Time { get; set; }

        public bool Repeat { get; set; }

        public bool isAcknowledged { get; set; } = false;
    }
}
