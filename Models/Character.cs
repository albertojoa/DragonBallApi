using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace DragonBallApi.Models
{
    [Table("Characters")]
    public class Character
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }

        [MaxLength(25)]
        public string Name { get; set; }

        [MaxLength(35)]
        public string Ki { get; set; }

        [MaxLength(25)]
        public string Race { get; set; }

        [MaxLength(20)]
        public string Gender { get; set; }

        [Column(TypeName = "varchar(max)")]
        public string Description { get; set; }

        [MaxLength(35)]
        public string Affiliation { get; set; }


        // Relación con Transformations
        [JsonIgnore]
        public ICollection<Transformation> Transformations { get; set; }
    }
}
