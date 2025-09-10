
{
  lib,
  python311,
  python311Packages, 
  fetchFromGitHub,
  makeWrapper
}:

python311Packages.buildPythonApplication rec {
  pname = "voice2sub";
  version = "91677d20b1f907b3bdd293bcba677941d9bcdaa3"; # 随便填个版本

  src = fetchFromGitHub {
    owner = "light12222";
    repo = "Voice2Sub-Whisper-Live-Translator";
    rev = "main";  # 可以换成 commit hash
    sha256 = "sha256-GKRK90lcyh5D9Bm1xZYIjwKqvBQnWZFNser7f8iUYX8="; # nix build 后会提示真实 hash
  };

  propagatedBuildInputs = with python311Packages; [
    pyqt5
    pyaudio
    numpy
    faster-whisper
    pysilero-vad
    loguru
    googletrans
    argostranslate
    librosa
    resampy
  ];
  nativeBuildInputs = [ python311Packages.pip ];
  # 允许 pip 拉 torch/faster-whisper
  format = "other";
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    mkdir -p $out/${python311.sitePackages}/voice2sub
    cp -r * $out/${python311.sitePackages}/voice2sub/

    mkdir -p $out/bin
    makeWrapper ${python311.interpreter} $out/bin/voice2sub \
      --add-flags "$out/${python311.sitePackages}/voice2sub/main.py"
    runHook postInstall
  '';
  meta = with lib; {
    description = "Real-time subtitle translator using WhisperX + PyQt5";
    homepage = "https://github.com/light12222/Voice2Sub-Whisper-Live-Translator";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
