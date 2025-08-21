using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Entities
{
    [Table("FamilyLinks")]
    public class FamilyLink:BaseEntity
    {
        [ForeignKey("UserId")]
        public User User { get; set; }
        public int UserId { get; set; }

        [ForeignKey("FamilyMemberId")]
        public User FamilyMember { get; set; }
        public int FamilyMemberId { get; set; }

        [Required]
        public string Status { get; set; } // Pending, Accepted, Rejected

        public string Kinship { get; set; } = null!;

        public bool SharedLocation { get; set; }

        public bool SharedReminders { get; set; }
    }
}
