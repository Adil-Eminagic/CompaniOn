using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CompaniOn.Core.Entities
{
    [Table("Locations")]
    public class Location:BaseEntity
    {

        [ForeignKey("UserId")]
        public User User { get; set; }
        public int UserId { get; set; }

        public decimal Latitude { get; set; }

        public decimal Longitude { get; set; }
    }

}
