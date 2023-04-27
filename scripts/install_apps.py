#!/bin/python

import json
import subprocess
from pathlib import Path


DOTFILES_PATH = Path(Path.home(), '.dotfiles')
APPS_FILE = Path(DOTFILES_PATH, 'scripts', 'apps.json')



class InstallApps:
    
    def __init__(self, apps: list):
        self.apps = apps
        for section in self.apps:
            self.load_section(section)

    def install_app(self, to_install):
        if isinstance(to_install, list):
            for app in to_install:
                self.install_app(app)
        else:
            if not self.app_installed(to_install):
                subprocess.run(
                    ['paru', '-S', '--noconfirm', to_install]
                )
    
    @staticmethod
    def app_installed(app):
        result = subprocess.run(
            ['paru', '-Qs', f'^{app}$'], capture_output=True
        )
        return not bool(result.returncode)

    def get_section(self, app_name):
        for section in self.apps:
            name = section.get('name')
            if name is None:
                list = section.get('list')
                if app_name in list:
                    return section
            else:
                if app_name == name:
                    return section
    
    def load_deps(self, deps):
        for dep in deps:
            section = self.get_section(dep)
            if section is None:
                self.install_app(dep)
            else:
                self.load_section(section)
        
    def load_section(self, section):
        deps = section.get('depends')
        if deps is not None:
            self.load_deps(deps)
                
        to_install = section.get('name')
        if to_install is None:
            to_install = section.get('list')
    
        self.install_app(to_install)


def install_flatpaks(apps: list):
    for app in apps:
        flatpak_list = subprocess.Popen(
            ['flatpak', 'list'], stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )

        installed = subprocess.run(
            ['grep', app], stdin=flatpak_list.stdout, capture_output=True
        )

        if installed.returncode != 0:
            subprocess.run(['flatpak', 'install', '-y', 'flathub', app])


if __name__ == "__main__":
    with APPS_FILE.open() as apps_json:
        apps = json.loads(apps_json.read())

    if InstallApps.app_installed('paru-bin'):
        InstallApps(apps['paru'])

    if InstallApps.app_installed('flatpak'):
        install_flatpaks(apps['flatpak'])