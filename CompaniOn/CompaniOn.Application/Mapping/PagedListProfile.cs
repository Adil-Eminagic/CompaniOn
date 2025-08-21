using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class PagedListProfile : BaseProfile
    {
        public PagedListProfile()
        {
            CreateMap(typeof(PagedList<>), typeof(PagedList<>));
        }
    }
}
