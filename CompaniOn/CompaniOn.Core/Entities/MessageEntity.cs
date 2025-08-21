using System.ComponentModel.DataAnnotations.Schema;

namespace CompaniOn.Core.Entities
{
    [Table("Messages")]
    public class MessageEntity:BaseEntity
    {
        [ForeignKey("SenderId")]
        public int SenderId { get; set; }
        public User Sender { get; set; } = null!;
        [ForeignKey("RecieverId")]
        public int ReceiverId { get; set; }
        public User Receiver { get; set; } = null!;
        public string Content { get; set; }
        public bool IsRead { get; set; } = false;
    }
}
