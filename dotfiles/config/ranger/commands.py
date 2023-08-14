# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)


from ranger.api.commands import Command


class setwall(Command):
    def execute(self):
        _img = self.fm.thisfile
        sh = 'set-background'
        self.fm.run(f'{sh} {_img}')


class terminal(Command):
    def execute(self):
        self.fm.run('kitty', flags='f')
