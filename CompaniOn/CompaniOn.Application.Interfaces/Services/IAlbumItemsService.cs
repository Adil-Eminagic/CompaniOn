using CompaniOn.Core;
using CompaniOn.Infrastructure;

namespace CompaniOn.Application.Interfaces
{
    public interface IAlbumItemsService : IBaseService<int, AlbumItemDto, AlbumItemUpsertDto, AlbumItemSearchObject>
    {
    }
}
