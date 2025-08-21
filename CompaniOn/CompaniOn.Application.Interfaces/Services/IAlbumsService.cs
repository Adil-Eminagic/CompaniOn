using CompaniOn.Core;
using CompaniOn.Infrastructure;

namespace CompaniOn.Application.Interfaces
{
    public interface IAlbumsService : IBaseService<int, AlbumDto, AlbumUpsertDto, AlbumSearchObject>
    {
    }
}
