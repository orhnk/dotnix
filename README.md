# `.NIX` > `*NIX`

![2024-08-21_15-29](https://github.com/user-attachments/assets/eb825294-f358-4b28-866e-b4b05a75d476)

## Bootstrapping

Here is the script you need to run to get this working:

> [!IMPORTANT] You will need to have an SSH key to authorize GitHub with, and
> have access to the Ghostty GitHub repository as I use Ghostty and Ghostty is
> in private beta at the moment.

```sh
sudo nix-shell --packages git nu nix-output-monitor --command "
  git clone https://github.com/orhnk/dotnix ~/nix
  cd ~/nix
  nu rebuild.nu <host>
"
```

`host` is a host selected from the hosts in the `hosts` directory.

## Applying Changes

Lets say you have changed the configuration and want to apply the changes to
your system. You would have to run the rebuild script:

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

> [!NOTE]
>
> Check out [CONFIGURATION_STEPS.md](./CONFIGURATION_STEPS.md) for
> non-declarative steps.

## TIPS

### Productivity

Feeling unproductive and ricing your NixOS all day? I was one. Then I've found
out that using a somewhat ugly was helping me. So you can use the "Productive"
theme under the flake instead of the one that's aesthetic.

#### Monochrome

Monochrome display is probably one of the most productive thing ever. Use your
GPU's official settings (nvidia-settings for my setup). Or you can adjust your
colors using third party apps like xcalib, xgamma, redshift etc. (if you can't
achieve monochrome, use green-only or similar settings using your monitor's
local hardware settings)

## NOTES

### My System Is Running Out Of Space ...

```sh
nix-collect-garbage --delete-older-than 3d # delete older than 3 days
nix-store --gc
nix-store --gc --print-roots | grep ~ # If this has so many outputs, you need to delete older profiles manually and recollect garbage. (really helpful if your system is old)
nix-store --verify --repair
nix store optimise
```

you could also use `nix-tree` to judge which package is needed or not.

I also suggest using the package `dua`. call `dua interactive` on `/` and
navigate through your volumed directories.

### Errors

If there are any collision errors on your setup. You probably have both
home-manager and nix's default packages enabled. So choose one and disable the
other.

### Accidentally Deleted Files bla bla.

Always backup your data. You should probably use `git` here. Anyways as I did
such a dumb thing and moved a week older version of my dotfiles, thanks to
@mr_headroom on discord, I was able to recover my latest rebuild. Note that you
should made the `rebuild-switch` action to retrieve the latest rebuild. If not,
I'm not sure that you can recover your config. Here is how I did it:

#### Nix Store

Everything that has to do with your configuration is store in the nix store. So
your configuration is copied up there when a change is made and rebuilt on your
configuration. First, I searched the dir for config generations using
`fd /nix/store/*-source/`. This will puke every generation copied to nix store.

> [!NOTE]
>
> Output of `df /nix/store/*-source/` will be huge. It includes every generation
> you built. No human can judge that much of output. So you should do a prior
> filtering like below.

#### Judging which one is the latest rebuild

Nix (AFAIK) doesn't have a way to tell which generation is the latest. So you
should judge it by the filetree present in the generation. I have a file that I
have lately added to my configuration: `modules/udisks.nix` so I searched for
configurations that have that file. This lead to only several files:

```sh
/nix/store🔒 via  v20.14.0 via 🐪 via 🐍 v3.11.9 took 25s
❯ fd /nix/store/*-source/modules/udisks.nix

z11kvpvb8hjsirf5lqqx6ffvy550gmqr-source/modules/udisks.nix
hwc7jgdxan7flmmj8630shnrzk8wj8z3-source/modules/udisks.nix
13115w69zgsisyw48wsl7akgcn9cj5w8-source/modules/udisks.nix
3yhzkyi53i2ccw4s1pnz51jb9qhn9f8l-source/modules/udisks.nix
kvs57cz4an5axdlga70imn6pccwyg8ic-source/modules/udisks.nix
4n7lp0c381jc0zzfa3clir6xxgdb8gz7-source/modules/udisks.nix
niijr29c5k3hz9wyci0ns9qa8myijw5g-source/modules/udisks.nix
5kqq1l8xpqj78m5fpv75z7db2ab1dyj6-source/modules/udisks.nix
qmxqmf66rad7yvvbg0x1c0x3x6kjryrl-source/modules/udisks.nix
7sih3q0gk76rlr47d0rmfqwdyd6bar2v-source/modules/udisks.nix
szgi1p7004jc9k19r0b46svfwc2y3s6h-source/modules/udisks.nix
83k51q1va337qnmgjxaxm0q5g7a68kis-source/modules/udisks.nix
wmqds0q27wvi2v8wmm8aa691ff857aqp-source/modules/udisks.nix
96s6xwql50yb4h1892zbsz3sd0sgzj2v-source/modules/udisks.nix
xgnqx485h9q46i67qy3ikr7nhfyzcnpj-source/modules/udisks.nix
b1fv61fa4ynjvk3010jyx8sdlc5imfhg-source/modules/udisks.nix
y1467zrq8qbg0bha7s3yk9x3pvdvj1s3-source/modules/udisks.nix
dialam25acqv9azsk2hhpdmm16mq26fc-source/modules/udisks.nix
y3bzb5lhr236bifa9dijw9gb2mji81cq-source/modules/udisks.nix
dws8vg41zc1p1mb4jhm2pbpg4ica1yf6-source/modules/udisks.nix
yiyqfzbj81qdpp8916far3lb9ydnwhws-source/modules/udisks.nix
ggsn40jmm69dm5j6zvw6sjh8r0304jv9-source/modules/udisks.nix
ylrs76bcdvc34r8w80l4kyv67csv6rgk-source/modules/udisks.nix
gmpnb3gdc3mrzrz390aypzgb7j7cx5bv-source/modules/udisks.nix
yq969r114aimc3jf755z84wadwp7jzwm-source/modules/udisks.nix
```

#### Judge by File Content

last of my edits didn't have a new file so I needed to check the content of the
files. I used the following script which also shows how the generations got
shrinked by the time:

```sh
#
# generations="
# /nix/store/z11kvpvb8hjsirf5lqqx6ffvy550gmqr-source/ \
# /nix/store/hwc7jgdxan7flmmj8630shnrzk8wj8z3-source/ \
# /nix/store/13115w69zgsisyw48wsl7akgcn9cj5w8-source/ \
# /nix/store/3yhzkyi53i2ccw4s1pnz51jb9qhn9f8l-source/ \
# /nix/store/kvs57cz4an5axdlga70imn6pccwyg8ic-source/ \
# /nix/store/4n7lp0c381jc0zzfa3clir6xxgdb8gz7-source/ \
# /nix/store/niijr29c5k3hz9wyci0ns9qa8myijw5g-source/ \
# /nix/store/5kqq1l8xpqj78m5fpv75z7db2ab1dyj6-source/ \
# /nix/store/qmxqmf66rad7yvvbg0x1c0x3x6kjryrl-source/ \
# /nix/store/7sih3q0gk76rlr47d0rmfqwdyd6bar2v-source/ \
# /nix/store/szgi1p7004jc9k19r0b46svfwc2y3s6h-source/ \
# /nix/store/83k51q1va337qnmgjxaxm0q5g7a68kis-source/ \
# /nix/store/wmqds0q27wvi2v8wmm8aa691ff857aqp-source/ \
# /nix/store/96s6xwql50yb4h1892zbsz3sd0sgzj2v-source/ \
# /nix/store/xgnqx485h9q46i67qy3ikr7nhfyzcnpj-source/ \
# /nix/store/b1fv61fa4ynjvk3010jyx8sdlc5imfhg-source/ \
# /nix/store/y1467zrq8qbg0bha7s3yk9x3pvdvj1s3-source/ \
# /nix/store/dialam25acqv9azsk2hhpdmm16mq26fc-source/ \
# /nix/store/y3bzb5lhr236bifa9dijw9gb2mji81cq-source/ \
# /nix/store/dws8vg41zc1p1mb4jhm2pbpg4ica1yf6-source/ \
# /nix/store/yiyqfzbj81qdpp8916far3lb9ydnwhws-source/ \
# /nix/store/ggsn40jmm69dm5j6zvw6sjh8r0304jv9-source/ \
# /nix/store/ylrs76bcdvc34r8w80l4kyv67csv6rgk-source/ \
# /nix/store/gmpnb3gdc3mrzrz390aypzgb7j7cx5bv-source/ \
# /nix/store/yq969r114aimc3jf755z84wadwp7jzwm-source/ \
# "
#
# file="rebuild.sh"
#
# generations2="
# /nix/store/yq969r114aimc3jf755z84wadwp7jzwm-source/
# /nix/store/ggsn40jmm69dm5j6zvw6sjh8r0304jv9-source/
# /nix/store/dws8vg41zc1p1mb4jhm2pbpg4ica1yf6-source/
# /nix/store/dialam25acqv9azsk2hhpdmm16mq26fc-source/
# /nix/store/y1467zrq8qbg0bha7s3yk9x3pvdvj1s3-source/
# /nix/store/xgnqx485h9q46i67qy3ikr7nhfyzcnpj-source/
# /nix/store/szgi1p7004jc9k19r0b46svfwc2y3s6h-source/
# /nix/store/3yhzkyi53i2ccw4s1pnz51jb9qhn9f8l-source/
# "
#
# for generation in $generations2; do
#   echo $generation
#   # cat "$generation$file"
#   tree -L 2 $generation
#   echo -e "\n\n\n"
# done
#

#!/bin/bash

# File to be compared
file="hosts/enka/default.nix"

# List of directories
generations2=(
  "/nix/store/yq969r114aimc3jf755z84wadwp7jzwm-source/"
  "/nix/store/dws8vg41zc1p1mb4jhm2pbpg4ica1yf6-source/" # CHECK
)

# Number of directories
num_dirs=${#generations2[@]}

# Compare files across all directories
for (( i=0; i<num_dirs; i++ )); do
  for (( j=i+1; j<num_dirs; j++ )); do
    file1="${generations2[i]}$file"
    file2="${generations2[j]}$file"

    # Check if both files exist before comparing
    if [[ -f "$file1" && -f "$file2" ]]; then
      echo "Comparing $file1 with $file2"
      colordiff -u "$file1" "$file2"
      echo
    else
      echo "One or both of the files do not exist: $file1 or $file2"
      echo
    fi
  done
done
```

### Notable Mentions:

- Minimal rice: https://codeberg.org/rs221122/dotfiles/
- Good Balance Gruvbox:
  https://github.com/0bCdian/Hyprland_dotfiles/tree/Cozy_Gruvbox?tab=readme-ov-file

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
