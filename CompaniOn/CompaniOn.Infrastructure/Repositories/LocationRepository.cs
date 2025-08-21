using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using Microsoft.EntityFrameworkCore;

namespace CompaniOn.Infrastructure.Repositories
{
    public class LocationRepository : BaseRepository<Location, int, LocationSearchObject>, ILocationRepository
    {
        public LocationRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override Task<PagedList<Location>> GetPagedAsync(LocationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            if (searchObject.OrderByCreatedDate != null && searchObject.OrderByCreatedDate == true)
            {
                return DbSet.Where(c => searchObject.UserId == null || c.UserId == searchObject.UserId)
                    .OrderByDescending(c => c.CreatedAt)
               .ToPagedListAsync(searchObject, cancellationToken);
            }
            else
            {
                return DbSet.Where(c => searchObject.UserId == null || c.UserId == searchObject.UserId)
                .ToPagedListAsync(searchObject, cancellationToken);
            }
        }

        public Task<Location> GetLastLocationByUserId(int userId, CancellationToken cancellationToken = default)
        {
            var location = DbSet
            .FromSqlRaw(@"
                select top 1 *
                from Locations as l
                where l.UserId = {0}
                order by CreatedAt desc", userId)
            .FirstOrDefaultAsync();

            return location;
        }
    }
}
