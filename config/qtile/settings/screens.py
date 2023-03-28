from libqtile.config import Screen

from .bar import BAR, widget_defaults, extension_defaults


screens = [
    Screen(
        top=BAR,
    ),
]
