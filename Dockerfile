# Use the official .NET SDK image as the build environmen
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Set the working directory inside the container
WORKDIR /app
EXPOSE 80

# Copy the project file and restore dependencies
COPY reddify-apigateway/*.csproj ./reddify-apigateway/
RUN dotnet restore ./reddify-apigateway/reddify-apigateway.csproj

# Copy the remaining source code
COPY . ./

# Build the application
RUN dotnet publish ./reddify-apigateway/reddify-apigateway.csproj -c Release -o out

# Use the official .NET runtime image as the final base image
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Set the working directory inside the container
WORKDIR /app

# Copy the published output from the build environment
COPY --from=build-env /app/out .

# Specify the entry point for the application
ENTRYPOINT ["dotnet", "reddify-apigateway.dll"]
