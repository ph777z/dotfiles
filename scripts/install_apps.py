import json
import subprocess
from pathlib import Path


DOTFILES_PATH = Path(Path.home(), 'dotfiles')
APPS_FILE = Path(DOTFILES_PATH, 'scripts', 'apps.json')


def app_installed(app):
    result = subprocess.run(
        ['pacman', '-Qs', f'^{app}$'], capture_output=True
    )

    return result.returncode


def install_pacman_app(app):
    installed = subprocess.run(
        ['sudo', 'pacman', '-S', '--noconfirm', app]
    )

    return installed.returncode


def install_aur_app(app):
    installed = subprocess.run(
        ['paru', '-S', '--noconfirm', app]
    )

    return installed.returncode


with APPS_FILE.open() as apps_json:
    apps = json.loads(apps_json.read())

if app_installed('paru-bin') != 0:
    subprocess.run(
        ['bash', Path(DOTFILES_PATH, 'scripts', 'install_paru.sh')]
    )

subprocess.run(['pacman', '-Sy'])

for app in apps['pacman']:
    if app_installed(app) != 0:
        install_pacman_app(app)


for app in apps['aur']:
    if app_installed(app) != 0:
        install_aur_app(app)
