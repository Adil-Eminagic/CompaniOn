using CompaniOn.Core;
using CompaniOn.Core.Dtos.Messages;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Repositories
{

    public class MessageRepository : BaseRepository<MessageEntity, int, BaseSearchObject>, IMessageRepository
    {

        private readonly DatabaseContext _databaseContext;

        public MessageRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
            _databaseContext = databaseContext;
        }

        public async override Task<PagedList<MessageEntity>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.ToPagedListAsync(searchObject, cancellationToken);
        }

        public async Task<List<ChatUserDto>> GetChatUsersWithLastMessageAndUnreadAsync(int currentUserId, CancellationToken cancellationToken = default)
        {
            var messages = await _databaseContext.Messages
                .Where(m => m.SenderId == currentUserId || m.ReceiverId == currentUserId)
                .ToListAsync(cancellationToken);

            var userIds = messages
                .Select(m => m.SenderId == currentUserId ? m.ReceiverId : m.SenderId)
                .Distinct()
                .ToList();

            var users = await _databaseContext.Users
                .Where(u => userIds.Contains(u.Id))
                .ToDictionaryAsync(u => u.Id, u => u.FirstName + " " + u.LastName, cancellationToken);
         
            var chatUsers = new List<ChatUserDto>();

            foreach (var otherUserId in userIds)
            {
                var lastMessage = messages
                    .Where(m => (m.SenderId == currentUserId && m.ReceiverId == otherUserId) ||
                                (m.SenderId == otherUserId && m.ReceiverId == currentUserId))
                    .OrderByDescending(m => m.CreatedAt)
                    .FirstOrDefault();

                var unreadCount = messages.Count(m =>
                    m.SenderId == otherUserId &&
                    m.ReceiverId == currentUserId &&
                    !m.IsRead);

                chatUsers.Add(new ChatUserDto
                {
                    UserId = otherUserId,
                    OtherUserName = users.ContainsKey(otherUserId) ? users[otherUserId] : "Unknown",
                    LastMessage = lastMessage?.Content,
                    LastMessageTime = lastMessage?.CreatedAt,
                    HasNewMessages = unreadCount > 0,
                    UnreadCount = unreadCount
                });
            }

            return chatUsers
                .OrderByDescending(c => c.LastMessageTime)
                .ToList();
        }

        public async Task<List<MessageEntity>> GetMessagesBetweenUsersAsync(int userId1, int userId2, CancellationToken cancellationToken = default)
        {
            var messages = await DbSet
                .Where(m =>
                    (m.SenderId == userId1 && m.ReceiverId == userId2) ||
                    (m.SenderId == userId2 && m.ReceiverId == userId1)
                )
                .OrderByDescending(m => m.CreatedAt)
                .ToListAsync(cancellationToken);

            var unreadMessages = messages
                .Where(m => m.ReceiverId == userId1 && !m.IsRead)
                .ToList();

            if (unreadMessages.Any())
            {
                foreach (var msg in unreadMessages)
                {
                    msg.IsRead = true;
                }

                await _databaseContext.SaveChangesAsync(cancellationToken);
            }

            return messages;
        }
    }
}
