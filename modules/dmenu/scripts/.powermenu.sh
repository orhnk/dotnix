let action =  "shutdown\nreboot\nsleep\nlogout" | dmenu -l 4 

if $action == "shutdown" {
  sudo shutdown -h now
}
if $action == "sleep" {
  systemctl hibrenate
}
if $action == "logout" {
  pkill dwm
}
if $action == "reboot" {
  reboot
}
