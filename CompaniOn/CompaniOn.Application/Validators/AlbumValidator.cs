using FluentValidation;

using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class AlbumValidator : AbstractValidator<AlbumUpsertDto>
    {
        public AlbumValidator()
        {
            RuleFor(u => u.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(u => u.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
