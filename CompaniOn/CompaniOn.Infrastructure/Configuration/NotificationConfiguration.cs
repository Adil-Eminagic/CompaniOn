using CompaniOn.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Configuration
{
    public class NotificationConfiguration : BaseConfiguration<Notification>
    {
        public override void Configure(EntityTypeBuilder<Notification> builder)
        {
            base.Configure(builder);
            builder.HasOne(n => n.Sender)
                   .WithMany()
                   .HasForeignKey(n => n.SenderId)
                   .OnDelete(DeleteBehavior.NoAction);
            builder.HasOne(n => n.Receiver)
                   .WithMany()
                   .HasForeignKey(n => n.ReceiverId)
                   .OnDelete(DeleteBehavior.NoAction);
            builder.Property(n => n.Title)
                   .IsRequired()
                   .HasMaxLength(50);
            builder.Property(n => n.Message)
                   .IsRequired()
                   .HasMaxLength(255);
            builder.Property(n => n.IsRead)
                   .IsRequired();
            builder.Property(n => n.CreatedAt)
                   .IsRequired();
        }
    }
}
