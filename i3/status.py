# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

green="#98c379"
red="#e06c75"
yellow="#d19a66"

status = Status(standalone=True, click_events=False)

status.register("clock", format = ('UTC %H:%M', 'UTC'))
status.register("clock", format = ("FR %H:%M", "Europe/Paris"))

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
    format="{avg1}")

status.register("mem",
    format="MEM {percent_used_mem}%",
    color="white",
    warn_percentage=80,
    alert_percentage=90)

status.register("cpu_usage_graph",
    format="CPU {usage:2}",
    start_color=green,
    end_color=green
)

status.register("cpu_usage_bar",
    format="{usage_bar_cpu0}{usage_bar_cpu1}{usage_bar_cpu2}{usage_bar_cpu3}{usage_bar_cpu4}{usage_bar_cpu5}",
    bar_type="vertical",
    start_color=green,
    end_color=red
)

# Shows mpd status
status.register("mpd",
    format="♬ {artist}: {album} {status} {title}",
    max_field_len=50,
    status={
        "pause": "◾",
        "play": "▶",
        "stop": "◾",
    })

# status.register("runwatch",
#     path="/tmp/lila-play-pid",
#     name="lila",
#     interval=2,
#     color_up=green,
#     color_down=red)

status.register("network",
    interface="wlan0",
    format_up="{bytes_sent} k↑ {bytes_recv} k↓ {essid} {quality}%",
    format_down="X",
    dynamic_color = True,
    start_color=green,
    end_color=yellow,
    color_down=red,
)

status.register("online",
    format_online="✓",
    format_offline="✗",
    color=green,
    color_offline=red)
status.register("network",
    interface="enp0s20f0u9",
    unknown_up = True,
    format_up="EXT {bytes_sent} kB/s↑ {bytes_recv} kB/s↓",
    format_down="X",
    dynamic_color = True,
    start_color=green,
    end_color=yellow,
    color_down=red,
)

status.run()
