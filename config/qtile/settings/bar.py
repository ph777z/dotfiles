from pathlib import Path

from libqtile import bar, widget
from libqtile.lazy import lazy

from .colors import theme
from .widgets import Backlight
from .apps import terminal
from .conts import SCRIPTS_PATH
from .devides import get_backlight


widget_defaults = dict(
    font='FiraCode Nerd Font Medium',
    background=theme['color1'],
    foreground=theme['color3'],
    fontsize=13,
    padding=5,
)

extension_defaults = widget_defaults.copy()

backlight_file = get_backlight()

BAR = bar.Bar(
    [
        widget.GroupBox(
            highlight_method='line',
            urgent_alert_method='text',
            this_current_screen_border=theme['color4'],
            active=theme['color3'],
            inactive=theme['color2'],
            margin_x=0,
            rounded=True,
            disable_drag=True,
            borderwidth=2
        ),
        widget.Sep(
            foreground=theme['color1'],
            padding=10
        ),
        widget.WindowName(
            format='{name}',
            empty_group_string='Desktop',
            width=200,
        ),
        widget.Spacer(),
        widget.Systray(
            icon_size=16,
            padding=8,
        ),
        widget.Sep(
            foreground=theme['color1'],
            padding=10
        ),
        widget.CheckUpdates(
            fmt=' {}',
            distro='Arch_checkupdates',
            display_format='{updates}',
            no_update_string='0',
            colour_have_updates=theme['color3'],
            colour_no_updates=theme['color3'],
            update_interval=60,
            mouse_callbacks = {
                'Button1': lazy.spawn(
                    f'{terminal} {Path(SCRIPTS_PATH, "update_pkgs.sh")}'
                )
            }
        ),
        Backlight(
            fmt='󰃟 {}',
            backlight_name='intel_backlight',
            scroll=False,
        )
        if backlight_file
        else widget.Sep(
            foreground=theme['color1'],
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
            foreground=theme['color1'],
            padding=10
        ),
        widget.Bluetooth(
            fmt=' {}',
            hci='/dev_41_42_E8_33_E8_09',
            mouse_callbacks = {
                'Button1': lazy.spawn('rofi-bluetooth')
            }
        ),
        widget.Wlan(
            interface='wlp1s0',
            format='  {essid}',
            disconnected_message='󰤭 ',
            mouse_callbacks = {
                'Button1': lazy.spawn(
                    f'{Path(SCRIPTS_PATH, "wifi-menu.sh")}'
                )
            }
        ),
        widget.Sep(
            foreground=theme['color1'],
            padding=10
        ),
        widget.Clock(
            format='󰸗 %d/%m/%Y  %H:%M',
            mouse_callbacks = {
                'Button1': lazy.spawn(f'{terminal} sh -c "cal; read"')
            }
        ),
        widget.Sep(
            foreground=theme['color1'],
            padding=10
        ),
        widget.TextBox(
            '',
            mouse_callbacks = {
                'Button1': lazy.spawn(
                    f'sh {Path(SCRIPTS_PATH, "powermenu.sh")}'
                )
            }
        ), 
        widget.Sep(
            foreground=theme['color1'],
        ),
    ],
    20,
)
