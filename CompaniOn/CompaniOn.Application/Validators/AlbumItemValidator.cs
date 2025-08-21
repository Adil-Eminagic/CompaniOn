using FluentValidation;

using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class AlbumItemValidator : AbstractValidator<AlbumItemUpsertDto>
    {
        public AlbumItemValidator()
        {
            RuleFor(u => u.AlbumId).NotEmpty().WithErrorCode(ErrorCodes.NotNull);
           
        }
    }
}
