using CompaniOn.Application.Interfaces;
using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Application.Services;
using CompaniOn.Application.Validators;
using CompaniOn.Core;
using CompaniOn.Core.Dtos.FamilyLink;
using CompaniOn.Core.Dtos.HealthProfile;
using CompaniOn.Core.Dtos.Location;
using CompaniOn.Core.Dtos.Messages;
using CompaniOn.Core.Dtos.Notification;
using CompaniOn.Core.Dtos.Reminder;
using FluentValidation;
using Microsoft.Extensions.DependencyInjection;

namespace CompaniOn.Application
{
    public static class Registry
    {
        public static void AddApplication(this IServiceCollection services)
        {
            services.AddScoped<IAlbumItemsService, AlbumItemsService>();
            services.AddScoped<IAlbumsService, AlbumsService>();
            services.AddScoped<ICountriesService, CountriesService>();
            services.AddScoped<IPhotosService, PhotosService>();
            services.AddScoped<IUsersService, UsersService>();
            services.AddScoped<IGendersService,GendersService>();
            services.AddScoped<IRolesService, RolesService>();
            services.AddScoped<IAIConversationsService, AIConversationsService>();
            services.AddScoped<ILocationService, LocationService>();
            services.AddScoped<IFamilyLinkService, FamilyLinkService>();
            services.AddScoped<IHealthProfileService, HealthProfileService>();
            services.AddScoped<IReminderService, ReminderService>();
            services.AddScoped<INotificationService, NotificationService>();
            services.AddScoped<IMessageService, MessageService>();
        }

        public static void AddValidators(this IServiceCollection services)
        {
            services.AddScoped<IValidator<AlbumItemUpsertDto>, AlbumItemValidator>();
            services.AddScoped<IValidator<AlbumUpsertDto>, AlbumValidator>();
            services.AddScoped<IValidator<CountryUpsertDto>, CountryValidator>();
            services.AddScoped<IValidator<PhotoUpsertDto>, PhotoValidator>();
            services.AddScoped<IValidator<UserUpsertDto>, UserValidator>();
            services.AddScoped<IValidator<GenderUpsertDto>, GenderValidator>();
            services.AddScoped<IValidator<RoleUpsertDto>, RoleValidator>();
            services.AddScoped<IValidator<UserChangePasswordDto>, UserPasswordValidator>();
            services.AddScoped<IValidator<AIConversationUpsertDto>, AIConversationValidator>();
            services.AddScoped<IValidator<LocationUpsertDto>, LocationValidator>();
            services.AddScoped<IValidator<FamilyLinkUpsertDto>, FamilyLinkValidator>();
            services.AddScoped<IValidator<HealthProfileUpsertDto>, HealthProfileValidator>();
            services.AddScoped<IValidator<ReminderUpsertDto>, ReminderValidator>();
            services.AddScoped<IValidator<NotificationUpsertDto>, NotificationValidator>();
            services.AddScoped<IValidator<MessagesUpsertDto>,MessageValidator>();
        }
    }
}
