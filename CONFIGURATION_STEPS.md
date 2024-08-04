# Manual

## Yewtube

yt command is used to "listen" youtube videos. It uses mpv by default. So enter
`yt` on terminal then `h config` there you'll see you should
`set playerargs --no-video`. If not, you'll see a video playing when you open a
link. Also:

```
set notifier notify-send
set playerargs --no-video
set show_video 0
encoders # then select 1 or 2
```

## Wallpapers

The repository already includes a wallpaper.jpg file. But I have a
[theme-based wallpaper collection](https://github.com/orhnk/Wallpapers). Clone
it to `~/Wallpapers/` or refactor flake.nix:~124 (wallpaperPath)
