
using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Infrastructure
{
    public class AIConversationsRepository : BaseRepository<AIConversation, int, AIConversationSearchObject>, IAIConversationsRepository
    {
        public AIConversationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async override Task<PagedList<AIConversation>> GetPagedAsync(AIConversationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(c => searchObject.UserId == null || c.UserId == searchObject.UserId)
                .Where(c=> searchObject.QuestionText == null || c.Question.ToLower().Contains(searchObject.QuestionText.ToLower()))
                 .ToPagedListAsync(searchObject, cancellationToken);
        }

        public async override Task<ReportInfo<AIConversation>> GetCountAsync(AIConversationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(c => searchObject.UserId == null || c.UserId == searchObject.UserId)
                .Where(c => searchObject.QuestionText == null || c.Question.ToLower().Contains(searchObject.QuestionText.ToLower()))
                .ToReportInfoAsync(searchObject, cancellationToken);
        }
    }
}
