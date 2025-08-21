using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application.Interfaces
{
    public interface IRolesService : IBaseService<int, RoleDto, RoleUpsertDto, BaseSearchObject>
    {
    }
}
