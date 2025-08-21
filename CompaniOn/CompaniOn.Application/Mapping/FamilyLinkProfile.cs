using CompaniOn.Core.Dtos.FamilyLink;
using CompaniOn.Core.Dtos.FamilyLinks;
using CompaniOn.Core.Dtos.Location;
using CompaniOn.Core.Entities;

namespace CompaniOn.Application.Mapping
{
    public class FamilyLinkProfile : BaseProfile
    {
        public FamilyLinkProfile()
        {
            CreateMap<FamilyLinkDto, FamilyLink>().ReverseMap();

            CreateMap<FamilyLinkUpsertDto, FamilyLink>();
        }
    }
}
