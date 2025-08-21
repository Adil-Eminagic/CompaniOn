
using CompaniOn.Core;
using CompaniOn.Infrastructure.Interfaces;


namespace CompaniOn.Infrastructure
{
    public class GendersRepository : BaseRepository<Gender, int, BaseSearchObject>, IGendersRepository
    {
        public GendersRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
