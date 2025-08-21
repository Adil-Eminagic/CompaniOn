
using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Infrastructure
{
    public class PhotosRepository : BaseRepository<Photo, int, BaseSearchObject>, IPhotosRepository
    {
        public PhotosRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
