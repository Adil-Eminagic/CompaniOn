using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

public class AIConversationConfiguration :BaseConfiguration<AIConversation>
{
    public override void Configure(EntityTypeBuilder<AIConversation> builder)
            {
        base.Configure(builder);
        // Postavljanje odnosa sa korisnikom (User)
        builder.HasOne(ac => ac.User)
               .WithMany()  // Jedan korisnik može imati više AI razgovora
               .HasForeignKey(ac => ac.UserId)
               .OnDelete(DeleteBehavior.NoAction);  // Prilikom brisanja korisnika, briše se i AI razgovor

        // Postavljanje svojstava
        builder.Property(ac => ac.Question)
               .IsRequired()
               .HasMaxLength(1000);  // Postavljamo maksimalnu dužinu pitanja

        builder.Property(ac => ac.Response)
               .HasMaxLength(2000);  // Postavljamo maksimalnu dužinu odgovora (nije obavezno)

        builder.Property(ac => ac.SentimentAnalysis)
               .IsRequired()
               .HasMaxLength(500);  // Postavljamo maksimalnu dužinu za analizu sentimenta (JSON format)

        builder.Property(ac => ac.Timestamp)
               .IsRequired();  // Postavljamo vreme kao obavezno polje
    }
}
