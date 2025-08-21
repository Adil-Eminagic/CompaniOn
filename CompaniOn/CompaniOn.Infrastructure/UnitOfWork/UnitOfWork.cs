
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using Microsoft.EntityFrameworkCore.Storage;

namespace CompaniOn.Infrastructure
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly DatabaseContext _databaseContext;

      
        public readonly ICountriesRepository CountriesRepository;
        public readonly IPhotosRepository PhotosRepository;
        public readonly IUsersRepository UsersRepository;
        public readonly IGendersRepository GendersRepository;
        public readonly IRolesRepository RolesRepository;
        public readonly IAIConversationsRepository AIConversationsRepository;
        public readonly ILocationRepository LocationRepository;
        public readonly IFamilyLinkRepository FamilyLinkRepository;
        public readonly IHealthProfileRepository HealthProfileRepository;
        public readonly IReminderRepository ReminderRepository;
        public readonly INotificationRepository NotificationRepository;
        public readonly IAlbumsRepository AlbumsRepository;
        public readonly IAlbumItemsRepository AlbumItemsRepository;
        public readonly IMessageRepository MessageRepository;
        public UnitOfWork(
            DatabaseContext databaseContext,
            ICountriesRepository countriesRepository,
            IPhotosRepository photosRepository,
            IUsersRepository usersRepository,
            IGendersRepository gendersRepository,
            IRolesRepository rolesRepository,
            ILocationRepository locationRepository,
             IFamilyLinkRepository familyLinkRepository,
            IAIConversationsRepository aIConversationsRepository,
            IReminderRepository reminderRepository,
            IHealthProfileRepository healthProfileRepository,
            INotificationRepository notificationRepository,
            IAlbumsRepository albumsRepository,
            IAlbumItemsRepository albumItemsRepository,
            IMessageRepository messageRepository)
        {
            _databaseContext = databaseContext;

            CountriesRepository = countriesRepository;
            PhotosRepository = photosRepository;
            UsersRepository = usersRepository;
            GendersRepository = gendersRepository;
            RolesRepository = rolesRepository;
            AIConversationsRepository = aIConversationsRepository;
            LocationRepository = locationRepository;
            FamilyLinkRepository = familyLinkRepository;
            ReminderRepository = reminderRepository;
            HealthProfileRepository = healthProfileRepository;
            NotificationRepository = notificationRepository;
            AlbumsRepository = albumsRepository;
            AlbumItemsRepository = albumItemsRepository;
            MessageRepository = messageRepository;
        }

        public async Task<IDbContextTransaction> BeginTransactionAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.Database.BeginTransactionAsync(cancellationToken);
        }

        public async Task CommitTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.CommitTransactionAsync(cancellationToken);
        }

        public async Task RollbackTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.RollbackTransactionAsync(cancellationToken);
        }

        public async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.SaveChangesAsync(cancellationToken);
        }

        public void SaveChanges()
        {
            _databaseContext.SaveChanges();
        }
    }
}
