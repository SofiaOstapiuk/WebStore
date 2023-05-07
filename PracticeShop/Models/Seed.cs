using System.Linq;

namespace WebStore.Models
{
    public static class Seed
    {
        public static void Initialize(StoreContextDb context)
        {
            if (context.Products.Any())
                return;

            context.AddRange(
                new Product
                {
                    Name = "PERSBOL Armchair",
                    Manufacturer = "PERSBOL",
                    Description = "Armchair, black/Tibbleby beige/gray",
                    Price = 199.99,
                    SerialNumber = "805.259.14",
                    Image = "\\Images\\Products\\PERSBOL.webp"
                },

                new Product
                {
                    Name = "STRANDMON Wing chair",
                    Manufacturer = "STRANDMON",
                    Description = "Wing chair, Skiftebo yellow",
                    Price = 369.00,
                    SerialNumber = "203.618.97",
                    Image = "\\Images\\Products\\STRANDMON.webp"
                },

                new Product
                {
                    Name = "POÄNG Armchair",
                    Manufacturer = "POÄNG",
                    Description = "Armchair, brown/Skiftebo dark gray",
                    Price = 119.00,
                    SerialNumber = "893.884.70",
                    Image = "\\Images\\Products\\POÄNG.webp"
                },

                new Product
                {
                    Name = "EKERÖ Armchair",
                    Manufacturer = "EKERÖ",
                    Description = "Armchair, Skiftebo yellow",
                    Price = 159.00,
                    SerialNumber = "702.628.90",
                    Image = "\\Images\\Products\\EKERÖ.webp"
                },

                new Product
                {
                    Name = "JÄTTEBO Cover 1-seat module with storage",
                    Manufacturer = "JÄTTEBO",
                    Description = "Cover 1-seat module with storage, Samsala dark yellow-green",
                    Price = 40.00,
                    SerialNumber = "105.289.73",
                    Image = "\\Images\\Products\\JÄTTEBO.webp"
                }
            );
            context.SaveChanges();
        }
    }
}