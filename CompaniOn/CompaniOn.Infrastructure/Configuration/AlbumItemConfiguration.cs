using CompaniOn.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CompaniOn.Infrastructure
{
    public class AlbumItemConfiguration : BaseConfiguration<AlbumItem>
    {
        public override void Configure(EntityTypeBuilder<AlbumItem> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Description)
                  .IsRequired(false);

            builder.Property(e => e.Description)
                   .IsRequired(false);

            builder.HasOne(e => e.Album)
                    .WithMany(e => e.AlbumItems)
                    .HasForeignKey(e => e.AlbumId)
                    .IsRequired(true);

            builder.HasOne(e => e.Photo)
                   .WithMany(e => e.AlbumItems)
                   .HasForeignKey(e => e.PhotoId)
                   .IsRequired(true);

        }
    }
}
