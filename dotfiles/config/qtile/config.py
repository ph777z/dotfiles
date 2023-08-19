import subprocess
from pathlib import Path

from libqtile import hook

from base import *
from screens import groups, screens
from keys import keys, mouse
from layouts import layouts, floating_layout


screens = screens
groups = groups
keys = keys
layouts = layouts
floating_layout = floating_layout
mouse = mouse

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = "floating_only"
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = 'LG3D'

@hook.subscribe.startup_once
def autostart():
    sh = Path(SCRIPTS_PATH, 'autostart.sh')
    subprocess.call([sh])