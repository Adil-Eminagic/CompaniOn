using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class LocationConfiguration : BaseConfiguration<Location>
{
    public override void Configure(EntityTypeBuilder<Location> builder)
    {
        base.Configure(builder);
        // Postavljanje odnosa sa korisnikom (User)
        builder.HasOne(l => l.User)
               .WithMany()  // Jedan korisnik može imati više lokacija
               .HasForeignKey(l => l.UserId)
               .OnDelete(DeleteBehavior.NoAction);  // Prilikom brisanja korisnika, briše se i lokacija

        // Postavljanje svojstava
        builder.Property(l => l.Latitude).HasPrecision(18, 10);  // Preciznost za decimalne brojeve (18 ukupnih cifara, 10 decimala)
        builder.Property(l => l.Longitude).HasPrecision(18, 10);  // Preciznost za decimalne brojeve (18 ukupnih cifara, 10 decimala)
    }
}
