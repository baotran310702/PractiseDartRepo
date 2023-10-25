using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class WeatherForecastController : ControllerBase
{
    private static readonly string[] Summaries = new[]
    {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
    };

    private readonly ILogger<WeatherForecastController> _logger;

    public WeatherForecastController(ILogger<WeatherForecastController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public IEnumerable<WeatherForecast> Get()
    {
        var data = Data.GetData();
        List<WeatherForecast> listWeathers = new();
        for (int i = 0; i < data.Length; i++)
        {
            dynamic currentObject = data[i];
            WeatherForecast weatherForecast = new(currentObject.storyId, currentObject.title,
                                                                  currentObject.summary, currentObject.modifiedAt,
                                                                  currentObject.image);
            listWeathers.Add(weatherForecast);
        }

        return listWeathers.ToList();
    }
}
