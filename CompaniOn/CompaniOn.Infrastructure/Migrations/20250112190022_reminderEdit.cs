using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CompaniOn.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class reminderEdit : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "IsVoiceEnabled",
                table: "Reminder",
                newName: "Repeat");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Repeat",
                table: "Reminder",
                newName: "IsVoiceEnabled");
        }
    }
}
