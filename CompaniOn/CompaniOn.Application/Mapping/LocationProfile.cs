using CompaniOn.Core;
using CompaniOn.Core.Dtos.Location;
using CompaniOn.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Mapping
{
    public class LocationProfile : BaseProfile
    {
        public LocationProfile()
        {
            CreateMap<LocationDTO, Location>().ReverseMap();

            CreateMap<LocationUpsertDto, Location>();
        }
    }
}
