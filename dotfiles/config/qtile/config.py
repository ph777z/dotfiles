import subprocess
import threading
from os import getenv
from pathlib import Path

from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile.utils import guess_terminal
from libqtile import hook, bar, widget, qtile
from libqtile.layout import floating, bsp, max
from libqtile.config import Screen, Key, KeyChord, Group, Match, Click, Drag

from widgets import Backlight
from devides import get_backlight, get_wlan, get_num_monitors


HOME = Path.home()
QTILE_CONFIG = Path(HOME, Path('.config', 'qtile'))
SCRIPTS_PATH = Path(QTILE_CONFIG, 'scripts')

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

mod = 'mod4'
terminal = guess_terminal('kitty')
rofi_menu = 'rofi -show drun'
rofi_window = 'rofi -show window'

widget_defaults = dict(
    font='FiraCode Nerd Font Medium',
    background=theme['black1'],
    foreground=theme['white1'],
    fontsize=13,
    padding=5,
)

extension_defaults = widget_defaults.copy()

wlan_dev_name = get_wlan()
hci0_dev = getenv('QTILE_BLUEZ_DEV', None)
backlight_file = get_backlight()

BAR = bar.Bar(
    [
        widget.GroupBox(
            active=theme['white1'],
            inactive=theme['white2'],

            highlight_method='block',
            block_highlight_text_color=theme['black1'],

            this_current_screen_border=theme['white1'],
            this_screen_border=theme['black2'],

            other_current_screen_border=theme['white1'],
            other_screen_border=theme['black2'],

            urgent_alert_method='text',
            urgent_text=theme['red1'],
            urgent_border=theme['red1'],

            margin_x=0,
            rounded=True,
            disable_drag=True,
            borderwidth=2
        ),
        widget.Sep(
            foreground=theme['black1'],
            padding=0
        ),
        widget.WindowName(
            background=theme['white1'],
            foreground=theme['black1'],
            format='{name}',
            width=200,
        ),
        widget.Spacer(
            background=theme['white1']
        ),
        widget.Systray(
            icon_size=16,
            padding=8,
        ),
        widget.Sep(
            foreground=theme['black1'],
            padding=8
        ),
        widget.KeyboardLayout(
            fmt='󰌌 {}',
            configured_keyboards=['us_intl', 'br'],
        ),
        widget.CheckUpdates(
            fmt=' {}',
            distro='Arch_checkupdates',
            display_format='{updates}',
            no_update_string='0',
            colour_have_updates=theme['white1'],
            colour_no_updates=theme['white1'],
            update_interval=60,
            mouse_callbacks={
                'Button1': lazy.spawn(
                    f'{terminal} {Path(SCRIPTS_PATH, "update_pkgs.sh")}'
                )
            }
        ),
        Backlight(
            fmt='󰃟 {}',
            backlight_name=backlight_file,
            scroll=False,
        )
        if backlight_file
        else widget.Sep(
            foreground=theme['black1'],
            padding=0
        ),
        widget.Volume(
            fmt=' {}',
            scroll=True,
            update_interval=0.1,
            get_volume_command=Path(SCRIPTS_PATH, 'get_volume.sh'),
            volume_up_command='pamixer --increase 1',
            volume_down_command='pamixer --decrease 1',
            mouse_callbacks={
                'Button1': lazy.spawn('pamixer --toggle-mute'),
                'Button3': lazy.spawn('pavucontrol')
            }
        ),
        widget.Sep(
            foreground=theme['black1'],
            padding=8
        ),
        widget.Bluetooth(
            fmt=' {}',
            hci=hci0_dev,
            mouse_callbacks={
                'Button1': lazy.spawn('rofi-bluetooth')
            }
        )
        if hci0_dev
        else widget.Sep(
            foreground=theme['black1'],
            padding=0
        ),
        widget.Wlan(
            interface=wlan_dev_name,
            format='󰖩 {essid}',
            disconnected_message='󰖪 off',
            mouse_callbacks={
                'Button1': lazy.spawn(
                    f'{Path(SCRIPTS_PATH, "wifi-menu.sh")}'
                )
            }
        )
        if wlan_dev_name
        else widget.Sep(
            foreground=theme['black1'],
            padding=0
        ),
        widget.Sep(
            foreground=theme['black1'],
            padding=8
        )
        if wlan_dev_name or hci0_dev
        else widget.Sep(
            foreground=theme['black1'],
            padding=0
        ),
        widget.Clock(
            format='󰸗 %d/%m/%Y  %H:%M',
            mouse_callbacks={
                'Button1': lazy.spawn(f'{terminal} sh -c "cal; read"')
            }
        ),
        widget.Sep(
            foreground=theme['black1'],
            padding=8
        ),
        widget.TextBox(
            '',
            background=theme['white1'],
            foreground=theme['black1'],
            padding=5,
            mouse_callbacks={
                'Button1': lazy.spawn(
                    f'sh {Path(SCRIPTS_PATH, "powermenu.sh")}'
                )
            }
        ),
        widget.Sep(
            foreground=theme['white1'],
            background=theme['white1'],
            padding=2
        ),
    ],
    20,
)

screens = [Screen(top=BAR)]
for _ in range(get_num_monitors() - 1):
    screens.append(Screen(
        top=bar.Bar([
            widget.Sep(
                foreground=theme['white1'],
                background=theme['white1'],
                padding=2
            ),
            widget.AGroupBox(
                background=theme['white1'],
                foreground=theme['black1'],
                padding=2,
                borderwidth=0
            )],
            20
        ),
    )) 

groups = [Group(i) for i in '12345678']

keys = [
    KeyChord([mod], 'o', [
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
        Key(['shift'], 'Return', lazy.layout.toggle_split()),
        *[Key([], g.name, lazy.window.togroup(g.name, switch_group=True))for g in groups]],
        mode=True,
        name='window'
    ),

    *[Key([mod], g.name, lazy.group[g.name].toscreen()) for g in groups],
    *[Key([mod, 'shift'], str(n_screen + 1), lazy.to_screen(n_screen)) for n_screen, _ in enumerate(screens)],

    Key([mod], 'r', lazy.reload_config()),
    Key([mod], 'q', lazy.spawn(f'sh {Path(SCRIPTS_PATH, "powermenu.sh")}')),
    #Key([mod, 'control'], 'Tab', lazy.next_layout()),
    Key([mod], 'w', lazy.window.kill()),
    Key([mod], 'x', lazy.spawn('kitty bash -c "xprop;read"')),
    Key([mod], 'g', lazy.window.toggle_floating()),

    Key([], 'XF86AudioLowerVolume', lazy.spawn('pamixer --decrease 5')),
    Key([], 'XF86AudioRaiseVolume', lazy.spawn('pamixer --increase 5')),
    Key([], 'XF86AudioMute', lazy.spawn('pamixer --toggle-mute')),
    
    Key([mod], 'Return', lazy.spawn(terminal)),
    Key([mod], 'Space', lazy.spawn(rofi_menu)),
    Key([mod], 'Tab', lazy.spawn(rofi_window))
]

layouts = [
    bsp.Bsp(
        border_width=1,
        margin=6,
        border_on_single=True,
        border_focus=theme['white1'],
        border_normal=theme['black2'],
    ),
    max.Max()
]

floating_layout = floating.Floating(
    border_width=1,
    border_focus=theme['white1'],
    border_normal=theme['black2'],
    float_rules=[
        # defaults
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        # customs
        Match(title='Salvar como'),
        Match(title='Discord Updater'),
        Match(wm_class='Pavucontrol'),
        Match(wm_class='Anydesk'),
        Match(wm_class='megasync'),
    ],
)

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        'Button1',
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        'Button3',
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([mod], 'Button1', lazy.window.bring_to_front()),
]


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = 'LG3D'


def betterlockscreen_setup():
    sh = Path(SCRIPTS_PATH, 'lockscreen.sh')
    subprocess.call([sh])   

@hook.subscribe.startup_once
def autostart():
    sh = Path(SCRIPTS_PATH, 'autostart.sh')
    subprocess.call([sh])
    
    threading.Thread(target=betterlockscreen_setup).start()
