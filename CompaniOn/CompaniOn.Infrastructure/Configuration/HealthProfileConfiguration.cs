using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class HealthProfileConfiguration : BaseConfiguration<HealthProfile>
{
    public override void Configure(EntityTypeBuilder<HealthProfile> builder)
    {
        base.Configure(builder);

        // Postavljanje odnosa sa korisnikom (User)
        builder.HasOne(hp => hp.User)
               .WithMany()  
               .HasForeignKey(hp => hp.Id)
               .OnDelete(DeleteBehavior.NoAction);

        // Postavljanje svojstava
        builder.Property(hp => hp.HealthConditions).HasMaxLength(500);
        builder.Property(hp => hp.Medications).HasMaxLength(500);
        builder.Property(hp => hp.EmergencyContacts).HasMaxLength(500);
        builder.Property(hp => hp.Notes).HasMaxLength(1000);
    }
}
