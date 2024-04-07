FROM mcr.microsoft.com/dotnet/sdk:8.0 as build 
WORKDIR /
EXPOSE 80

# copy all .csproj files and restore as distinct layers. Use of the same COPY command
# for every dockerfile in the project to take advantage of docker caching

COPY Cartsties.sln Cartsties.sln

COPY AuctionService/AuctionService.csproj AuctionService/AuctionService.csproj
COPY SearchService/SearchService.csproj SearchService/SearchService.csproj
COPY GatewayService/GatewayService.csproj GatewayService/GatewayService.csproj
COPY Contracts/Contracts.csproj Contracts/Contracts.csproj
COPY IdentityService/IdentityService.csproj IdentityService/IdentityService.csproj

#Restore package desp

RUN dotnet restore Cartsties.sln


# Copy the app folder over

COPY SearchService SearchService
COPY Contracts Contracts
WORKDIR /SearchService
RUN dotnet publish -c Release -o /app/out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /
COPY --from=build /app/out .
ENTRYPOINT [ "dotnet", "SearchService.dll" ]