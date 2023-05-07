using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebStore.Models;
using WebStore.ViewModels;

namespace WebStore.Controllers
{
    public class StoreController : Controller
    {
        private static UserBin finalBin;
        private static List<Product> _bin;
        private StoreContextDb _db { get; }

        public StoreController(StoreContextDb context)
        {
            _db = context;
        }

        [HttpGet]
        public IActionResult Index()
        {
            var devices = _db.Products.ToList();
            return View(devices);
        }

        private bool CheckStore(Product model) => _db.Products.Where(g => g.Name == model.Name).ToList().Count > 0;

        [HttpGet]
        [Authorize(Roles = "admin")]
        public IActionResult AddProduct() => View();

        [HttpPost]
        [Authorize(Roles = "admin")]
        public async Task<IActionResult> AddProduct(Product model)
        {
            if (!CheckStore(model))
            {
                await _db.Products.AddAsync(model);
                await _db.SaveChangesAsync();

                return RedirectToAction("Index", "Store");
            }
            else
                return Content("ERROR");
        }

        public IActionResult DeleteProduct() => View(_db.Products.OrderBy(item => item.Name));

        [HttpPost]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            _db.Products.Remove(_db.Products.Where(item => item.Id == id).First());
            await _db.SaveChangesAsync();

            return RedirectToAction("Index", "Store");
        }

        public IActionResult EditProductView() => View(_db.Products.OrderBy(item => item.Name));

        [HttpGet]
        public IActionResult EditProduct(int id)
        {
            Product product = _db.Products.Find(id);

            if (product == null)
                return NotFound();

            EditProductViewModel model = new EditProductViewModel
            {
                Name = product.Name,
                Manufacturer = product.Manufacturer,
                Description = product.Description,
                Price = product.Price,
                SerialNumber = product.SerialNumber,
                Image = product.Image
            };

            return View(model);
        }

        [HttpPost]
        public async Task<IActionResult> EditGame(EditProductViewModel model)
        {
            Product product = _db.Products.Find(model.Id);

            if (ModelState.IsValid)
            {
                if (product != null)
                {
                    product.Name = product.Name;
                    product.Manufacturer = product.Manufacturer;
                    product.Description = product.Description;
                    product.Price = product.Price;
                    product.SerialNumber = product.SerialNumber;
                    product.Image = product.Image;

                    await _db.SaveChangesAsync();
                }
            }

            return RedirectToAction("Index", "Home");
        }

        public IActionResult Privacy() => View();

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error() => View(new ErrorViewModel
        {
            RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier
        });

        [HttpGet]
        public IActionResult SearchItemPage()
        {
            return View();
        }

        [HttpGet]
        public IActionResult SearchItem(string searchQuery)
        {
            var devices = _db.Products.AsEnumerable().ToList();
            var result = devices.Where(item => item.Name.Contains(searchQuery, StringComparison.OrdinalIgnoreCase)
                                            || item.Description.Contains(searchQuery, StringComparison.OrdinalIgnoreCase)
                                            || item.SerialNumber.Contains(searchQuery, StringComparison.OrdinalIgnoreCase)
                                            || item.Manufacturer.Contains(searchQuery, StringComparison.OrdinalIgnoreCase)
                                       ).ToList();

            return View("SearchResult", result);
        }

        [HttpGet]
        public IActionResult ShowTransactions() => View(_db.Transactions.Where(item => item.UserName.Equals(User.Identity.Name)));

        [HttpPost]
        public IActionResult AddToBin(int id)
        {
            _bin ??= new List<Product>();
            _bin.Add(_db.Products.Find(id));

            return RedirectToAction("Index", "Store");
        }

        [HttpPost]
        public IActionResult DeleteFromBin(int id)
        {
            _bin.Remove(_bin.Where(l => l.Id.Equals(id)).ToList().First());

            return RedirectToAction("Index", "Store");
        }

        private Product Apriori()
        {
            if (finalBin == null || finalBin.Bin == null || !finalBin.Bin.Any())
                return null;

            int transactionsCount = _db.Transactions.Count();
            double countSupp;
            double countConf = 0;

            Product temp = new Product();

            List<AprioriStats> stats = _db.Products.Select(device => new AprioriStats
            {
                Product = device
            }).ToList();

            var transactions = _db.Transactions.ToList();
            var products = _db.Products.ToList();
            var item = _bin[new Random().Next(0, _bin.Count - 1)];

            foreach (var transaction in transactions)
            {
                if (transaction.SerialNumber.Contains(item.SerialNumber))
                    countConf++;
            }

            foreach (var device in products)
            {
                countSupp = 0;

                foreach (var transaction in transactions)
                {
                    if (transaction.SerialNumber.Contains(item.SerialNumber) && transaction.SerialNumber.Contains(device.SerialNumber))
                        countSupp++;

                    stats.Where(item => item.Product.SerialNumber == device.SerialNumber).First().Support = countSupp / transactionsCount;
                    stats.Where(item => item.Product.SerialNumber == device.SerialNumber).First().Confidence = countConf / countSupp;
                    stats.Where(item => item.Product.SerialNumber == device.SerialNumber).First().Lift =
                        stats.Where(item => item.Product.SerialNumber == device.SerialNumber).First().Support /
                        stats.Where(item => item.Product.SerialNumber == device.SerialNumber).First().Confidence;
                }
            }

            double previousRes = 0;

            foreach (var product in stats)
            {
                if (product.Product.SerialNumber.Contains(item.SerialNumber))
                    continue;

                if (previousRes < product.Lift)
                {
                    previousRes = product.Lift;
                    temp = product.Product;
                }
            }

            if (string.IsNullOrEmpty(temp.SerialNumber))
                return null;

            return temp;
        }

        [HttpGet]
        public IActionResult UserBin()
        {
            finalBin = new UserBin(_bin, Apriori());

            return View(finalBin);
        }

        [HttpPost]
        public IActionResult Buy()
        {
            List<string> serialNumbers = new List<string>();
            List<double> prices = new List<double>();

            foreach (var i in _bin)
            {
                serialNumbers.Add(i.SerialNumber);
                prices.Add(i.Price);
            }

            _db.Transactions.AddRange(new Transaction
            {
                UserName = User.Identity.Name,
                Date = DateTime.Now.ToString(CultureInfo.CurrentCulture),
                SerialNumber = JsonSerializer.Serialize(serialNumbers),
                Price = JsonSerializer.Serialize(prices)
            });

            _db.SaveChanges();
            _bin.Clear();

            return RedirectToAction("Index");
        }
    }
}