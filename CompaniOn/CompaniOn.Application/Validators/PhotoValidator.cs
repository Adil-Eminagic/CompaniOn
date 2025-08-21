using FluentValidation;

using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class PhotoValidator : AbstractValidator<PhotoUpsertDto>
    {
        public PhotoValidator()
        {
            RuleFor(c => c.Data).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
          
        }
    }
}
