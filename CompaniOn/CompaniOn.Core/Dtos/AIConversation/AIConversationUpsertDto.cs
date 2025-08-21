namespace CompaniOn.Core
{
    public class AIConversationUpsertDto : BaseUpsertDto
    {
        public int UserId { get; set; }
        public string Question { get; set; } = null!;
        public string? Response { get; set; }
        public string SentimentAnalysis { get; set; } = null!;
        public DateTime Timestamp { get; set; }
    }
}
