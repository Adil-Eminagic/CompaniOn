using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class AIConversationProfile : BaseProfile
    {
        public AIConversationProfile()
        {
            CreateMap<AIConversationDto, AIConversation>().ReverseMap();

            CreateMap<AIConversationUpsertDto, AIConversation>();
        }
    }
}
