commands =
  battery: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d';'"
  charging: "pmset -g batt | grep -c 'AC'"
  wifi   : "/System/Library/PrivateFrameworks/Apple80211.framework/" +
            "Versions/Current/Resources/airport -I | " +
            "sed -e \"s/^ *SSID: //p\" -e d"
  date   : "date +\"%Y/%m/%d\""
  cpu    : "ESC=`printf \"\e\"`; ps -A -r -o %cpu | awk '{s+=$1} END {printf(\"%5.2f\",s/8);}'"
  disk   : "df -H -l / | awk '/\\/.*/ { print $5 }'"
  volume : "osascript -e 'output volume of (get volume settings)'"

colors =
  black   : "#3B4252"
  gray    : "#5C5C5C"
  red     : "#BF616A"
  green   : "#A3BE8C"
  yellow  : "#EBCB8B"
  blue    : "#81A1C1"
  magenta : "#B48EAD"
  cyan    : "#88C0D0"
  white   : "#D8DEE9"

command: "echo " +
          "$(#{commands.battery}):::" +
          "$(#{commands.charging}):::" +
          "$(#{commands.wifi}):::" +
          "$(#{commands.date}):::" +
          "$(#{commands.cpu}):::" +
          "$(#{commands.disk}):::" + 
          "$(#{commands.volume}):::"

refreshFrequency: 60000

render: () ->
  """
  <link rel="stylesheet" href="./polybar/assets/font-awesome/css/all.css" />
  <div class="elements">
    <div class="volume">
      <span>
        <span class="volume-icon"></span>
        <span class="volume-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="cpu">
      <span>
        <i class="fa fa-chart-area"></i>
        <span class="cpu-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="disk">
      <span>
        <i class="fa fa-hdd"></i>
        <span class="disk-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="wifi">
      <span>
        <i class="fa fa-wifi"></i>
        <span class="wifi-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="battery">
      <span>
        <span class="battery-icon"></span>
        <span class="battery-output"></span>
      </span>
    </div>
    <div><span class="spacer">|</span></div>
    <div class="date">
      <span>
        <i class="fa fa-calendar"></i>
        <span class="date-output"></span>
      </span>
    </div>
  </div>
  """

update: (output) ->

  console.log(output)
  output = output.split( /:::/g )

  battery  = output[0]
  charging = output[1]
  wifi     = output[2]
  date     = output[3]
  cpu      = output[4]
  disk     = output[5]
  volume   = output[6]

  $(".battery-output") .text("#{battery}")
  $(".wifi-output")    .text("#{wifi}")
  $(".date-output")    .text("#{date}")
  $(".cpu-output")     .text("#{cpu}%")
  $(".disk-output")    .text("#{disk}")
  $(".volume-output")  .text("#{volume}%")

  @handleBattery(Number(battery.replace(/%/g, "")), charging == '1')
  @handleVolume(Number(volume))

handleBattery: ( percentage, charging ) ->
  if charging
    $(".battery-icon").html("<i class=\"fas fa-bolt \"></i>")
    return

  batteryIcon = switch
    when percentage <=  12 then "fa-battery-empty"
    when percentage <=  25 then "fa-battery-quarter"
    when percentage <=  50 then "fa-battery-half"
    when percentage <=  75 then "fa-battery-three-quarters"
    when percentage <= 100 then "fa-battery-full"

  $(".battery-icon").html("<i class=\"fa #{batteryIcon} \"></i>")

handleVolume: (volume) ->
  volumeIcon = switch
    when volume ==   0 then "fa-volume-off"
    when volume <=  50 then "fa-volume-down"
    when volume <= 100 then "fa-volume-up"
  $(".volume-icon").html("<i class=\"fa #{volumeIcon}\"></i>")


style: """

  .elements
    display: flex
    align-items: stretch
    height: 24px
    margin: 0 4px

  .elements > div
    display: flex
    align-items: center
    padding: 2px 2px
    margin: 0px auto

  .spacer
    color: #{colors.white}

  .battery
    color: #{colors.white}
  .wifi
    color: #{colors.white}
  .date
    color: #{colors.white}
  .cpu
    color: #{colors.white}
  .disk
    color: #{colors.white}
  .volume
    color: #{colors.white}

  bottom: 0px
  right: 10px
  font-family: 'Jetbrains Mono'
  font-size: 13px
  font-smoothing: antialiasing
  z-index: 0
"""
