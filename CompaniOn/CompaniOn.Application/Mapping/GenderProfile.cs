using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class GenderProfile : BaseProfile
    {
        public GenderProfile()
        {
            CreateMap<GenderDto, Gender>().ReverseMap();

            CreateMap<GenderUpsertDto, Gender>();
        }
    }
}
