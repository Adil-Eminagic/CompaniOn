using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Dtos.HealthProfile
{
    public class HealthProfileUpsertDto : BaseUpsertDto
    {
        public int UserId { get; set; }
        public string? HealthConditions { get; set; }
        public string? Medications { get; set; }
        public string? EmergencyContacts { get; set; }
        public string? Notes { get; set; }
    }
}
