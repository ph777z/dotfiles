'''
        Backlight(
            fmt='󰃟 {}',
            backlight_name=backlight_file,
            scroll=False,
        )
        if backlight_file
        else widget.Sep(foreground=theme['black1'], padding=0),
        
        widget.Sep(foreground=theme['black1'], padding=8),
        widget.Bluetooth(
            fmt=' {}',
            hci=hci0_dev,
            mouse_callbacks={
                'Button1': lazy.spawn('rofi-bluetooth')
            }
        )
        if hci0_dev
        else widget.Sep(foreground=theme['black1'], padding=0),
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
        else widget.Sep(foreground=theme['black1'], padding=0),
        widget.Sep(foreground=theme['black1'], padding=8)
        if wlan_dev_name or hci0_dev
        else widget.Sep(foreground=theme['black1'], padding=0),
'''