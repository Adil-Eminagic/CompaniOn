using CompaniOn.Core.Dtos.FamilyLink;
using CompaniOn.Core.Dtos.FamilyLinks;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application.Interfaces.Services
{
    public interface IFamilyLinkService : IBaseService<int, FamilyLinkDto, FamilyLinkUpsertDto, BaseSearchObject>
    {
        Task<List<FamilyLinkDto>?> GetFamilyLinksByFamilyMemberId(int userId, CancellationToken cancellationToken = default);
        Task<List<FamilyLinkDto>?> GetFamilyLinksByUserId(int userId, CancellationToken cancellationToken = default);
    }
}
