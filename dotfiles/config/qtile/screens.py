from pathlib import Path

from libqtile.config import Group, Screen
from libqtile.lazy import lazy
from libqtile import bar, widget

from base import terminal, theme, SCRIPTS_PATH
from widgets import Backlight
from devides import get_num_monitors, get_wlan, get_backlight, get_keyboard_layouts


groups = [Group(i) for i in '12345678']

def relative_widgets():
    wlan_dev_name = get_wlan()
    backlight_file = get_backlight()
    widgets = []

    if backlight_file:
        widgets.append(
            Backlight(
                fmt='󰃟 {}',
                backlight_name=backlight_file,
                scroll=False,
            )
        )
    if wlan_dev_name:
        widgets.append(
            widget.Wlan(
                interface=wlan_dev_name,
                format='󰖩 {essid}',
                disconnected_message='󰖪 off',
                max_chars=10,
                mouse_callbacks={
                    'Button1': lazy.spawn(f'{terminal} -e nmtui')
                }
            )
        )
    return widgets

def create_groupbox():
    return widget.GroupBox(
        active=theme['white1'],
        inactive=theme['black2'],
        highlight_method='line',
        highlight_color=[theme['black1']],
        this_current_screen_border=theme['white2'],
        this_screen_border=theme['black2'],
        other_current_screen_border=theme['black1'],
        other_screen_border=theme['black1'],
        urgent_alert_method='text',
        urgent_text=theme['red1'],
        urgent_border=theme['red1'],
        margin_x=0,
        rounded=True,
        disable_drag=True,
        borderwidth=2
    )


screens = [Screen(top=bar.Bar([
    create_groupbox(),
    widget.Sep(foreground=theme['black1'], padding=0),
    widget.WindowName(format='{name}', width=200),
    widget.Spacer(),
    widget.Systray(icon_size=16, padding=8),
    widget.Sep(padding=15),
    widget.KeyboardLayout(fmt='󰌌 {}', configured_keyboards=get_keyboard_layouts()),
    widget.CheckUpdates(
        fmt=' {}',
        distro='Arch_checkupdates',
        display_format='{updates}',
        no_update_string='0',
        colour_have_updates=theme['white1'],
        colour_no_updates=theme['white1'],
        update_interval=60,
    ),
    *relative_widgets(),
    widget.Volume(
        fmt='󰕾 {}',
        update_interval=0.1,
        get_volume_command='pamixer --get-volume-human',
        volume_up_command='pamixer --increase 1',
        volume_down_command='pamixer --decrease 1',
        mouse_callbacks={
            'Button1': lazy.spawn('pamixer --toggle-mute'),
            'Button3': lazy.spawn('pavucontrol')
        }
    ),
    widget.Clock(format='󰃭 %d/%m/%Y 󱑁 %H:%M'),
    widget.Sep(foreground=theme['black1']),
    widget.TextBox(
        '',
        background=theme['white1'],
        foreground=theme['black1'],
        margin = 5,
        mouse_callbacks={
            'Button1': lazy.spawn(f'{Path(SCRIPTS_PATH, "powermenu.sh")}')
        }
    )
], 20))]


for _ in range(get_num_monitors() -1):
    screens.append(Screen(top=bar.Bar([create_groupbox(), widget.Spacer()], 20)))