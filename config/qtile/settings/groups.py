from libqtile.config import Group, Key
from libqtile.lazy import lazy

from .keymaps import mod, keys


groups = [Group(i) for i in '12345']


for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc='Switch to group {}'.format(i.name),
            ),
            Key(
                [mod, 'shift'],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc='Switch to & move focused window to group {}'.format(
                    i.name
                ),
            ),
        ]
    )


