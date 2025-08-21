using CompaniOn.Core.Dtos.FamilyLink;
using FluentValidation;

namespace CompaniOn.Application.Validators
{
    public class FamilyLinkValidator : AbstractValidator<FamilyLinkUpsertDto>
    {
        public FamilyLinkValidator()
        {
            RuleFor(x => x.Kinship).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
