namespace CompaniOn.Infrastructure.Interfaces
{
    public class AIConversationSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }
        public string? QuestionText { get; set; } 
    }
}