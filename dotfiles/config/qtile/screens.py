from os import getenv
from pathlib import Path
from typing import List

from libqtile.config import Group, Screen
from libqtile.lazy import lazy
from libqtile import bar, widget

from base import terminal, theme, SCRIPTS_PATH
from devides import get_num_monitors, get_wlan, get_backlight


class Bar:
    wlan_dev_name = get_wlan()
    hci0_dev = getenv('QTILE_BLUEZ_DEV', None)
    backlight_file = get_backlight()

    @classmethod
    def primary_bar(cls):
        return bar.Bar([
            widget.GroupBox(
                active=theme['white1'],
                inactive=theme['black2'],
                highlight_method='block',
                block_highlight_text_color=theme['black1'],
                this_current_screen_border=theme['white2'],
                this_screen_border=theme['black2'],
                other_current_screen_border=theme['white2'],
                other_screen_border=theme['black2'],
                urgent_alert_method='text',
                urgent_text=theme['red1'],
                urgent_border=theme['red1'],
                margin_x=0,
                rounded=True,
                disable_drag=True,
                borderwidth=2
            ),
            widget.Sep(foreground=theme['black1'], padding=0),
            widget.WindowName(format='{name}', width=200),
            widget.Spacer(),
            widget.Systray(icon_size=16, padding=8),
            widget.Sep(padding=15),
            widget.KeyboardLayout(fmt='󰌌 {}', configured_keyboards=['br']),
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
            widget.Volume(
                fmt='󰕾 {}',
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
            widget.Clock(format='󰃭 %d/%m/%Y 󱑁 %H:%M'),
            widget.Sep(foreground=theme['black1']),
            widget.TextBox(
                '',
                background=theme['white1'],
                foreground=theme['black1'],
                margin = 5,
                mouse_callbacks={
                    'Button1': lazy.spawn(
                        f'sh {Path(SCRIPTS_PATH, "powermenu.sh")}'
                    )
                }
            )
        ], 20)

    @staticmethod
    def second_bar():
        return bar.Bar([
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
        )], 20)

class Screens:
    groups = [Group(i) for i in '12345678']
    
    def __init__(self):
        self.__index = 0
        self.__screens: List[Screen] = [Screen(top=Bar.primary_bar())]
        for _ in range(get_num_monitors() -1):
            self.__screens.append(Screen(top=Bar.second_bar()))

    @property
    def screens(self) -> List[Screen]:
        return self.__screens

    def next(self):
        if self.__index < len(self.__screens):
            self.__index += 1
        else:
            self.__index = 0
        lazy.to_screen(self.__index)

    def prev(self):
        if self.__index > 0:
            self.__index -= 1
        else:
            self.__index = len(self.__screens)

        lazy.to_screen(self.__index)


screens_obj = Screens()