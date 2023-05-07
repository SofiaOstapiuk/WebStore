using Microsoft.AspNetCore.Http;
using WebStore.Models;

namespace WebStore.ViewModels
{
    public class UserProfileViewModel
    {
        public User User { get; set; }

        public IFormFile Image { get; set; }
    }
}