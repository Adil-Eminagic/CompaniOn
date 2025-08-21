using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.AspNetCore.Authorization;
using CompaniOn.Application;

namespace CompaniOn.Api.Controllers
{
    public class UsersController : BaseCrudController<UserDto, UserUpsertDto, UsersSearchObject, IUsersService>
    {
        public UsersController(IUsersService service, ILogger<UsersController> logger) : base(service, logger)
        {
        }

        [Authorize]
        [HttpPatch("{userId}")]
        public async Task<IActionResult> ChangeEmailAsync([FromBody] JsonPatchDocument jsonPatch, [FromRoute] int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                var dto = await Service.ChangeEmailAsync(userId, jsonPatch, cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when updating email");
                return BadRequest(e.Message + ", " + e?.InnerException);
            }
        }

        [Authorize]
        [HttpGet("GetBasicUsers/{userId}")]
        public virtual async Task<IActionResult> GetBasicUsers(int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                var users = await Service.GetBasicUsersOfFamilyMemeber(userId, cancellationToken);
                return Ok(users);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem when getting resource with ID {0}", userId);
                return BadRequest(e.Message + " " + e?.InnerException);
            }
        }


        [Authorize]
        [HttpPut("ChangePassword")]
        public async Task<IActionResult> ChangePassword([FromBody] UserChangePasswordDto dto, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.ChangePasswordAsync(dto, cancellationToken);
                return Ok();
            }
            catch (Exception e)
            {

                Logger.LogError(e, "Problem when updating password");
                return BadRequest(e.Message + ", " + e?.InnerException);
            }
        }

        [Authorize]
        [HttpPut("PayMembership")]
        public async Task<IActionResult> PayMembership([FromQuery] int userId, CancellationToken cancellationToken = default)
        {
            try
            {
                await Service.PayMembershipAsync(userId, cancellationToken);
                return Ok("Membership successfully activated");
            }
            catch (Exception e)
            {

                Logger.LogError(e, "Problem when paying membership");
                return BadRequest(e.Message + ", " + e?.InnerException);
            }
        }

        [HttpPatch("{userId}/visibility")]
        public async Task<IActionResult> ChangeVisibility(int userId, [FromQuery] bool isVisible, CancellationToken cancellationToken)
        {
            var updatedUser = await Service.ChangeVisibilityAsync(userId, isVisible, cancellationToken);
            return Ok(updatedUser);
        }


    }
}
