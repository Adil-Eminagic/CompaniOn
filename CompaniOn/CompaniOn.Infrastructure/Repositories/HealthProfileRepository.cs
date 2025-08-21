using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore.Metadata;
using System.Runtime.CompilerServices;

namespace CompaniOn.Infrastructure.Repositories
{
    public class HealthProfileRepository : BaseRepository<HealthProfile, int, HealthProfileSearchObject>, IHealthProfileRepository
    {
        public HealthProfileRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async override Task<PagedList<HealthProfile>> GetPagedAsync(HealthProfileSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x=>searchObject.UserId==null || x.UserId==searchObject.UserId).Where(x=>searchObject.HealthConditions == null || x.HealthConditions.ToLower().Contains(searchObject.HealthConditions.ToLower()))
               .Where(x=>searchObject.EmergencyContacts == null || x.EmergencyContacts.ToLower().Contains(searchObject.EmergencyContacts.ToLower())).ToPagedListAsync(searchObject, cancellationToken);
        }

        public async override Task<ReportInfo<HealthProfile>> GetCountAsync(HealthProfileSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => searchObject.UserId == null || x.UserId == searchObject.UserId).Where(x => searchObject.HealthConditions == null || x.HealthConditions.ToLower().Contains(searchObject.HealthConditions.ToLower()))
                .Where(x => searchObject.EmergencyContacts == null || x.EmergencyContacts.ToLower().Contains(searchObject.EmergencyContacts.ToLower())).ToReportInfoAsync(searchObject, cancellationToken);
        }
    }
}
