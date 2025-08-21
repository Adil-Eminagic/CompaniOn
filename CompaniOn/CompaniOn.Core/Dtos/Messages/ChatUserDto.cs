namespace CompaniOn.Core.Dtos.Messages
{
    public class ChatUserDto
    {
        public int UserId { get; set; }
        public string OtherUserName { get; set; } = string.Empty;
        public string? LastMessage { get; set; }
        public DateTime? LastMessageTime { get; set; }
        public bool HasNewMessages { get; set; }
        public int UnreadCount { get; set; }
    }
}
