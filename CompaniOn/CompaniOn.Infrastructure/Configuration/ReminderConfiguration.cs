using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class ReminderConfiguration :BaseConfiguration<Reminder>
{
    public override void Configure(EntityTypeBuilder<Reminder> builder)
    {
        base.Configure(builder);

        // Postavljanje odnosa sa korisnikom (User)
        builder.HasOne(r => r.User)
               .WithMany()  // Jedan korisnik može imati više podsetnika
               .HasForeignKey(r => r.UserId)
               .OnDelete(DeleteBehavior.NoAction);  // Prilikom brisanja korisnika, briše se i podsetnik

        // Postavljanje svojstava
        builder.Property(r => r.Type)
               .IsRequired()
               .HasMaxLength(50);  // Postavljamo tip podsetnika sa maksimalnom dužinom

        builder.Property(r => r.Message)
               .IsRequired()
               .HasMaxLength(500);  // Postavljamo poruku podsetnika sa maksimalnom dužinom

        builder.Property(r => r.Time)
               .IsRequired();  // Postavljamo vreme podsetnika kao obavezno
    }
}
