using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using Microsoft.EntityFrameworkCore;
using System.Net;

namespace CompaniOn.Infrastructure.Repositories
{
    public class FamilyLinkRepository : BaseRepository<FamilyLink, int, BaseSearchObject>, IFamilyLinkRepository
    {
        public FamilyLinkRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async Task<List<FamilyLink>> GetFamilyLinksByFamilyMemberId(int familyMemberId, CancellationToken cancellationToken = default)
        {
            var familyLinks = await DbSet
            .FromSqlRaw(@"
                select *
                from FamilyLinks as fl
                WHERE fl.FamilyMemberId = {0}", familyMemberId)
            .ToListAsync();

            return familyLinks;
        }

        public async Task<List<FamilyLink>> GetFamilyLinksByUserId(int userId, CancellationToken cancellationToken = default)
        {
            var familyLinks = await DbSet
            .FromSqlRaw(@"
        select *
        from FamilyLinks as fl
        WHERE fl.UserId = {0}", userId)
            .ToListAsync();

            return familyLinks;
        }

    }
}
