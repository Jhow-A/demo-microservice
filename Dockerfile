FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY DemoMicroservice.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c release -o /app
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT [ "dotnet", "DemoMicroservice.dll" ]
