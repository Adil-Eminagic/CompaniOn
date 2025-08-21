
using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;


namespace CompaniOn.Infrastructure
{
    public class RolesRepository : BaseRepository<Role, int, BaseSearchObject>, IRolesRepository
    {
        public RolesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async override Task<PagedList<Role>> GetPagedAsync(BaseSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
