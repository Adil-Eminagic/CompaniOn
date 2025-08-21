using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Core.Dtos.FamilyLink;
using CompaniOn.Core.Dtos.FamilyLinks;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CompaniOn.Api.Controllers
{
    public class FamilyLinkController : BaseCrudController<FamilyLinkDto, FamilyLinkUpsertDto, BaseSearchObject, IFamilyLinkService>
    {
        public FamilyLinkController(IFamilyLinkService service, ILogger<FamilyLinkController> logger) : base(service, logger)
        {
        }

        [Authorize]
        [HttpGet("GetByFamilyMemberId/{userId}")]
        public virtual async Task<IActionResult> GetFamilyLinksByFamilyMemberId(int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                var familyLinks = await Service.GetFamilyLinksByFamilyMemberId(userId, cancellationToken);
                return Ok(familyLinks);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with ID {0}", userId);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }

        [Authorize]
        [HttpGet("GetByUserId/{userId}")]
        public virtual async Task<IActionResult> GetFamilyLinksByUserId(int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                var familyLinks = await Service.GetFamilyLinksByUserId(userId, cancellationToken);
                return Ok(familyLinks);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with ID {0}", userId);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }


    }
}
