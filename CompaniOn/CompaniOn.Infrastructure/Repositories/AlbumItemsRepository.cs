using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace CompaniOn.Infrastructure
{
    public class AlbumItemsRepository : BaseRepository<AlbumItem, int, AlbumItemSearchObject>, IAlbumItemsRepository
    {
        public AlbumItemsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<AlbumItem>> GetPagedAsync(AlbumItemSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(a => a.Photo)
                .Where( a=> searchObject.AlbumId == null || a.AlbumId == searchObject.AlbumId)
               .ToPagedListAsync(searchObject, cancellationToken);
        }

        public override async Task<ReportInfo<AlbumItem>> GetCountAsync(AlbumItemSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet
                .Where(a => searchObject.AlbumId == null || a.AlbumId == searchObject.AlbumId)
               .ToReportInfoAsync(searchObject, cancellationToken);
        }
    }

}
