from pathlib import Path

from libqtile.config import Key, KeyChord, Click, Drag
from libqtile.lazy import lazy

from base import terminal, rofi_menu, rofi_window, SCRIPTS_PATH
from screens import screens_obj


alt_key = 'mod1'

keys = [
    Key([alt_key], 'h', lazy.layout.left()),
    Key([alt_key], 'l', lazy.layout.right()),
    Key([alt_key], 'j', lazy.layout.down()),
    Key([alt_key], 'k', lazy.layout.up()),
    Key([alt_key, 'shift'], 'h', lazy.layout.shuffle_left()),
    Key([alt_key, 'shift'], 'l', lazy.layout.shuffle_right()),
    Key([alt_key, 'shift'], 'j', lazy.layout.shuffle_down()),
    Key([alt_key, 'shift'], 'k', lazy.layout.shuffle_up()),
    Key([alt_key, 'shift'], 'n', lazy.layout.toggle_split()),
    Key([alt_key, 'control'], 'h', lazy.layout.grow_left()),
    Key([alt_key, 'control'], 'l', lazy.layout.grow_right()),
    Key([alt_key, 'control'], 'j', lazy.layout.grow_down()),
    Key([alt_key, 'control'], 'k', lazy.layout.grow_up()),
    Key([alt_key, 'control'], 'n', lazy.layout.normalize()),

    *[Key([alt_key], g.name, lazy.group[g.name].toscreen()) for g in screens_obj.groups],
    *[Key([alt_key, 'shift'], g.name, lazy.window.togroup(g.name, switch_group=True)) for g in screens_obj.groups],

    Key([alt_key, 'shift'], 'p', screens_obj.next()),
    Key([alt_key, 'shift'], 'o', screens_obj.prev()),

    Key([alt_key, 'shift'], 'r', lazy.reload_config()),
    Key([alt_key, 'shift'], 'Backspace', lazy.spawn(f'sh {Path(SCRIPTS_PATH, "powermenu.sh")}')),
    #Key([window_key, 'control'], 'Tab', lazy.next_layout()),
    Key([alt_key], 'Backspace', lazy.window.kill()),
    # Key([window_key], 'x', lazy.spawn('kitty bash -c "xprop;read"')),
    Key([alt_key, 'control'], 'g', lazy.window.toggle_floating()),

    Key([], 'XF86AudioLowerVolume', lazy.spawn('pamixer --decrease 5')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pamixer --increase 5')),
    Key([], 'XF86AudioMute', lazy.spawn('pamixer --toggle-mute')),
    
    Key([alt_key], 'Space', lazy.spawn(rofi_menu)),
    Key([alt_key, 'shift'], 'Return', lazy.spawn(terminal)),
    Key([alt_key], 'Tab', lazy.spawn(rofi_window))
]

# Drag floating layouts.
mouse = [
    Drag(
        [window_key],
        'Button1',
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [window_key],
        'Button3',
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([window_key], 'Button1', lazy.window.bring_to_front()),
]