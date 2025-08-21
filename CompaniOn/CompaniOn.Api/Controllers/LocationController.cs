using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Core.Dtos.Location;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CompaniOn.Api.Controllers
{
    public class LocationController : BaseCrudController<LocationDTO, LocationUpsertDto, LocationSearchObject, ILocationService>
    {
        public LocationController(ILocationService service, ILogger<LocationController> logger) : base(service, logger)
        {
        }

        [Authorize]
        [HttpGet("GetLastByUserId/{userId}")]
        public virtual async Task<IActionResult> GetLastLocationByUserId(int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                var location = await Service.GetLastLocationByUserId(userId, cancellationToken);
                return Ok(location);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with ID {0}", userId);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }
    }
}
