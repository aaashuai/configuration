commands =
  time   : "date +\"%a %H:%M:%S\""

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
          "$(#{commands.time}):::"

refreshFrequency: 950

render: () ->
  """
  <link rel="stylesheet" href="./polybar/assets/font-awesome/css/all.css" />
  <div class="elements">
    <div class="time">
      <span>
        <i class="fa fa-clock"></i>
        <span class="time-output"></span>
      </span>
    </div>
  </div>
  """

update: (output) ->

  # console.log(output)
  output = output.split( /:::/g )

  time  = output[0]

  $(".time-output")    .text("#{time}")


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

  .time
    color: #{colors.white}

  bottom: 0px
  right: 48% 
  font-family: 'Jetbrains Mono'
  font-size: 13px
  font-smoothing: antialiasing
  z-index: 0
"""
