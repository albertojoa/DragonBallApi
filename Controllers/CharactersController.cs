using DragonBallApi.Data;
using DragonBallApi.Models;
using DragonBallApi.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Threading.Tasks;

namespace DragonBallApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CharactersController : ControllerBase
    {
        private readonly DragonBallContext _context;
        private readonly IDragonBallService _dragonBallService;

        public CharactersController(DragonBallContext context, IDragonBallService dragonBallService)
        {
            _context = context;
            _dragonBallService = dragonBallService;
        }

        // GET api/characters
        [HttpGet]
        public async Task<IActionResult> GetAllCharacters()
        {
            var characters = await _context.Characters
                .ToListAsync();
            return Ok(characters);
        }

        // GET api/characters/{id}
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCharacterById(int id)
        {
            var character = await _context.Characters
                .FirstOrDefaultAsync(c => c.Id == id);

            if (character == null)
            {
                return NotFound();
            }

            return Ok(character);
        }

        // GET api/characters/name/{name}
        [HttpGet("name/{name}")]
        public async Task<IActionResult> GetCharacterByName(string name)
        {
            var character = await _context.Characters
                .FirstOrDefaultAsync(c => c.Name == name);

            if (character == null)
            {
                return NotFound();
            }

            return Ok(character);
        }

        // GET api/characters/affiliation/{affiliation}
        [HttpGet("affiliation/{affiliation}")]
        public async Task<IActionResult> GetCharactersByAffiliation(string affiliation)
        {
            var characters = await _context.Characters
                .Where(c => c.Affiliation == affiliation)
                .ToListAsync();

            return Ok(characters);
        }

        // POST api/characters/sync
        [HttpPost("sync")]
        public async Task<IActionResult> SyncCharacters()
        {
            try
            {
                await _dragonBallService.SyncCharactersAndTransformations();
                return Ok(new { Message = "Sincronización exitosa" });
            }
            catch (Exception ex)
            {
                return BadRequest(new
                {
                    Error = ex.Message,
                    Inner = ex.InnerException?.Message
                });
            }
        }
    }
}
