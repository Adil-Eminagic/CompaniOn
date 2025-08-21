using CompaniOn.Core;
using CompaniOn.Core.Dtos.Messages;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application.Interfaces.Services
{
    public interface IMessageService : IBaseService<int, MessagesDto, MessagesUpsertDto, BaseSearchObject>
    {

        Task<List<ChatUserDto>> GetChatUsersWithLastMessageAndUnreadAsync(int userId, CancellationToken cancellationToken = default);
        Task<List<MessagesDto>> GetMessagesBetweenUsersAsync(int userId1, int userId2, CancellationToken cancellationToken = default);
    }
}
