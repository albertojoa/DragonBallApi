using DragonBallApi.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace DragonBallApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TransformationsController : ControllerBase
    {
        private readonly DragonBallContext _context;

        public TransformationsController(DragonBallContext context)
        {
            _context = context;
        }

        // GET api/transformations
        [HttpGet]
        public async Task<IActionResult> GetAllTransformations()
        {
            var transformations = await _context.Transformations.ToListAsync();
            return Ok(transformations);
        }
    }
}
