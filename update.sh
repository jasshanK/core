git add .

echo "[1] Laptop"
echo "[2] Desktop"
echo "[3] Cube"
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
    "3" )
        machine="cube"
        echo "Cube selected" ;;
    * )
        echo "Not a valid option!"
        exit 1
esac

sudo nixos-rebuild switch --impure --flake  ~/core#$machine
