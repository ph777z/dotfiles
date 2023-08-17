from pathlib import Path

from libqtile.config import Key, KeyChord, Click, Drag
from libqtile.lazy import lazy

from base import terminal, rofi_menu, rofi_window, SCRIPTS_PATH
from screens import screens_obj


window_key = 'mod4'
alt_key = 'mod1'

keys = [
    KeyChord([window_key], 'o', [
        Key([], 'h', lazy.layout.left()),
        Key([], 'l', lazy.layout.right()),
        Key([], 'j', lazy.layout.down()),
        Key([], 'k', lazy.layout.up()),
        Key(['shift'], 'h', lazy.layout.shuffle_left()),
        Key(['shift'], 'l', lazy.layout.shuffle_right()),
        Key(['shift'], 'j', lazy.layout.shuffle_down()),
        Key(['shift'], 'k', lazy.layout.shuffle_up()),
        Key(['control'], 'h', lazy.layout.grow_left()),
        Key(['control'], 'l', lazy.layout.grow_right()),
        Key(['control'], 'j', lazy.layout.grow_down()),
        Key(['control'], 'k', lazy.layout.grow_up()),
        Key([], 'n', lazy.layout.normalize()),
        Key(['shift'], 'Return', lazy.layout.toggle_split())],
        mode=True,
        name='window'
    ),

    *[Key([alt_key], g.name, lazy.group[g.name].toscreen()) for g in screens_obj.groups],
    *[Key([window_key, 'shift'], g.name, lazy.window.togroup(g.name, switch_group=True)) for g in screens_obj.groups],

    Key([alt_key], 'r', lazy.reload_config()),
    Key([alt_key], 'q', lazy.spawn(f'sh {Path(SCRIPTS_PATH, "powermenu.sh")}')),
    #Key([window_key, 'control'], 'Tab', lazy.next_layout()),
    Key([window_key], 'w', lazy.window.kill()),
    Key([window_key], 'x', lazy.spawn('kitty bash -c "xprop;read"')),
    Key([window_key], 'g', lazy.window.toggle_floating()),

    Key([], 'XF86AudioLowerVolume', lazy.spawn('pamixer --decrease 5')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pamixer --increase 5')),
    Key([], 'XF86AudioMute', lazy.spawn('pamixer --toggle-mute')),
    
    KeyChord([alt_key], 'shift', [
        Key([], 'Space', lazy.spawn(rofi_menu)),
        Key([], 'Return', lazy.spawn(terminal))],
    ),
    Key([window_key], 'Tab', lazy.spawn(rofi_window))
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