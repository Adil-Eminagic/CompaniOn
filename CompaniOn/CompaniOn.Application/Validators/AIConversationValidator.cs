using FluentValidation;

using CompaniOn.Core;

namespace CompaniOn.Application
{
    public class AIConversationValidator : AbstractValidator<AIConversationUpsertDto>
    {
        public AIConversationValidator()
        {
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.Question).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.SentimentAnalysis).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(u => u.Timestamp).NotNull().WithErrorCode(ErrorCodes.NotNull);

        }
    }
}
