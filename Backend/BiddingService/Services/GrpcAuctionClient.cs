using AuctionService;
using BiddingService.Models;
using Grpc.Net.Client;
using System.Globalization;

namespace BiddingService.Services;

public class GrpcAuctionClient
{
    private readonly ILogger<GrpcAuctionClient> _logger;
    private readonly IConfiguration _config;

    public GrpcAuctionClient(ILogger<GrpcAuctionClient> logger, IConfiguration config)
    {
        _logger = logger;
        _config = config;
    }

    public Auction GetAuction(string id)
    {
        _logger.LogInformation("Calling GRPC Service");
        var channel = GrpcChannel.ForAddress(_config["GrpcAuction"]);
        var client = new GrpcAuction.GrpcAuctionClient(channel);
        var request = new GetAuctionRequest { Id = id };

        try
        {
            var reply = client.GetAuction(request);
            CultureInfo provider = CultureInfo.InvariantCulture;
            var auction = new Auction
            {
                ID = reply.Auction.Id,
                AuctionEnd = DateTime.ParseExact("05/15/2024 20:28:43", "MM/dd/yyyy HH:mm:ss", provider),
                Seller = reply.Auction.Seller,
                ReservePrice = reply.Auction.ReservePrice,
            };

            return auction;
        } catch (Exception ex)
        {
            _logger.LogError(ex, "Could not call GRPC Service");
            return null;
        }
    }
}
