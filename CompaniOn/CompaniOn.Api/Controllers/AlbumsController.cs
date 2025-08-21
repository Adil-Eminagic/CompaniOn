using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure;

namespace CompaniOn.Api.Controllers
{
    public class AlbumsController : BaseCrudController<AlbumDto, AlbumUpsertDto, AlbumSearchObject, IAlbumsService>
    {
        public AlbumsController(IAlbumsService service, ILogger<AlbumsController> logger) : base(service, logger)
        {
        }
        
    }
}
