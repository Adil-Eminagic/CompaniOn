using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Infrastructure.Interfaces.Repositories
{
    public interface IReminderRepository : IBaseRepository<Reminder, int, ReminderSearchObject>
    {
    }
}
