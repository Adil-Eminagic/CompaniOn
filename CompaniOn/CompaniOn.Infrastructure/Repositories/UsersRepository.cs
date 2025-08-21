using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;
using Microsoft.AspNetCore.JsonPatch;
using Microsoft.EntityFrameworkCore;
using System.Runtime.CompilerServices;

namespace CompaniOn.Infrastructure
{
    public class UsersRepository : BaseRepository<User, int, UsersSearchObject>, IUsersRepository
    {
        public UsersRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async Task<User?> ChangeEmailAsync(int userId, JsonPatchDocument jsonPatch, CancellationToken cancellationToken=default)
        {
            var user = await DbSet.FindAsync(userId);
            if (user != null)
            {
                jsonPatch.ApplyTo(user);
                return user;
            }
            return null;
        }

        public async Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(c=>c.Role).AsNoTracking().FirstOrDefaultAsync(x => x.Email == email, cancellationToken);
        }

        public async Task<List<User>?> GetBasicUsersOfFamilyMemeber(int userId, CancellationToken cancellationToken = default)
        {
            var basicUser = await DbSet
            .FromSqlRaw(@"
                SELECT fm.*
                FROM FamilyLinks AS fl
                JOIN Users AS fm ON fm.Id = fl.UserId
                WHERE fl.FamilyMemberId = {0}", userId)
            .ToListAsync();

            return basicUser;
        }


        public override async Task<PagedList<User>> GetPagedAsync(UsersSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(c=>c.ProfilePhoto).Include(c=>c.Role).Include(c=>c.Gender).Where(c => searchObject.FullName == null || c.FirstName.ToLower().Contains(searchObject.FullName.ToLower())
            || c.LastName.ToLower().Contains(searchObject.FullName.ToLower())).
            Where(c=> searchObject.RoleName==null || searchObject.RoleName==c.Role.Value)
            .Where(c=>searchObject.IsActive== null || c.IsActive==searchObject.IsActive)
            .ToPagedListAsync(searchObject, cancellationToken);
        }


        public async override Task<ReportInfo<User>> GetCountAsync(UsersSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(c => searchObject.FullName == null || c.FirstName.ToLower().Contains(searchObject.FullName.ToLower())
            || c.LastName.ToLower().Contains(searchObject.FullName.ToLower())).
            Where(c => searchObject.RoleName == null || searchObject.RoleName == c.Role.Value)
            .Where(c => searchObject.IsActive == null || c.IsActive == searchObject.IsActive)
            .ToReportInfoAsync(searchObject, cancellationToken);
        }

        public async Task<User?> ChangeVisibilityAsync(int userId, bool isVisible, CancellationToken cancellationToken = default)
        {
            var user = await DbSet.FindAsync(new object[] { userId }, cancellationToken);
            if (user != null)
            {
                user.isVisibleToOthers = isVisible;
                return user;
            }
            return null;
        }
    }
}
