using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Application.Services;
using CompaniOn.Core.Dtos.Notification;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace CompaniOn.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationController : BaseCrudController<NotificationDto, NotificationUpsertDto, NotificationSearchObject, INotificationService>
    {
        public NotificationController(INotificationService service, ILogger<NotificationController> logger) : base(service, logger)
        {

        }

        [Authorize]
        [HttpGet("GetNotificationsForReceiver/{receiverId}")]
        public virtual async Task<IActionResult> GetNotificationsForReceiver(int receiverId, CancellationToken cancellationToken = default)
        {
            try
            {
                var notifications = await Service.GetNotificationsByReceiverIdAsync(receiverId, cancellationToken);
                return Ok(notifications);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting notifications for ReceiverId {0}", receiverId);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }

        [HttpPut("MarkAsRead/{notificationId}")]
        public async Task<IActionResult> MarkAsReadAsync(int notificationId, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.MarkAsReadAsync(notificationId, cancellationToken);
                return Ok(new { message = "Notification marked as read successfully." });
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
