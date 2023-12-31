# `.NIX` > `*NIX`

![ayu-dark-dwm](https://github.com/orhnk/dotnix/assets/101834410/889701e1-c979-40dd-a536-6f41fc88e492)
![gruvbox-dwm-|M|](https://github.com/orhnk/dotnix/assets/101834410/1df53386-aad4-40b0-8f62-f866573ed8c3)
![gruvbox-light-dwm](https://github.com/orhnk/dotnix/assets/101834410/dec5344d-da32-4fff-b46c-096133a032e3)
![solarized-dark-dwm](https://github.com/orhnk/dotnix/assets/101834410/6b1b325b-3325-4c95-86a2-bdd01cd4be7a)


## Bootstrapping

Here is the script you need to run to get this working:

> [!IMPORTANT]
> You will need to have an SSH key to authorize GitHub with,
> and have access to the Ghostty GitHub repository as I
> use Ghostty and Ghostty is in private beta at the moment.

```sh
sudo nix-shell --packages git nu nix-output-monitor --command "
  git clone https://github.com/RGBCube/NixOSConfiguration ~/Configuration
  cd ~/Configuration
  nu rebuild.nu <host>
"
```

`host` is a host selected from the hosts in the `hosts` directory.

## Applying Changes

Lets say you have changed the configuration and want to apply the changes
to your system. You would have to run the rebuild script:

```sh
./rebuild.nu
```

This runs the script interactively.

You can also check how the script is used:

```sh
./rebuild.nu --help
```

This outputs:

```
Usage:
  > rebuild.nu (host) ...(arguments)

Flags:
  -h, --help - Display the help message for this command

Parameters:
  host <string>: The host to build. (optional, default: '')
  ...arguments <any>: The arguments to pass to `nix system apply`.
```

## NOTES

### Notable links:

- video sharing on wayland: https://gist.github.com/sioodmy/1932583dd8a804e0b3fe86416b923a16

### Notable Mentions:

- Minimal rice: https://codeberg.org/rs221122/dotfiles/

## BUGS

- dwm hangs after a boot because of some bug. There are two ways that I've came up with to solve this problem:
  1. Enable kmscon
  2. Disable Auto-booting (into the "nixos" user)

## License

```
MIT License

Copyright (c) 2023-present orhnk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```
