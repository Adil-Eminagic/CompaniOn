namespace CompaniOn.Infrastructure.Interfaces
{
    public class LocationSearchObject : BaseSearchObject
    {
        public int? UserId { get; set; }
        public bool? OrderByCreatedDate { get; set; }
    }
}