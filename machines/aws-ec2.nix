{ modulesPath, ... }: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
    ../modules/headless.nix
  ];

  ec2.hvm = true;
}
