using CompaniOn.Core.Dtos.Messages;
using CompaniOn.Core.Entities;

namespace CompaniOn.Infrastructure.Interfaces.Repositories
{
    public interface IMessageRepository : IBaseRepository<MessageEntity, int, BaseSearchObject>
    {
       Task<List<ChatUserDto>> GetChatUsersWithLastMessageAndUnreadAsync(int currentUserId, CancellationToken cancellationToken = default);
       Task<List<MessageEntity>> GetMessagesBetweenUsersAsync(int userId1, int userId2, CancellationToken cancellationToken = default);
    }
}
