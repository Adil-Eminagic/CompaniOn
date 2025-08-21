
namespace CompaniOn.Core
{
    public class AlbumDto :BaseDto
    {
        public string Name { get; set; } = null!;
        public string? Description { get; set; }

        public UserDto User { get; set; } = null!;
        public int UserId { get; set; }

        public PhotoDto? CoverPhoto { get; set; }
        public int? CoverPhotoId { get; set; }
    }
}
