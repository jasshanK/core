{ ... }:

{
  services.nebula.networks.mynetwork = {
    enable = true;

    ca = /var/lib/nebula/ca.crt;
    cert = /var/lib/nebula/personal_laptop.crt;
    key = /var/lib/nebula/personal_laptop.key;
    
    isLighthouse = false;
    
    staticHostMap = {
      "192.168.252.1" = [ "172.104.185.56:4242" ];
    };

    settings = {
      lighthouse = {
        am_lighthouse = false;
        interval = 60;
        hosts = [ "192.168.252.1" ];
      };
      
      firewall = {
        outbound = [
          { port = "any"; proto = "any"; host = "any"; }
        ];
        inbound = [
          { port = "any"; proto = "any"; host = "any"; }
        ];
      };
    };
  };

  networking.firewall.allowedUDPPorts = [ 4242 ];
}
