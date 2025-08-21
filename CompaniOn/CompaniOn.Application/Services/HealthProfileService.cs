using AutoMapper;
using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Core;
using CompaniOn.Core.Dtos.HealthProfile;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using CompaniOn.Infrastructure.Repositories;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Services
{
    public class HealthProfileService : BaseService<HealthProfile, HealthProfileDto, HealthProfileUpsertDto, HealthProfileSearchObject, IHealthProfileRepository>, IHealthProfileService
    {
        public HealthProfileService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<HealthProfileUpsertDto> validator) : base (mapper,unitOfWork,validator)
        {
            
        }
    }
}
