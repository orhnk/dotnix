# schedule task
export def schedule [duration, message?] {
  mut nudge = "Time is up!"
  if $message != null {
    $nudge = $message
  }

  timer $duration
  notify-send $nudge
}

# find git dirs
export def fgit [] {
  rg --files --hidden | rg -e "\\.(ignore|git)"
}

# prayer time
export def pray [] {
  let req =  http get https://www.namazvakti.com/DailyRSS.php?cityID=16741

  # Get date
  let date = $req
    | get content
    | get 0
    | get content
    | get 9
    | get content
    | get 0 
    | get content 
    | get content 
    | get 0

  # Get time
  let time = $req
    | get content
    | get 0
    | get content
    | get 9
    | get content
    | get 1 
    | get content 
    | get content 
    | get 0 
    | lines
    | str replace "<br>" "" 
    | str replace "\t\t\t" ""
    | str replace "<p>" ""


  let current_time = date now | format date "%H:%M"

  echo $date | append $time | append $current_time
}

export def wttr [] {
  http get https://wttr.in/istanbul
}
