{
  config,
  ...
}: {

  microvm = {
    hypervisor = "qemu";
    mem = 8192;
    vcpu = 4;
    writableStoreOverlay = "/nix/.rw-store";
    registerClosure = true;
    volumes = [{
      image = "/tmp/nix-store-overlay.img";
      mountPoint = config.microvm.writableStoreOverlay;
      size = 10240;
    }];

    shares = [
      {
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
        proto = "9p";
      }
      {
        tag = "host-shared";
        source = ".";
        mountPoint = "/shared";
        proto = "9p";
        readOnly = true;
      }
    ];
    interfaces = [{
      type = "user";
      id = "qemu";
      mac = "02:00:00:01:01:01";
    }];
    forwardPorts = [{
      host.port = 2222;
      guest.port = 22;
    }];
  };

}

