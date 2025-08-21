using CompaniOn.Core;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Repositories
{
    public class ReminderRepository : BaseRepository<Reminder, int, ReminderSearchObject>, IReminderRepository
    {
        public ReminderRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async override Task<PagedList<Reminder>> GetPagedAsync(ReminderSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => searchObject.UserId == null || x.UserId == searchObject.UserId).Where(x => searchObject.Type == null || x.Type.ToLower().Contains(searchObject.Type.ToLower()))
                .Where(x => searchObject.Time == null || x.Time == searchObject.Time).ToPagedListAsync(searchObject, cancellationToken);
        }

        public async override Task<ReportInfo<Reminder>> GetCountAsync(ReminderSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(x => searchObject.UserId == null || x.UserId == searchObject.UserId).Where(x => searchObject.Type == null || x.Type.ToLower().Contains(searchObject.Type.ToLower()))
                .Where(x => searchObject.Time == null || x.Time == searchObject.Time).ToReportInfoAsync(searchObject, cancellationToken);
        }
    }
}
