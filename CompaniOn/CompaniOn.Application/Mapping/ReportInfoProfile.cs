
using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class ReportInfoProfile:BaseProfile
    {
        public ReportInfoProfile()
        {
            CreateMap(typeof(ReportInfo<>), typeof(ReportInfo<>));
        }
    }
}
