using Microsoft.EntityFrameworkCore;
using DragonBallApi.Models;
using System.Collections.Generic;
using System.Reflection.Emit;

namespace DragonBallApi.Data
{
    public class DragonBallContext : DbContext
    {
        public DragonBallContext(DbContextOptions<DragonBallContext> options) : base(options)
        {
        }

        public DbSet<Character> Characters { get; set; }
        public DbSet<Transformation> Transformations { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Character>()
                        .HasMany(c => c.Transformations)
                        .WithOne(t => t.Character)
                        .HasForeignKey(t => t.CharacterId);
        }
    }
}
