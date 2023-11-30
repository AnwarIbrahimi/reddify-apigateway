using Ocelot.DependencyInjection;
using Ocelot.Middleware;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(o => o.AddPolicy("AllowAnyOrigins", builder =>
{
    builder.AllowAnyOrigin()
        .AllowAnyHeader()
        .AllowAnyMethod();
}));

builder.Configuration.AddJsonFile("ocelot.json", optional: false, reloadOnChange: true);
builder.Services.AddOcelot(builder.Configuration);

var app = builder.Build();
app.UseCors("AllowAnyOrigins");
await app.UseOcelot();
app.MapGet("/", () => "Hello World!");
app.MapControllers();



app.Run();
