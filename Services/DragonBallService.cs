using DragonBallApi.Data;
using DragonBallApi.DTOs;
using DragonBallApi.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace DragonBallApi.Services
{
    public class DragonBallService : IDragonBallService
    {
        private readonly DragonBallContext _context;
        private readonly IHttpClientFactory _httpClientFactory;
        private const string CharactersEndpoint = "https://dragonball-api.com/api/characters";
        private const string TransformationsEndpoint = "https://dragonball-api.com/api/transformations";

        public DragonBallService(DragonBallContext context, IHttpClientFactory httpClientFactory)
        {
            _context = context;
            _httpClientFactory = httpClientFactory;
        }


        public async Task SyncCharactersAndTransformations()
        {
            //  verificar datos en tablas
            bool hasCharacters = await _context.Characters.AnyAsync();
            bool hasTransformations = await _context.Transformations.AnyAsync();

            if (hasCharacters || hasTransformations)
            { 
                throw new Exception("Las tablas no están vacías. Por favor, limpia los datos antes de sincronizar.");
            }

            var client = _httpClientFactory.CreateClient();

            var charactersResponse = await client.GetStringAsync(CharactersEndpoint);
            var charDoc = JsonDocument.Parse(charactersResponse);
            var charactersItemsJson = charDoc.RootElement.GetProperty("items").GetRawText();

            var allCharacters = JsonSerializer.Deserialize<List<Character>>(charactersItemsJson,
                new JsonSerializerOptions { PropertyNameCaseInsensitive = true });


            //guardar solo saiyan
            var saiyanCharacters = allCharacters
                .Where(c => c.Race?.Equals("Saiyan", StringComparison.OrdinalIgnoreCase) == true)
                .ToList();

            await _context.Characters.AddRangeAsync(saiyanCharacters);
            await _context.SaveChangesAsync();


            var transformationsResponse = await client.GetStringAsync(TransformationsEndpoint);
            var allTransformationsDto = JsonSerializer.Deserialize<List<TransformationDto>>(transformationsResponse,
                new JsonSerializerOptions { PropertyNameCaseInsensitive = true });

            var filteredTransformations = new List<Transformation>();

            // mapear Z Fighter
            foreach (var dto in allTransformationsDto)
            {
                var tokens = dto.Name.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                if (tokens.Length == 0)
                    continue;
                var candidateCharacterName = tokens[0];

                var matchingCharacter = saiyanCharacters.FirstOrDefault(c =>
                    c.Name.Equals(candidateCharacterName, StringComparison.OrdinalIgnoreCase) &&
                    c.Affiliation?.Equals("Z Fighter", StringComparison.OrdinalIgnoreCase) == true);

                if (matchingCharacter != null)
                {
                    filteredTransformations.Add(new Transformation
                    {
                        Id = dto.Id,
                        Name = dto.Name,
                        Ki = dto.Ki,
                        CharacterId = matchingCharacter.Id
                    });
                }
            }

            //guardar
            await _context.Transformations.AddRangeAsync(filteredTransformations);
            await _context.SaveChangesAsync();
        }
    }

    
}
