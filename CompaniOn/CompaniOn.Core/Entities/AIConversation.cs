using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace CompaniOn.Core
{
    [Table("AIConversations")]
    public class AIConversation : BaseEntity
    {

        [ForeignKey("UserId")]
        public User User { get; set; }
        public int UserId { get; set; }

        public string Question { get; set; }

        public string? Response { get; set; }

        public string SentimentAnalysis { get; set; } // JSON format { "sentiment": "positive", "confidence": 0.87 }

        public DateTime Timestamp { get; set; }

    }

}
