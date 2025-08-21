using CompaniOn.Core.Dtos.Reminder;
using CompaniOn.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Mapping
{
    public class ReminderProfile : BaseProfile
    {
        public ReminderProfile()
        {
            CreateMap<ReminderDto, Reminder>().ReverseMap();
            CreateMap<ReminderUpsertDto, Reminder>();
        }
    }
}
