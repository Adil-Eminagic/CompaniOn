using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.IdentityModel.Tokens;

public class FamilyLinkConfiguration:BaseConfiguration<FamilyLink>
{
    public override void Configure(EntityTypeBuilder<FamilyLink> builder)
    {
        base.Configure(builder);

        // Postavljanje odnosa sa korisnikom (User)
        builder.HasOne(fl => fl.User)
               .WithMany()  // Jedan korisnik može imati više porodičnih veza
               .HasForeignKey(fl => fl.UserId)
               .OnDelete(DeleteBehavior.NoAction);  // Ako se obriše korisnik, briše se i porodična veza

        // Postavljanje odnosa sa članom porodice (FamilyMember)
        builder.HasOne(fl => fl.FamilyMember)
               .WithMany()  // Član porodice može imati više porodičnih veza
               .HasForeignKey(fl => fl.FamilyMemberId)
               .OnDelete(DeleteBehavior.NoAction);  // Ako se obriše član porodice, briše se i porodična veza

        // Postavljanje svojstava
        builder.Property(fl => fl.Status)
               .IsRequired()
               .HasMaxLength(50);  // Postavljamo maksimalnu dužinu za status (Pending, Accepted, Rejected)

        builder.Property(fl => fl.Kinship)
            .IsRequired(true)
            .HasMaxLength(20);
    }
}
