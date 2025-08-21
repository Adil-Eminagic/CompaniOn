namespace CompaniOn.Core
{
    public class Photo : BaseEntity
    {
        public string Data { get; set; } = null!;
      
        public ICollection<User> Users { get; set; } = null!;
        public ICollection<Album> Albums { get; set; } = null!;
        public ICollection<AlbumItem> AlbumItems { get; set; } = null!;
    }
}
