using AutoMapper;
using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Core.Dtos.FamilyLinks;
using CompaniOn.Core.Dtos.Location;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using FluentValidation;

namespace CompaniOn.Application.Services
{
    public class LocationService : BaseService<Location, LocationDTO, LocationUpsertDto, LocationSearchObject, ILocationRepository>, ILocationService
    {
        public LocationService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<LocationUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

        public async Task<LocationDTO> GetLastLocationByUserId(int userId, CancellationToken cancellationToken = default)
        {
            var location = await CurrentRepository.GetLastLocationByUserId(userId, cancellationToken);
            return Mapper.Map<LocationDTO>(location);
        }
    }
}
