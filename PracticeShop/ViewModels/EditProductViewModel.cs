namespace WebStore.ViewModels
{
    public class EditProductViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Manufacturer { get; set; }
        public string Description { get; set; }
        public double Price { get; set; }
        public string SerialNumber { get; set; }
        public string Image { get; set; }
    }
}