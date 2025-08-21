using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Entities
{
    [Table("Notifications")]
    public class Notification : BaseEntity
    {
        [ForeignKey("UserId")]
        public int SenderId { get; set; }
        public User Sender { get; set; } = null!;
        [ForeignKey("FamilyMemberId")]
        public int ReceiverId { get; set; }
        public User Receiver { get; set; } = null!;
        public string Title { get; set; } = null!; 
        public string Message { get; set; } = null!;
        public bool IsRead { get; set; } = false;
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        
    }
}
