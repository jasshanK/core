When building on a system for the first time:

```
sudo nixos-rebuild boot --install-bootloader --impure --flake ~/core#{machine_type_goes_here}
```

Day to day updates can be done through the update.sh script.
