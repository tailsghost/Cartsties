FROM mcr.microsoft.com/dotnet/sdk:8.0 as build 
WORKDIR /
EXPOSE 80

# copy all .csproj files and restore as distinct layers. Use of the same COPY command
# for every dockerfile in the project to take advantage of docker caching

COPY Cartsties.sln Cartsties.sln

COPY Backend/AuctionService/AuctionService.csproj Backend/AuctionService/AuctionService.csproj
COPY Backend/SearchService/SearchService.csproj Backend/SearchService/SearchService.csproj
COPY Backend/GatewayService/GatewayService.csproj Backend/GatewayService/GatewayService.csproj
COPY Backend/Contracts/Contracts.csproj Backend/Contracts/Contracts.csproj
COPY Backend/IdentityService/IdentityService.csproj Backend/IdentityService/IdentityService.csproj
COPY Backend/BiddingService/BiddingService.csproj Backend/BiddingService/BiddingService.csproj
COPY Backend/NotificationService/NotificationService.csproj Backend/NotificationService/NotificationService.csproj
COPY tests/AuctionService.UnitTests/AuctionService.UnitTests.csproj tests/AuctionService.UnitTests/AuctionService.UnitTests.csproj
COPY tests/AuctionService.IntegrationTests/AuctionService.IntegrationTests.csproj tests/AuctionService.IntegrationTests/AuctionService.IntegrationTests.csproj

#Restore package desp

RUN dotnet restore Cartsties.sln


# Copy the app folder over

COPY Backend/IdentityService Backend/IdentityService
WORKDIR Backend/IdentityService
RUN dotnet publish -c Release -o /app/out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /
COPY --from=build /app/out .
ENTRYPOINT [ "dotnet", "IdentityService.dll" ]