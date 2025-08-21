using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class RoleProfile : BaseProfile
    {
        public RoleProfile()
        {
            CreateMap<RoleDto, Role>().ReverseMap();

            CreateMap<RoleUpsertDto, Role>();
        }
    }
}
