using CompaniOn.Core.Dtos.Messages;
using CompaniOn.Core.Dtos.Reminder;
using CompaniOn.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Mapping
{
    public class MessageProfile : BaseProfile
    {
        public MessageProfile()
        {
            CreateMap<MessagesDto, MessageEntity>().ReverseMap();
            CreateMap<MessagesUpsertDto, MessageEntity>();
        }
    }
}
