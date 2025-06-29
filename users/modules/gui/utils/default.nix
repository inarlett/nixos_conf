{
  xdg = {
    desktopEntries = {
      feh = {
        name = "feh";
        genericName = "Image Viewer";
        comment = "Lightweight image viewer";
        exec = "feh %F";
        icon = "gimp"; # 可替换为路径或已有图标名
        terminal = false;
        type = "Application";
        categories = [
          "Graphics"
          "Viewer"
        ];
        mimeType = [
          "image/png"
          "image/jpeg"
          "image/bmp"
          "image/gif"
        ];
      };
    };
  };
}
