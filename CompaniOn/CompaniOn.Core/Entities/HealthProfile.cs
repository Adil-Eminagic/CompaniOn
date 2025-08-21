using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Entities
{
    [Table("HealthProfiles")]
    public class HealthProfile:BaseEntity
    {
       
        public string HealthConditions { get; set; }

        public string Medications { get; set; }

        public string EmergencyContacts { get; set; }

        public string? Notes { get; set; }

        [ForeignKey("UserId")]
        public User User { get; set; }
        public int UserId { get; set; }
    }

}
