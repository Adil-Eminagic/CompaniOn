using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class AlbumProfile : BaseProfile
    {
        public AlbumProfile()
        {
            CreateMap<AlbumDto, Album>().ReverseMap();

            CreateMap<AlbumUpsertDto, Album>();

            CreateMap<AlbumUpsertDto, Album>()
                .ForMember(u => u.CoverPhoto, o => o.Ignore());
        }
    }
}
