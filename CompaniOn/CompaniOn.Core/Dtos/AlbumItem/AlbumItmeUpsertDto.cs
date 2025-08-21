
namespace CompaniOn.Core
{
    public class AlbumItemUpsertDto : BaseUpsertDto
    {
        public string? Description { get; set; }
        public DateTime? DateOfPhoto { get; set; }
        public int AlbumId { get; set; }
        public string? Photo { get; set; }
    }
}
