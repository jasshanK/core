{
  pkgs
}:
let
  pname = "jan";
  version = "0.5.18-rc6-beta";
  src = pkgs.fetchurl {
    url = "file::///home/jasshank/defaults/Downloads/Jan-beta_0.5.18-rc6-beta_amd64.AppImage";
    hash = "sha256-/Ot6xFqZgIQ9Zt5ai8Kk3tz8aj39y7cfdpvyIt/Gn1Q=";
  };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  meta = {
    changelog = "https://github.com/janhq/jan/releases/tag/v${version}";
    description = "Jan is an open source alternative to ChatGPT that runs 100% offline on your computer";
    homepage = "https://github.com/janhq/jan";
    license = pkgs.lib.licenses.agpl3Plus;
    mainProgram = "jan";
    maintainers = [ ];
    platforms = with pkgs.lib.systems.inspect; patternLogicalAnd patterns.isLinux patterns.isx86_64;
  };
}
