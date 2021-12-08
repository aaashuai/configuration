commands =
  active : "/usr/local/bin/yabai -m query --spaces --space | /usr/local/bin/jq '.index'"
  list   : "/usr/local/bin/yabai -m query --spaces | /usr/local/bin/jq -r '.[].index'"
  monitor: ""

colors =
  acqua:   "#00d787"
  wine:    "#72003e"
  orange:  "#ff8700"
  silver:  "#e4e4e4"
  elegant: "#1C2331"
  magenta: "#af005f"
  cyan:    "#00afd7"

command: "echo " +
          "$(#{commands.active}):::" +
          "$(#{commands.list}):::"

refreshFrequency: 380

render: () ->
  """
  <link rel="stylesheet" href="./polybar/assets/font-awesome/css/all.css" />
  <div class="spaces">
    <div>Default</div>
  </div>
  """

update: (output) ->
  output = output.split( /:::/g )

  active = output[0]
  list   = output[1]

  @handleSpaces(list)
  @handleActiveSpace(Number (active))

handleSpaces: (list) ->
  $(".spaces").empty()
  list = " " + list
  list = list.split(" ")
  emjMap = {"1": " ", "2": " ", "3": " ", "4": " ", "5": " ", "6": " ", "7": " ", "8": " ", "9": " ", "10": " "}


  $.each(list, (index, value) ->
    if (index > 0)
      $(".spaces").append(
         """<div class="workspace" id="#{index}">#{emjMap[index]}</div>"""
      )
      #$("<div>").prop("id", index).text("#{index}: #{value}").appendTo(".spaces")
  )

handleActiveSpace: (id) ->
  $("##{id}").addClass("active")

style: """
  .spaces
    display: flex
    align-items: stretch
    height: 24px

  .workspace
    display: flex
    color: #F5EEEE
    align-items: center
    justify-content: center
    padding: 10px 12px

  .active
    font-size: 16px
    background-color: #{colors.silver}
    color: #{colors.elegant}


  top: 0px
  left: 10px
  font-family: 'Font Awesome 5 Free'
  font-size: 14px
  font-smoothing: antialiasing
  z-index: 0
"""
