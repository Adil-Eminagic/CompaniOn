
using CompaniOn.Core;

namespace CompaniOn.Infrastructure.Interfaces
{
    public interface ICountriesRepository : IBaseRepository<Country, int, CountrySearchObject>
    {
    }
}
