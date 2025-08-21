
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Infrastructure
{
    public class AlbumSearchObject : BaseSearchObject
    {
        public string? Name { get; set; }
        public int? UserId { get; set; }
    }
}
