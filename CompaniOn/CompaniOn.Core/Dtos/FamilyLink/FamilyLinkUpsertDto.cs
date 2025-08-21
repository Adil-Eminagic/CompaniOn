namespace CompaniOn.Core.Dtos.FamilyLink
{
    public class FamilyLinkUpsertDto:BaseUpsertDto
    {
        public int UserId { get; set; }

        public int FamilyMemberId { get; set; }

        public string Status { get; set; }

        public bool SharedLocation { get; set; }

        public bool SharedReminders { get; set; }

        public string Kinship { get; set; } = null!;
    }
}
