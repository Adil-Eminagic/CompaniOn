using AutoMapper;
using FluentValidation;
using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application
{
    public class GendersService : BaseService<Gender, GenderDto, GenderUpsertDto, BaseSearchObject, IGendersRepository>, IGendersService
    {
        public GendersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<GenderUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

    }
}
