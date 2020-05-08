#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src

RUN apt-get update -yq 
RUN apt-get install curl gnupg -yq 
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get install -y nodejs

COPY ["Twitter Auto  Alt Text/Twitter Auto  Alt Text.csproj", "Twitter Auto  Alt Text/"]
RUN dotnet restore "Twitter Auto  Alt Text/Twitter Auto  Alt Text.csproj"
COPY . .
WORKDIR "/src/Twitter Auto  Alt Text"
RUN dotnet build "Twitter Auto  Alt Text.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Twitter Auto  Alt Text.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Twitter Auto  Alt Text.dll"]