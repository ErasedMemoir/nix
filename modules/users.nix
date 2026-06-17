{
  users.users.vm = {
    uid = 1000;
    password = "vm";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;
}
