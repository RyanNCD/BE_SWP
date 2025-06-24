# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy and restore
COPY . .
RUN dotnet restore

# Build and publish
RUN dotnet publish -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Expose port
EXPOSE 80
ENTRYPOINT ["dotnet", "API_GHSMS.dll"]
