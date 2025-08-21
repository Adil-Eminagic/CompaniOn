using CompaniOn.Core.Dtos.Reminder;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Validators
{
    public class ReminderValidator : AbstractValidator<ReminderUpsertDto>
    {
        public ReminderValidator()
        {
            RuleFor(x => x.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(x => x.Type).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(x => x.Time).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }

    }
}
