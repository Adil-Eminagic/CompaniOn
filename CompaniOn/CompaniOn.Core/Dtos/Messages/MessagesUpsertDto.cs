namespace CompaniOn.Core.Dtos.Messages
{
    public class MessagesUpsertDto:BaseUpsertDto
    {
        public int SenderId { get; set; }
        public int ReceiverId { get; set; }
        public string Content { get; set; }
    }
}
