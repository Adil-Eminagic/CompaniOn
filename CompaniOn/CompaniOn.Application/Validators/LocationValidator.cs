using CompaniOn.Core;
using CompaniOn.Core.Dtos.Location;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Application.Validators
{
    public class LocationValidator : AbstractValidator<LocationUpsertDto>
    {
        public LocationValidator()
        {

        }
    }
}
