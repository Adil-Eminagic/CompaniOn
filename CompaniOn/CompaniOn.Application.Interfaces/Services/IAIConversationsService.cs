using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application.Interfaces
{
    public interface IAIConversationsService : IBaseService<int, AIConversationDto, AIConversationUpsertDto, AIConversationSearchObject>
    {
        Task<AIConversationDto?> GetLastMemberAsync(int id, CancellationToken cancellationToken = default);
        //Task<string> GetAzureAIResponseAsync(string input, CancellationToken cancellationToken);
        Task<(string Response, string SentimentAnalysis)> GetAzureAIResponseAsync(int id, string input, CancellationToken cancellationToken = default);
    }

}
