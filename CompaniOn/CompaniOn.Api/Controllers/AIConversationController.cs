using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace CompaniOn.Api.Controllers
{
    public class AIConversationController : BaseCrudController<AIConversationDto, AIConversationUpsertDto, AIConversationSearchObject, IAIConversationsService>
    {
        public AIConversationController(IAIConversationsService service, ILogger<AIConversationController> logger) : base(service, logger)
        {
        }

        [Authorize]
        [HttpGet("GetLastEntry")]
        public virtual async Task<IActionResult> GetLastEntry(int id, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.GetLastMemberAsync(id,cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting the last entry.", id);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }
    }
}
