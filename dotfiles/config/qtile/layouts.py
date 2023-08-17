from libqtile.config import Match
from libqtile.layout import floating, bsp, max

from base import theme


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