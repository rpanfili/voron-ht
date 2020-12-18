# Voron HT 
Klipper configuration for my Voron HighTower printer (350x350x420)


## Setup
I'm running [klipper firmware](https://github.com/KevinOConnor/klipper) on a RaspberryPi4 connected via usb to two SKR 1.4 turbo board.

### Klipper and Octoprint
The process is pretty straight-forward: run the klipper dependencies installer, compile the firmware and flash it on the board. Install an octoprint plugin. It's done :)

Please refer to the [offical documentation](https://www.klipper3d.org/Overview.html) for details.

### How to load klipper configuration
At the moment I checked out this repository in my home directory and added a static `printer.cfg` just to include these files.
```bash
git clone https://github.com/rpanfili/voron-ht.git ~/voron-ht
echo "[include ./voron-ht/printer.cfg]" > ~/printer.cfg
```

## Contributing

This project, even if personal, it's meant open so feel free to contribute! 
These are the [contribution guidelines](CONTRIBUTING.md).
