using CompaniOn.Core.Entities;

namespace CompaniOn.Infrastructure.Interfaces.Repositories
{
    public interface IFamilyLinkRepository : IBaseRepository<FamilyLink, int, BaseSearchObject>
    {
        Task<List<FamilyLink>> GetFamilyLinksByFamilyMemberId(int familyMemberId, CancellationToken cancellationToken = default);
        Task<List<FamilyLink>> GetFamilyLinksByUserId(int userId, CancellationToken cancellationToken = default);
    }
}
