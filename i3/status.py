# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

green="#98c379"
red="#e06c75"
yellow="#d19a66"

status = Status(standalone=True, click_events=False)

status.register("clock", format = ("%H:%M ⌛", "Europe/Paris"))

status.register("cpu_usage_bar",
        format="CPU {usage:2}% {usage_bar_cpu0}{usage_bar_cpu1}{usage_bar_cpu2}{usage_bar_cpu3}{usage_bar_cpu4}{usage_bar_cpu5}",
        bar_type="vertical",
        start_color=green,
        end_color=red
)

status.register("temp",
        format="{temp}°C 🔥",
        file="/sys/class/thermal/thermal_zone2/temp"
)

status.register("network",
        interface="eno1",
        graph_style="blocks",
        graph_width=10,
        start_color=green,
        end_color=green
)

status.register("disk", format="{avail} GB 💾",path="/")

status.register("now_playing",
        status={"pause": "⏸️", "play": "▶️", "stop": "⏹️"},
        format="{status} {artist} - {title}"
)

status.run()
