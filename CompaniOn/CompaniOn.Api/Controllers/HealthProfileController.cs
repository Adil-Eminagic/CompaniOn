using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Application.Services;
using CompaniOn.Core.Dtos.HealthProfile;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CompaniOn.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HealthProfileController : BaseCrudController<HealthProfileDto,HealthProfileUpsertDto,HealthProfileSearchObject,IHealthProfileService>
    {
        public HealthProfileController(IHealthProfileService service, ILogger<HealthProfileController> logger) : base(service,logger)
        {
            
        }

        [AllowAnonymous]
        public override Task<IActionResult> GetPaged([FromQuery] HealthProfileSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return base.GetPaged(searchObject, cancellationToken);
        }

    }
}
