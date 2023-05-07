namespace WebStore.Models
{
    public class Transaction
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string Date { get; set; }
        public string SerialNumber { get; set; }
        public string Price { get; set; }
    }
}