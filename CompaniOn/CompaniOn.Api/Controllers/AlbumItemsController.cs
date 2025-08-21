using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure;

namespace CompaniOn.Api.Controllers
{
    public class AlbumItemsController : BaseCrudController<AlbumItemDto, AlbumItemUpsertDto, AlbumItemSearchObject, IAlbumItemsService>
    {
        public AlbumItemsController(IAlbumItemsService service, ILogger<AlbumItemsController> logger) : base(service, logger)
        {
        }
        
    }
}
