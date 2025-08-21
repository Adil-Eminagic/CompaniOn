using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application.Interfaces
{
    public interface ICountriesService : IBaseService<int, CountryDto, CountryUpsertDto, CountrySearchObject>
    {

    }
}
