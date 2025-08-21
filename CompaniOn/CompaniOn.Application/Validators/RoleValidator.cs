using FluentValidation;

using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class RoleValidator : AbstractValidator<RoleUpsertDto>
    {
        public RoleValidator()
        {
            RuleFor(u => u.Value).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
           
        }
    }
}
