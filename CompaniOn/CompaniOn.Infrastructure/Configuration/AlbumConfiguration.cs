using CompaniOn.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CompaniOn.Infrastructure
{
    public class AlbumConfiguration : BaseConfiguration<Album>
    {
        public override void Configure(EntityTypeBuilder<Album> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Name)
                   .IsRequired();

            builder.Property(e => e.Description)
                   .IsRequired(false);

            builder.HasOne(e => e.User)
                    .WithMany(e => e.Albums)
                    .HasForeignKey(e => e.UserId)
                    .IsRequired(true);

            builder.HasOne(e => e.CoverPhoto)
                   .WithMany(e => e.Albums)
                   .HasForeignKey(e => e.CoverPhotoId)
                   .IsRequired(false);

        }
    }
}
