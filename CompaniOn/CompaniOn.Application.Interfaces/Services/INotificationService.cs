using CompaniOn.Core.Dtos.Notification;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Interfaces.Services
{
    public interface INotificationService : IBaseService<int,NotificationDto,NotificationUpsertDto,NotificationSearchObject>
    {
        Task<List<NotificationDto>> GetNotificationsByReceiverIdAsync(int receiverId, CancellationToken cancellationToken = default);
        Task MarkAsReadAsync(int notificationId, CancellationToken cancellationToken = default);

    }
}
