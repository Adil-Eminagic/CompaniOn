using CompaniOn.Core.Dtos.Notification;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Validators
{
    public class NotificationValidator : AbstractValidator<NotificationUpsertDto>
    {
        public NotificationValidator()
        {
            RuleFor(x => x.SenderId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(x => x.ReceiverId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(x => x.Title).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
