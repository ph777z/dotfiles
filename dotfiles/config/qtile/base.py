from pathlib import Path

from libqtile.utils import guess_terminal


theme = {
    'black1': '#11111b',
    'black2': '#585b70',
    'red1': '#f38ba8',
    'red2': '#eba0ac',
    'green1': '#a6e3a1',
    'green2': '#94e2d5',
    'yellow1': '#f9e2af',
    'yellow2': '#fab387',
    'blue1': '#89b4fa',
    'blue2': '#74c7ec',
    'white1': '#cdd6f4',
    'white2': '#a6adc8',
}

widget_defaults = dict(
    font='JetBrains Mono',
    background=theme['black1'] ,
    foreground=theme['white1'],
    fontsize=13,
    padding=5,
)

extension_defaults = widget_defaults.copy()

HOME = Path.home()
QTILE_CONFIG = Path(HOME, Path('.config', 'qtile'))
SCRIPTS_PATH = Path(QTILE_CONFIG, 'scripts')

terminal = guess_terminal('alacritty')