
using CompaniOn.Core;
using CompaniOn.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;

namespace CompaniOn.Infrastructure
{
    public partial class DatabaseContext :DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> context):base(context) { }


        //Entities
        public DbSet<Album> Albums { get; set; }
        public DbSet<AlbumItem> AlbumItems { get; set; }
        public DbSet<Gender> Genders { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<Photo> Photos { get; set; }
        public DbSet<Role> Genres { get; set; }
        public DbSet<User> Users { get; set; }

        public DbSet<HealthProfile> HealthProfiles { get; set; }
        public DbSet<Reminder> Reminder { get; set; }
        public DbSet<FamilyLink> FamilyLinks { get; set; }
        public DbSet<Location> Locations { get; set; }
        public DbSet<AIConversation> AIConversations { get; set; }

        public DbSet<Notification> Notifications { get; set; }
        public DbSet<MessageEntity> Messages { get; set; }



        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            SeedData(modelBuilder);
            ApplyConfigurations(modelBuilder);
        }
    }
}
