using AutoMapper;
using FluentValidation;
using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application
{
    public class RolesService : BaseService<Role, RoleDto, RoleUpsertDto, BaseSearchObject, IRolesRepository>, IRolesService
    {
        public RolesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<RoleUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

    }
}
