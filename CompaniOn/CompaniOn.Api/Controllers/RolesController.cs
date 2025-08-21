using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Api.Controllers
{
    public class RolesController : BaseCrudController<RoleDto, RoleUpsertDto, BaseSearchObject, IRolesService>
    {
        public RolesController(IRolesService service, ILogger<RolesController> logger) : base(service, logger)
        {
        }
        
    }
}
