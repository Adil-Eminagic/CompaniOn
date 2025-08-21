using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Interfaces.SearchObjects
{
    public class HealthProfileSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }
        public string? HealthConditions { get; set; }
        public string? EmergencyContacts { get; set; }
    }
}
