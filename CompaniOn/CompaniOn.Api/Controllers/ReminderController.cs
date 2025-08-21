using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Application.Services;
using CompaniOn.Core.Dtos.Reminder;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CompaniOn.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReminderController : BaseCrudController<ReminderDto,ReminderUpsertDto,ReminderSearchObject,IReminderService>
    {
        public ReminderController(IReminderService service,ILogger<ReminderController> logger) : base (service, logger)
        {
            
        }

        [AllowAnonymous]
        public override Task<IActionResult> GetPaged([FromQuery] ReminderSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return base.GetPaged(searchObject, cancellationToken);
        }
    }
}
