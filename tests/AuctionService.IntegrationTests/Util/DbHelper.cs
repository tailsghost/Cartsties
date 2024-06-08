using AuctionService.Data;
using AuctionService.Entities;

namespace AuctionService.IntegrationTests.Util;

public static class DbHelper
{
    public static void InitDbForTest(AuctionDbContext context)
    {
        context.Auctions.AddRange(GetAuctionsForTest());
        context.SaveChanges();
    }

    public static void ReinitDbForTests(AuctionDbContext context)
    {
        context.Auctions.RemoveRange(context.Auctions);
        context.SaveChanges();
        InitDbForTest(context);
    }

    private static List<Auction> GetAuctionsForTest()
    {
        return new List<Auction>
        {
            new Auction
            {
                Id = Guid.Parse("afbee524-5972-4075-8800-7d1f9d7b0a0c"),
                Status = Status.Live,
                ReservePrice = 20000,
                Seller = "bob",
                AuctionEnd = DateTime.UtcNow.AddDays(10),
                Item = new Item
                {
                    Make = "Ford",
                    Model = "GT",
                    Color = "Red",
                    Mileage = 50000,
                    Year = 2020,
                    ImageUrl = "https://wroom.ru/i/cars2/ford_gt_1.jpg"
                }
            },
            new Auction
            {
                Id = Guid.Parse("c8c3ec17-01bf-49db-82aa-1ef80b833a9f"),
                Status = Status.Live,
                ReservePrice = 90000,
                Seller = "alice",
                AuctionEnd = DateTime.UtcNow.AddDays(60),
                Item = new Item
                {
                    Make = "Bugatti",
                    Model = "Veyron",
                    Color = "Black",
                    Mileage = 15035,
                    Year = 2018,
                    ImageUrl = "https://wroom.ru/i/cars2/bugatti_veyron_1.jpg"
                }
            },
            new Auction
            {
                Id = Guid.Parse("bbab4d5a-8565-48b1-9450-5ac2a5c4a654"),
                Status = Status.Live,
                Seller = "bob",
                AuctionEnd = DateTime.UtcNow.AddDays(4),
                Item = new Item
                {
                    Make = "Ford",
                    Model = "Mustang",
                    Color = "Yellow",
                    Mileage = 65125,
                    Year = 2023,
                    ImageUrl = "https://wroom.ru/i/cars2/ford_mustang_6.jpg"
                }
            },
            new Auction
            {
                Id = Guid.Parse("155225c1-4448-4066-9886-6786536e05ea"),
                Status = Status.ReserveNotMet,
                ReservePrice = 50000,
                Seller = "tom",
                AuctionEnd = DateTime.UtcNow.AddDays(-10),
                Item = new Item
                {
                    Make = "Mercedes",
                    Model = "SLK",
                    Color = "Blue",
                    Mileage = 15001,
                    Year = 2020,
                    ImageUrl = "https://wroom.ru/i/cars2/mercedesbenz_slk_1.jpg"
                }
            },
            new Auction
            {
                Id = Guid.Parse("466e4744-4dc5-4987-aae0-b621acfc5e39"),
                Status = Status.Live,
                ReservePrice = 20000,
                Seller = "alice",
                AuctionEnd = DateTime.UtcNow.AddDays(30),
                Item = new Item
                {
                    Make = "BMW",
                    Model = "X1",
                    Color = "Red",
                    Mileage = 90000,
                    Year = 2017,
                    ImageUrl = "https://wroom.ru/i/cars2/bmw_x1_3.jpg"
                }
            },
            new Auction
            {
                Id = Guid.Parse("dc1e4071-d19d-459b-b848-b5c3cd3d151f"),
                Status = Status.Live,
                ReservePrice = 20000,
                Seller = "bob",
                AuctionEnd = DateTime.UtcNow.AddDays(45),
                Item = new Item
                {
                    Make = "Ferrari",
                    Model = "Spider",
                    Color = "Blue",
                    Mileage = 50000,
                    Year = 2015,
                    ImageUrl = "https://wroom.ru/i/cars2/ferrari_f8_1.jpg"
                }
            }
        };
    }
}
