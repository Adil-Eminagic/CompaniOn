
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using CompaniOn.Infrastructure.Repositories;
using Microsoft.Extensions.DependencyInjection;
namespace CompaniOn.Infrastructure
{
    public static class Registry
    {
        public static void AddInfrastructure(this IServiceCollection services)
        {
            services.AddScoped<IAlbumsRepository, AlbumsRepository>();
            services.AddScoped<IAlbumItemsRepository, AlbumItemsRepository>();
            services.AddScoped<ICountriesRepository, CountriesRepository>();
            services.AddScoped<IPhotosRepository,PhotosRepository>();
            services.AddScoped<IUsersRepository, UsersRepository>();
            services.AddScoped<IGendersRepository, GendersRepository>();
            services.AddScoped<IRolesRepository, RolesRepository>();
            services.AddScoped<IAIConversationsRepository, AIConversationsRepository>();
            services.AddScoped<IHealthProfileRepository, HealthProfileRepository>();
            services.AddScoped<ILocationRepository, LocationRepository>();
            services.AddScoped<IFamilyLinkRepository, FamilyLinkRepository>();
            services.AddScoped<IReminderRepository, ReminderRepository>();
            services.AddScoped<INotificationRepository, NotificationRepository>();
            services.AddScoped<IMessageRepository, MessageRepository>();

            services.AddScoped<IUnitOfWork, UnitOfWork>();
        }
    }
}
