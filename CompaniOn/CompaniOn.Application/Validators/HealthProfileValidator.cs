using CompaniOn.Core.Dtos.HealthProfile;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Validators
{
    public class HealthProfileValidator : AbstractValidator<HealthProfileUpsertDto>
    {
        public HealthProfileValidator()
        {
            RuleFor(x => x.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(x => x.HealthConditions).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(x => x.EmergencyContacts).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
