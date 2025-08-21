using CompaniOn.Core.Dtos.Location;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application.Interfaces.Services
{
    public interface ILocationService : IBaseService<int, LocationDTO, LocationUpsertDto, LocationSearchObject>
    {
        Task<LocationDTO> GetLastLocationByUserId(int userId, CancellationToken cancellationToken = default);
    }
}