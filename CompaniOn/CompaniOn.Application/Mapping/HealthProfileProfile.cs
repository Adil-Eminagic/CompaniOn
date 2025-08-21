using CompaniOn.Core.Dtos.HealthProfile;
using CompaniOn.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Mapping
{
    public class HealthProfileProfile : BaseProfile
    {
        public HealthProfileProfile()
        {
            CreateMap<HealthProfileDto, HealthProfile>().ReverseMap();
            CreateMap<HealthProfileUpsertDto, HealthProfile>();
        }
    }
}
