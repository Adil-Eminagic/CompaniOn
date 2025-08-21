using CompaniOn.Core.Dtos.HealthProfile;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Interfaces.Services
{
    public interface IHealthProfileService : IBaseService<int,HealthProfileDto,HealthProfileUpsertDto,HealthProfileSearchObject>
    {

    }
}
