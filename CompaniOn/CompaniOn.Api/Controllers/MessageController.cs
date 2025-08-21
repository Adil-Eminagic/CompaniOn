using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Core.Dtos.Messages;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace CompaniOn.Api.Controllers
{
    public class MessageController : BaseCrudController<MessagesDto, MessagesUpsertDto, BaseSearchObject, IMessageService>
    {
        public MessageController(IMessageService service, ILogger<MessageController> logger) : base(service, logger)
        {
        }

        [HttpGet("chat-user-ids/{userId}")]
        public async Task<IActionResult> GetChatUserIds(int userId, CancellationToken cancellationToken)
        {
            var result = await Service.GetChatUsersWithLastMessageAndUnreadAsync(userId, cancellationToken);
            return Ok(result);
        }

        [HttpGet("conversation")]
        public async Task<IActionResult> GetMessagesBetweenUsers([FromQuery] int userId1, [FromQuery] int userId2, CancellationToken cancellationToken)
        {
            var messages = await Service.GetMessagesBetweenUsersAsync(userId1, userId2, cancellationToken);
            return Ok(messages);
        }

    }
}
