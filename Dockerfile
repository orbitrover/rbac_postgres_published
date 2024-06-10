#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY . ./core.rbac_postgres/
WORKDIR /src/core.rbac_postgres
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "core.rbac_postgres.dll"]
