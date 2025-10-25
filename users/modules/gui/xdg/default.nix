{ pkgs, ... }: {
  # TODO!
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # --- Web ---
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      # --- Text ---
      "text/plain" = "nvim.desktop";
      "text/plain;charset=utf-8" = "nvim.desktop";

      # --- PDF ---
      "application/pdf" = "zathura.desktop";
      "application/epub" = "zathura.desktop";

      # --- Word,PPT,Excel ---
      # Word (.doc, .docx)
      "application/msword" = "libreoffice-writer.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "libreoffice-writer.desktop";

      # Excel (.xls, .xlsx)
      "application/vnd.ms-excel" = "libreoffice-calc.desktop";
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "libreoffice-calc.desktop";

      # PowerPoint (.ppt, .pptx)
      "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "libreoffice-impress.desktop";     

      # --- Picture ---
      "image/jpeg" = "imv.desktop"; # JPG, JPEG
      "image/png"  = "imv.desktop"; # PNG
      "image/gif"  = "imv.desktop"; # GIF
      "image/bmp"  = "imv.desktop"; # BMP
      "image/tiff" = "imv.desktop"; # TIFF
      "image/webp" = "imv.desktop"; # WebP

      # --- Video ---
      "video/mp4"  = "mpv.desktop";
      "video/mpv"  = "mpv.desktop";
      "video/mkv"  = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/avi"  = "mpv.desktop";
      
      # --- Audio ---
      "audio/mpeg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/wav"  = "mpv.desktop";
      "audio/mp3"  = "mpv.desktop";
    };
  };

}
