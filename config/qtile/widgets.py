from libqtile.widget import backlight


class Backlight(backlight.Backlight):
    def cmd_change_backlight(self, direction, step=None):
        if not step:
            step = self.step
        if self._future and not self._future.done():
            return
        new = now = self._get_info() * 100
        if direction is backlight.ChangeDirection.DOWN:
            if step is not None:
                new = max(now - step, 10)
        elif direction is backlight.ChangeDirection.UP:
            if step is not None:
                new = min(now + step, 100)
        if new != now:
            self._future = self.qtile.run_in_executor(
                self._change_backlight, new
            )
