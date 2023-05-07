using Microsoft.EntityFrameworkCore;

namespace WebStore.Models
{
    public sealed class StoreContextDb : DbContext
    {
        public DbSet<Product> Products { get; set; }
        public DbSet<Transaction> Transactions { get; set; }

        public StoreContextDb(DbContextOptions<StoreContextDb> options) : base(options)
        {
            Database.EnsureCreated();
        }
    }
}