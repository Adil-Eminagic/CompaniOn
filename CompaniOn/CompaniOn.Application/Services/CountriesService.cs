using AutoMapper;
using FluentValidation;

using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application
{
    public class CountriesService : BaseService<Country, CountryDto, CountryUpsertDto, CountrySearchObject, ICountriesRepository>, ICountriesService
    {
        public CountriesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<CountryUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }
    }
}
