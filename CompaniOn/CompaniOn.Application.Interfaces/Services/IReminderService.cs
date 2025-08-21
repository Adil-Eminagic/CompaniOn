using CompaniOn.Core.Dtos.Reminder;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Interfaces.Services
{
    public interface IReminderService : IBaseService<int,ReminderDto,ReminderUpsertDto,ReminderSearchObject>
    {
    }
}
