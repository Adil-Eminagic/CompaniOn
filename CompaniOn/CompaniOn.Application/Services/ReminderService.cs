using AutoMapper;
using CompaniOn.Application.Interfaces.Services;
using CompaniOn.Core.Dtos.Reminder;
using CompaniOn.Core.Entities;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces.Repositories;
using CompaniOn.Infrastructure.Interfaces.SearchObjects;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Services
{
    public class ReminderService : BaseService<Reminder, ReminderDto, ReminderUpsertDto, ReminderSearchObject, IReminderRepository>, IReminderService
    {
        public ReminderService(IMapper mapper,IUnitOfWork unitOfWork,IValidator<ReminderUpsertDto> validator) : base (mapper, unitOfWork, validator)
        {
            
        }
    }
}
