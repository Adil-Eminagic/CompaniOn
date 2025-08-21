using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class AlbumItemProfile : BaseProfile
    {
        public AlbumItemProfile()
        {
            CreateMap<AlbumItemDto, AlbumItem>().ReverseMap();

            CreateMap<AlbumItemUpsertDto, AlbumItem>();

            CreateMap<AlbumItemUpsertDto, AlbumItem>()
                .ForMember(u => u.Photo, o => o.Ignore());
        }
    }
}
