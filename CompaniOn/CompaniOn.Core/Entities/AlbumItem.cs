using System.ComponentModel.DataAnnotations.Schema;

namespace CompaniOn.Core
{
    [Table("AlbumItems")]
    public class AlbumItem : BaseEntity
    {
        public string? Description { get; set; }
        public DateTime? DateOfPhoto { get; set; }

        [ForeignKey("AlbumId")]
        public Album Album { get; set; } = null!;
        public int AlbumId { get; set; }

        [ForeignKey("PhotoId")]
        public Photo Photo { get; set; } = null!;
        public int PhotoId { get; set; }

    }

}
