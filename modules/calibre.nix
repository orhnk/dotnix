{
  ulib,
  pkgs,
  ...
}:
with ulib;
  merge
  (let
    library = "/run/media/nixos/HDD-2TB/Kütübhane/";
  in
    systemConfiguration {
      services.calibre-web = enabled {
        openFirewall = true;
        listen = {
          ip = "192.168.1.11";
          port = 8081;
        };
        options = {
          calibreLibrary = library;
          enableBookConversion = true;
          enableBookUploading = true;
          enableKepubify = true;
        };
      };

      services.calibre-server = enabled {
        host = "192.168.1.11";
        port = 8080;
        libraries = [library];
      };

      # networking.firewall.allowedTCPPorts = [8080 8081];
      networking.firewall = disabled;
    })
  (graphicalPackages (with pkgs; [
    calibre # Ebook Manager
    calibre-web
  ]))
