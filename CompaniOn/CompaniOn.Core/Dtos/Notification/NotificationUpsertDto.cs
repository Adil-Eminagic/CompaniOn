using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Dtos.Notification
{
    public class NotificationUpsertDto : BaseUpsertDto
    {
        public int? SenderId { get; set; }
        public int? ReceiverId { get; set; }
        public string? Title { get; set; } = null!;
        public string? Message { get; set; } = null!;
        public bool? IsRead { get; set; } = false;
        public DateTime? CreatedAt { get; set; } = DateTime.UtcNow;
    }
}
