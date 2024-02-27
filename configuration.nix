{ config, pkgs, inputs, ... }:
let 
  debugdriver = pkgs.callPackage ./module.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in
{
  boot.kernelPatches = [
    {
      name = "Rust Support";
      patch = null;
      features = { rust = true; };
    }
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [
    debugdriver
  ];
  boot.kernelModules = [ "debugdriver" ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [
      vim
    ];
    initialPassword = "test";
  };

  security.sudo.wheelNeedsPassword = false;
  services.sshd.enable = true;

  system.stateVersion = "24.05";
}
