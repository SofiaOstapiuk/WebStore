namespace WebStore.Models
{
    public class AprioriStats
    {
        public double Support { get; set; }
        public double Confidence { get; set; }
        public double Lift { get; set; }
        public Product Product { get; set; }
    }
}