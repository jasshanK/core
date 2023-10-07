git add .
git commit -m "update"
git push
sudo nixos-rebuild switch --impure --flake  ~/core
