using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application.Interfaces
{
    public interface IGendersService : IBaseService<int, GenderDto, GenderUpsertDto, BaseSearchObject>
    {
    }
}
