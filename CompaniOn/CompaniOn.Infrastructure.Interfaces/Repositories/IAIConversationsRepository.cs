
using CompaniOn.Core;
using CompaniOn.Core.Entities;

namespace CompaniOn.Infrastructure.Interfaces
{
    public interface IAIConversationsRepository : IBaseRepository<AIConversation, int, AIConversationSearchObject>
    {
    }
}
