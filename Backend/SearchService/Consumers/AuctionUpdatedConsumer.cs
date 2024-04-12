using AutoMapper;
using Contracts;
using MassTransit;
using MongoDB.Entities;
using SearchService.Models;

namespace SearchService.Consumers;

public class AuctionUpdatedConsumer: IConsumer<AuctionUpdated>
{
    private readonly IMapper _mapper;

    public AuctionUpdatedConsumer(IMapper mapper)
    {
        _mapper = mapper;
    }
    public async Task Consume(ConsumeContext<AuctionUpdated> context)
    {
        Console.WriteLine("--> Consuming auction updated: " + context.Message.Id);

        var item = new Item
        {
            Model = context.Message.Model,
            Color = context.Message.Color,
            ID = context.Message.Id,
            Mileage = context.Message.Mileage,
            Make = context.Message.Make,
            Year = context.Message.Year,
        };

        var auction = await DB.Find<Item>().OneAsync(context.Message.Id);

        var result = await DB.Update<Item>()
            .Match(a => a.ID == context.Message.Id)
            .ModifyOnly(x => new
            {
                x.Color,
                x.Make,
                x.Model,
                x.Year,
                x.Mileage,

            }, item)
            .ExecuteAsync();

        if (!result.IsAcknowledged) 
            throw new MessageException(typeof(AuctionUpdated), "Problem updating mongodb");
    }
}
