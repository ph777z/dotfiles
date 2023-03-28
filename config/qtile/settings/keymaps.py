from pathlib import Path

from libqtile.lazy import lazy
from libqtile.config import Key

from .apps import terminal
from .conts import SCRIPTS_PATH


mod = 'mod4'
rofi_menu = 'rofi -show drun'
rofi_window = 'rofi -show window'

keys = [
    # window focus
    Key([mod], 'h', lazy.layout.left(), desc='Move focus to left'),
    Key([mod], 'l', lazy.layout.right(), desc='Move focus to right'),
    Key([mod], 'j', lazy.layout.down(), desc='Move focus down'),
    Key([mod], 'k', lazy.layout.up(), desc='Move focus up'),

    Key([mod], 'g', lazy.window.toggle_floating(), desc='asda'),

    # move windows in layout
    Key([mod, 'shift'], 'h', lazy.layout.shuffle_left(), desc='Move window to the left'),
    Key([mod, 'shift'], 'l', lazy.layout.shuffle_right(), desc='Move window to the right'),
    Key([mod, 'shift'], 'j', lazy.layout.shuffle_down(), desc='Move window down'),
    Key([mod, 'shift'], 'k', lazy.layout.shuffle_up(), desc='Move window up'),

    # change window size
    Key([mod, 'control'], 'h', lazy.layout.grow_left(), desc='Grow window to the left'),
    Key([mod, 'control'], 'l', lazy.layout.grow_right(), desc='Grow window to the right'),
    Key([mod, 'control'], 'j', lazy.layout.grow_down(), desc='Grow window down'),
    Key([mod, 'control'], 'k', lazy.layout.grow_up(), desc='Grow window up'),
    Key([mod], 'n', lazy.layout.normalize(), desc='Reset all window sizes'),

    # toggles between vertical and horizontal split
    Key([mod, 'shift'], 'Return', lazy.layout.toggle_split(), desc='Toggle between split and unsplit sides of stack'),

    # qtile actions
    Key([mod, 'control'], 'r', lazy.reload_config(), desc='Reload the config'),
    Key([mod, 'control'], 'q', lazy.spawn(f'sh {Path(SCRIPTS_PATH, "powermenu.sh")}'), desc='Shutdown Qtile'),
    Key([mod, 'control'], 'Tab', lazy.next_layout(), desc='Goes to next layout'),
    Key([mod], 'w', lazy.window.kill(), desc='Kill focused window'),
    Key([mod], 'r', lazy.spawn('dmenu_run'), desc='Spawn a command using a prompt widget'),
    Key([mod], 'q', lazy.spawn('kitty bash -c "xprop;read"')),

    #Keys multimedia
    Key([], 'XF86AudioLowerVolume', lazy.spawn('pamixer --decrease 5')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pamixer --increase 5')),
    Key([], 'XF86AudioMute', lazy.spawn('pamixer --toggle-mute')),
    
    # launch apps
    Key([mod], 'Return', lazy.spawn(terminal), desc='Launch terminal'),
    # Key([mod], 'Space', lazy.spawn(rofi_menu), desc='launch menu'),
    Key([mod], 'Space', lazy.spawn(rofi_menu), desc='launch menu'),
    Key([mod], 'Tab', lazy.spawn(rofi_window), desc='Goes to next group'),

]
