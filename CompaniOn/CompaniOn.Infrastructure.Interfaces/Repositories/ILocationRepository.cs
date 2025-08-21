using CompaniOn.Core.Entities;

namespace CompaniOn.Infrastructure.Interfaces.Repositories
{
    public interface ILocationRepository : IBaseRepository<Location, int, LocationSearchObject>
    {
        Task<Location> GetLastLocationByUserId(int userId, CancellationToken cancellationToken = default);
    }
}
