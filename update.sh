git add .

echo "[1] Laptop"
echo "[2] Desktop"
echo "Select: "
read option 

machine="nil"
case $option in
    "1" )
        machine="laptop"
        echo "Laptop selected" ;;
    "2" )
        machine="desktop"
        echo "Desktop selected" ;;
    * )
        echo "Not a valid option!"
        exit 1
esac

sudo nixos-rebuild switch --impure --flake  ~/core#$machine
