using System.Collections;
using System.Collections.Generic;

namespace WebStore.Models
{
    public class UserBin : IEnumerable
    {
        public List<Product> Bin { get; set; }
        public Product Offer { get; set; }

        public UserBin()
        {
            Bin ??= new List<Product>();
        }

        public UserBin(List<Product> bin, Product offer)
        {
            Bin = bin;
            Offer = offer;
        }

        public IEnumerator GetEnumerator()
        {
            return Bin.GetEnumerator();
        }
    }
}