using CompaniOn.Core.Dtos.Notification;
using CompaniOn.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Mapping
{
    public class NotificationProfile : BaseProfile
    {
        public NotificationProfile()
        {
            CreateMap<NotificationDto, Notification>().ReverseMap();
            CreateMap<NotificationUpsertDto, Notification>();
        }
    }
}
