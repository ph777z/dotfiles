from pathlib import Path


def get_backlight() -> list | None:
    backligh_path = Path('/sys/class/backlight')
    backlight_files = list(backligh_path.iterdir())

    if backlight_files:
        return list(backligh_path.iterdir())[0].name

    return None
