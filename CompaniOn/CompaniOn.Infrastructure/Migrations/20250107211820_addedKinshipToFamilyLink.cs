using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CompaniOn.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class addedKinshipToFamilyLink : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Kinship",
                table: "FamilyLinks",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Kinship",
                table: "FamilyLinks");
        }
    }
}
