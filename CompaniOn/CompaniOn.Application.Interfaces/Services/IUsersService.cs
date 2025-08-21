using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.AspNetCore.JsonPatch;

namespace CompaniOn.Application.Interfaces
{
    public interface IUsersService : IBaseService<int, UserDto, UserUpsertDto, UsersSearchObject>
    {
        Task<UserSensitiveDto?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
        Task<UserDto> ChangeEmailAsync(int userId, JsonPatchDocument jsonPatch, CancellationToken cancellationToken= default);
        Task ChangePasswordAsync(UserChangePasswordDto dto, CancellationToken cancellationToken=default);
        Task PayMembershipAsync(int userId, CancellationToken cancellationToken = default);
        Task<List<UserDto>?> GetBasicUsersOfFamilyMemeber(int userId, CancellationToken cancellationToken = default);
        Task<UserDto> ChangeVisibilityAsync(int userId, bool isVisible, CancellationToken cancellationToken = default);
    }
}
