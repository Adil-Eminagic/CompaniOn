using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Dtos.HealthProfile
{
    public class HealthProfileDto : BaseDto
    {
        public User User { get; set; } = null!;
        public int UserId { get; set; }
        public string HealthConditions { get; set; }
        public string Medications { get; set; }
        public string EmergencyContacts { get; set; }
        public string? Notes { get; set; }
    }
}
