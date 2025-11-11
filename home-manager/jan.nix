{
pkgs
}:

let
    pname = "jan";
    version = "0.7.2";
    src = pkgs.fetchurl {
        url = "https://github.com/menloresearch/jan/releases/download/v${version}/Jan_${version}_amd64.AppImage";
        hash = "sha256-tz0it9NYT+HOjJ0xxsxfTh0Vw0p+Mfp1SZbT5M5DM+0=";
    };

    buildInputs = [
        pkgs.libGL
    ];
in
    pkgs.appimageTools.wrapType2 {
        inherit pname version src buildInputs;
        meta = {
            changelog = "https://github.com/janhq/jan/releases/tag/v${version}";
            description = "Jan is an open source alternative to ChatGPT that runs 100% offline on your computer";
            homepage = "https://github.com/menloresearch/jan";
            license = pkgs.lib.licenses.agpl3Plus;
            mainProgram = "jan";
            maintainers = [ ];
            platforms = with pkgs.lib.systems.inspect; patternLogicalAnd patterns.isLinux patterns.isx86_64;
        };
    }
