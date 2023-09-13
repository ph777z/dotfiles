from pathlib import Path
from urllib.request import urlopen


config.load_autoconfig()

# default pages and search engine
c.url.start_pages = ['qute://bookmarks/']
c.url.default_page = 'qute://bookmarks/'
c.url.searchengines = {
    'DEFAULT': 'https://google.com/search?q={}',
    'yt': 'https://www.youtube.com/results?search_query={}',
    'gh': 'https://github.com/search?q={}'
}

# browser configs
c.editor.command = ['kitty', 'nvim', '{file}']

# theme config
theme_path = Path(config.configdir, 'theme.py')
if not theme_path.exists():
    theme_url = 'https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py'
    with urlopen(theme_url) as themehtml:
        with theme_path.open('a') as theme_file:
            theme_file.writelines(themehtml.read().decode('utf-8'))

import theme
theme.setup(c, 'mocha', True)
