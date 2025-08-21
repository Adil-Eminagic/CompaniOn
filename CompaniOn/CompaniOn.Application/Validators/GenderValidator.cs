using FluentValidation;

using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class GenderValidator : AbstractValidator<GenderUpsertDto>
    {
        public GenderValidator()
        {
            RuleFor(u => u.Value).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
          
        }
    }
}
