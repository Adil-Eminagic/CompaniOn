
namespace CompaniOn.Core
{
    public class AlbumUpsertDto : BaseUpsertDto
    {
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public int UserId { get; set; }
        public string? CoverPhoto { get; set; }
    }
}
