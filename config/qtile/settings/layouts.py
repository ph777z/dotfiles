from libqtile.layout import floating, bsp, max
from libqtile.config import Match, Click, Drag
from libqtile.lazy import lazy

from .colors import theme
from .keymaps import mod


layouts = [
    bsp.Bsp(
        border_width=1,
        margin=6,
        border_on_single=True,
        border_focus=theme['color3'],
        border_normal=theme['color2'],
    ),
    max.Max()
]

floating_layout = floating.Floating(
    border_width=1,
    border_focus=theme['color3'],
    border_normal=theme['color2'],
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
