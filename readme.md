- [Summary](#summary)
- [Requirements](#requirements)
  - [Installation](#installation)
- [Auto-download configuration](#auto-download-configuration)
  - [General](#general)
  - [Sonarr (TV)](#sonarr-tv)
  - [Radarr (Movies)](#radarr-movies)
- [Request UIs (Jellyseerr / Requestrr)](#request-uis-jellyseerr--requestrr)
- [Services and default ports](#services-and-default-ports)
- [Downloads](#downloads)
- [Accessing content](#accessing-content)
- [Usage](#usage)

## Summary

This repository deploys a home media server stack with Docker Compose including:

- Jellyfin (media server)
- Sonarr (TV series)
- Radarr (movies)
- Jackett (indexers)
- FlareSolverr (CAPTCHA resolver for some indexers)
- qBittorrent (download client)
- Jellyseerr (request UI for Jellyfin)
- Requestrr (optional request bot)

## Requirements

- A user with sudo privileges
- git and curl (`sudo apt install git curl`)
- Docker and Docker Compose
- Copy `example.env` to `.env` and edit `MEDIA_SERVER_PATH` and `MEDIA_PATH` to match your folders

### Installation

Clone the repo:

```bash
git clone https://github.com/jsilverdev/docker-media-server.git
cd docker-media-server
```

Create the folders you will use. Example layout:

```text
/home/user/
├── media-server
|   ├── jackett
|   ├── jellyfin
|   ├── radarr
|   └── sonarr
└── media-content
    └── media
        ├── movies
        ├── books
        └── tvseries
    └── downloads
```

Copy `example.env` to `.env` and edit `MEDIA_SERVER_PATH` and `MEDIA_PATH` to match your folders.

Start the stack (use the provided script):

```bash
chmod +x ./init.sh
./init.sh
```



## Auto-download configuration

### General

Configure Jackett at `http://localhost:9117` to add indexers (e.g. 1337x, EZTV) and obtain Torznab feeds and API keys.

Configure qBittorrent Web UI (default `http://localhost:8080`) for speed limits and schedules as needed.

### Sonarr (TV)

Interface: `http://localhost:8989`

Settings > Indexers: add Jackett indexers (filter for TV shows).

### Radarr (Movies)

Interface: `http://localhost:7878`

Settings > Indexers: add Jackett indexers (filter for movies).

## Request UIs (Jellyseerr / Requestrr)

You can expose request interfaces so users can request movies or TV shows for the server:

- Jellyseerr: Web UI at `http://localhost:5055` (default). Configure connections to Jellyfin, Sonarr and Radarr in the Jellyseerr settings.
- Requestrr: Web UI at `http://localhost:4545` (default). Configure it to forward requests to Sonarr/Radarr and to your notification/chat platform.

Both services read configuration from the environment and volumes defined in `docker-compose.yaml`. Adjust ports in `example.env` if needed.

If you want users to request content via a friendly UI, enable and configure `jellyseerr` (recommended) and/or `requestrr`.

## Services and default ports

- Jellyfin: 8096 (HTTP), 8920 (optional HTTPS)
- Sonarr: 8989
- Radarr: 7878
- Jackett: 9117
- FlareSolverr: used internally by Jackett
- qBittorrent (Web UI): 8080
- Jellyseerr: 5055
- Requestrr: 4545

> Note: Ports can be overridden with environment variables in `default.env`.

## Downloads

Add series in Sonarr and movies in Radarr. Both use qBittorrent to download and move files into the `MEDIA_PATH` locations.

## Accessing content

Open Jellyfin at `http://localhost:8096` (or `https://localhost:8920` if you configure TLS). From other devices on your LAN, replace `localhost` with the server IP.

## Usage

- Add/monitor content in Sonarr/Radarr.
- Let qBittorrent download and complete transfers.
- Stream content in Jellyfin.


