using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace WebStore.ViewModels
{
    public class EditUserViewModel
    {
        public string Id { get; set; }

        [Display(Name = "Email")]
        public string Email { get; set; }

        [Display(Name = "Username")]
        public string UserName { get; set; }

        public IFormFile UploadedFile { get; set; }
    }
}