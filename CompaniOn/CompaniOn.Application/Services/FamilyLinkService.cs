using AutoMapper;
using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Core;
using CompaniOn.Core.Dtos.FamilyLink;
using CompaniOn.Core.Dtos.FamilyLinks;
using CompaniOn.Core.Dtos.Location;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using FluentValidation;

namespace CompaniOn.Application.Services
{
    public class FamilyLinkService : BaseService<FamilyLink, FamilyLinkDto, FamilyLinkUpsertDto, BaseSearchObject, IFamilyLinkRepository>, IFamilyLinkService
    {
        public FamilyLinkService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<FamilyLinkUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

        public async Task<List<FamilyLinkDto>?> GetFamilyLinksByFamilyMemberId(int userId, CancellationToken cancellationToken = default)
        {
            var familyLinks = await CurrentRepository.GetFamilyLinksByFamilyMemberId(userId, cancellationToken);
            return Mapper.Map<List<FamilyLinkDto>>(familyLinks);
        }

        public async Task<List<FamilyLinkDto>?> GetFamilyLinksByUserId(int userId, CancellationToken cancellationToken = default)
        {
            var familyLinks = await CurrentRepository.GetFamilyLinksByUserId(userId, cancellationToken);
            return Mapper.Map<List<FamilyLinkDto>>(familyLinks);
        }

    }
}
