using AutoMapper;
using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Core.Dtos.Notification;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Services
{
    public class NotificationService : BaseService<Notification, NotificationDto, NotificationUpsertDto, NotificationSearchObject, INotificationRepository>, INotificationService
    {
        public NotificationService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<NotificationUpsertDto> validator) : base (mapper, unitOfWork, validator)
        {
            
        }

        public async Task<List<NotificationDto>> GetNotificationsByReceiverIdAsync(int receiverId, CancellationToken cancellationToken = default)
        {
            var notifications = await CurrentRepository.GetNotificationsByReceiverIdAsync(receiverId, cancellationToken);
            return Mapper.Map<List<NotificationDto>>(notifications);
        }

        public async Task MarkAsReadAsync(int notificationId, CancellationToken cancellationToken = default)
        {
            await CurrentRepository.MarkAsReadAsync(notificationId, cancellationToken);
        }
    }
}
