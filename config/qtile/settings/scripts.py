import subprocess
from libqtile import hook
from pathlib import Path

from .conts import SCRIPTS_PATH


@hook.subscribe.startup_once
def autostart():
    sh = Path(SCRIPTS_PATH, 'autostart.sh')
    subprocess.call([sh])
