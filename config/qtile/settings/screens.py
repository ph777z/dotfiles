from libqtile.config import Screen, Key

from .bar import BAR, widget_defaults, extension_defaults
from .keymaps import mod, keys
from .devides import get_num_monitors


screens = [
    Screen(
        top=BAR,
    ),
    Screen()
]

num_monitors = get_num_monitors()

if num_monitors > 1:
    for _ in range(num_monitors - 1):
        screens.append(Screen())
