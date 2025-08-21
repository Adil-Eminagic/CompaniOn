using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace CompaniOn.Infrastructure
{
    public class AlbumsRepository : BaseRepository<Album, int, AlbumSearchObject>, IAlbumsRepository
    {
        public AlbumsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public override async Task<PagedList<Album>> GetPagedAsync(AlbumSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(a=> a.CoverPhoto)
                .Where(a=> searchObject.UserId == null || a.UserId == searchObject.UserId)
                .Where( a=> searchObject.Name == null || a.Name.ToLower().Contains(searchObject.Name.ToLower()))
                .ToPagedListAsync(searchObject, cancellationToken);
        }

        public override async Task<ReportInfo<Album>> GetCountAsync(AlbumSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(a => searchObject.Name == null || a.Name.ToLower().Contains(searchObject.Name.ToLower()))
                 .Where(a => searchObject.UserId == null || a.UserId == searchObject.UserId)
                .ToReportInfoAsync(searchObject, cancellationToken);
        }
    }
}
