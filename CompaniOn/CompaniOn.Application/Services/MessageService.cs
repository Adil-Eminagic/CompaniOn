using AutoMapper;
using CompaniOn.Application.Interfaces;
using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CompaniOn.Core.Entities;
using CompaniOn.Core.Dtos.Messages;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using CompaniOn.Application.Interfaces.Services;
using Microsoft.AspNetCore.SignalR;
using CompaniOn.Application.SignalRHubs;
using Microsoft.EntityFrameworkCore;

namespace CompaniOn.Application.Services
{
    public class MessageService : BaseService<MessageEntity, MessagesDto, MessagesUpsertDto, BaseSearchObject, IMessageRepository>, IMessageService
    {
        private readonly IHubContext<MessageHub> _hubContext;
        private readonly IHubContext<NotificationHub> _notificationHubContext;
        private readonly INotificationRepository _notificationRepository;

        public MessageService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<MessagesUpsertDto> validator, IHubContext<MessageHub> hubContext,INotificationRepository notificationRepository, IHubContext<NotificationHub> notificationHubContext) : base(mapper, unitOfWork, validator)
        {
            _hubContext = hubContext;
            _notificationRepository = notificationRepository;
            _notificationHubContext = notificationHubContext;
        }

        public async Task<List<ChatUserDto>> GetChatUsersWithLastMessageAndUnreadAsync(int userId, CancellationToken cancellationToken = default)
        {
            return await UnitOfWork.MessageRepository.GetChatUsersWithLastMessageAndUnreadAsync(userId, cancellationToken);
        }

        public async Task<List<MessagesDto>> GetMessagesBetweenUsersAsync(int userId1, int userId2, CancellationToken cancellationToken = default)
        {
            var messages = await UnitOfWork.MessageRepository.GetMessagesBetweenUsersAsync(userId1, userId2, cancellationToken);
            return Mapper.Map<List<MessagesDto>>(messages);
        }

        public override async Task<MessagesDto> AddAsync(MessagesUpsertDto dto, CancellationToken cancellationToken = default)
        {
            var result = await base.AddAsync(dto, cancellationToken);

            await _hubContext.Clients.All.SendAsync("ReceiveMessageNotification", new
            {
                ReceiverId = dto.ReceiverId,
                SenderId = dto.SenderId,
                Content = dto.Content
            });

            var notification = new Notification()
            {
                SenderId =  dto.SenderId,
                ReceiverId = dto.ReceiverId,
                Title = $"You have new messages!",
                Message = dto.Content,
                IsRead = false,
                IsDeleted = false,
                CreatedAt = DateTime.Now,
                ModifiedAt = null
            };

            await _notificationRepository.AddAsync(notification);

            await _notificationHubContext.Clients.All.SendAsync("ReceiveLocation",dto.Content);

            return result;
        }

    }
}
