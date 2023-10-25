namespace backend;

public class WeatherForecast
{
    public int storyId { get; set; }
    public required string title { get; set; }
    public required string summary { get; set; }
    public required string modifiedAt { get; set; }
    public required string image { get; set; }

    public WeatherForecast(int storyId, string title, string summary, string modifiedAt, string image)
    {
        this.storyId = storyId;
        this.title = title;
        this.summary = summary;
        this.modifiedAt = modifiedAt;
        this.image = image;
    }

}
