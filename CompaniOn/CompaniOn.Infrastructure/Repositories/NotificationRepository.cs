using CompaniOn.Core;
using CompaniOn.Core.Dtos.Notification;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;
using Microsoft.Identity.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Repositories
{
    public class NotificationRepository : BaseRepository<Notification,int,NotificationSearchObject>, INotificationRepository
    {
        public NotificationRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
            
        }

        public async override Task<ReportInfo<Notification>> GetCountAsync(NotificationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x=>searchObject.SenderId == null || x.SenderId == searchObject.SenderId).Where(x => searchObject.ReceiverId == null || x.ReceiverId == searchObject.ReceiverId).ToReportInfoAsync(searchObject, cancellationToken);
        }

        public async Task<List<NotificationDto>> GetNotificationsByReceiverIdAsync(int receiverId, CancellationToken cancellationToken = default)
        {
            var notifications = await DbSet
                .Where(n => n.ReceiverId == receiverId)
                .Include(n => n.Sender)
                .Select(n => new NotificationDto
                {
                    Id=n.Id,
                    SenderId = n.SenderId,
                    Sender = n.Sender, 
                    ReceiverId = n.ReceiverId,
                    Title = n.Title,
                    Message = n.Message,
                    IsRead = n.IsRead,
                    CreatedAt = n.CreatedAt
                })
                .ToListAsync(cancellationToken);

            return notifications;
        }

        public async override  Task<PagedList<Notification>> GetPagedAsync(NotificationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => searchObject.SenderId == null || x.SenderId == searchObject.SenderId).Where(x => searchObject.ReceiverId == null || x.ReceiverId == searchObject.ReceiverId).ToPagedListAsync(searchObject, cancellationToken);
        }

        public async Task MarkAsReadAsync(int notificationId, CancellationToken cancellationToken = default)
        {
            // Pronaći notifikaciju prema ID-u
            var notification = await DbSet.FindAsync(notificationId, cancellationToken);
            if (notification != null)
            {
                // Ažurirati status notifikacije na "pročitano"
                notification.IsRead = true;

                // Spremiti promene u bazi podataka
                await DatabaseContext.SaveChangesAsync(cancellationToken);  // Koristi DbContext za SaveChangesAsync
            }
            else
            {
                throw new Exception("Notification not found.");
            }
        }

    }
}
