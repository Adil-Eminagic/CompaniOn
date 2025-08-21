
namespace CompaniOn.Core
{
    public class AlbumItemDto:BaseDto
    {
        public string? Description { get; set; }
        public DateTime? DateOfPhoto { get; set; }

        public PhotoDto Photo { get; set; } = null!;
        public int PhotoId { get; set; }

        public AlbumDto Album { get; set; } = null!;
        public int AlbumId { get; set; }
    }
}
