using System.ComponentModel.DataAnnotations.Schema;

namespace CompaniOn.Core.Dtos.Messages
{
    public class MessagesDto:BaseDto
    {
        public int SenderId { get; set; }
        public int ReceiverId { get; set; }
        public string Content { get; set; }
    }
}
