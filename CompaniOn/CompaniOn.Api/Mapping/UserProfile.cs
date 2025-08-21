using CompaniOn.Api;
using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class UserProfile : BaseProfile
    {
        public UserProfile()
        {
            CreateMap<AccessSignUpModel, UserUpsertDto>();
        }
    }
}
