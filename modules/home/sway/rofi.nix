# sway/rofi.nix - Application launcher config
{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "minimal";
    extraConfig = {
      modi = "drun";
      show-icons = false;
      display-drun = "> ";
      drun-display-format = "{name}";
      disable-history = true;
      sort = true;
      # To show fewer things, we only match by name
      drun-match-fields = "name";
    };
  };

  # Rofi minimal theme in xdg config
  xdg.configFile."rofi/minimal.rasi".text = ''
    * {
      background-color: #000000;
      text-color: #ffffff;
      border-color: #888888;
      font: "JetBrainsMono Nerd Font 13";
    }
    
    window {
      width: 400px;
      border: 2px;
      padding: 15px;
    }
    
    mainbox {
      children: [inputbar, listview];
    }
    
    inputbar {
      children: [prompt, entry];
      padding: 0 0 10px 0;
    }
    
    prompt {
      text-color: #ffffff;
    }
    
    entry {
      text-color: #ffffff;
    }
    
    listview {
      lines: 5;
      scrollbar: false;
      border: 0;
      require-input: true;
    }
    
    element {
      padding: 5px;
    }
    
    element selected {
      background-color: #333333;
      text-color: #ffffff;
    }
  '';
}
