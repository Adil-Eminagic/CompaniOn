using CompaniOn.Core.Dtos.Notification;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Interfaces.Repositories
{
    public interface INotificationRepository : IBaseRepository<Notification, int, NotificationSearchObject>
    {
        Task<List<NotificationDto>> GetNotificationsByReceiverIdAsync(int receiverId, CancellationToken cancellationToken = default);
        Task MarkAsReadAsync(int notificationId, CancellationToken cancellationToken = default);

    }
}
