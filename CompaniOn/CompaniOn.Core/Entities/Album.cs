using System.ComponentModel.DataAnnotations.Schema;

namespace CompaniOn.Core
{
    [Table("Albums")]
    public class Album : BaseEntity
    {
        public string Name { get; set; } = null!;
        public string? Description { get; set; }


        [ForeignKey("UserId")]
        public User User { get; set; } = null!;
        public int UserId { get; set; }

        [ForeignKey("UserId")]
        public Photo? CoverPhoto { get; set; }
        public int? CoverPhotoId { get; set; }

        public ICollection<AlbumItem> AlbumItems { get; set; } = null!;

    }

}
