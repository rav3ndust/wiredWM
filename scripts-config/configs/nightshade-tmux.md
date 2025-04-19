# tmux - nightshade setup

![image](https://github.com/user-attachments/assets/fd1b626b-f8be-49d1-97fc-a5b322157185)
###### nightshade-tmux in action

This is documentation on our `tmux` setup, which is based closely off of **WiredWM**.

We have some custom keybindings we have setup that are adapted from wiredWM, and you will also notice that our tmux configuration uses the **nightshadeNeon** color scheme.

In our docs and code, we refer to this tmux configuration as `nightshade-tmux`.

### QoL

You'll find a few quality-of-life things here to make the experience comfortable.

This includes the nightshadeNeon-based design, which aims to emulate wiredWM inside your terminal, and gives you a date and time on the bottom, along with which session you're inside, with the pane name.

If you're using tmux on a desktop, you will also notice that mouse support is ready for you. You can select and resize panes using your mouse, should you so desire.

### custom keybindings

The default way to begin interacting with tmux is **Ctrl+B**. After this combination is entered, then you can use the shortcut you're looking for.

> Please note that in this list, the letters for bindings are case-sensitive.

- **c**: Run tmux commands.
- **h**: Spawn a new pane horizontally.
- **v**: Spawn a new pane vertically.
- **x**: Kill a pane, with confirmation.
- **Q**: Also kills a pane, but without confirmation.
- **o**: Move betweens open panes.
- **;**: Also moves between open panes.
- **:**: Switches pane positions.
- **Arrow keys**: Adjust pane size.
- **f**: Fullscreen/restore a pane.
- **w**: Opens a list of active tmux sessions you can switch between.

### tweaking it more

If you want to tweak the configuration further, you can find it at: 

`$HOME/.tmux.conf`

Have fun, and don't forget to reload the configuration file in order to see your changes take effect! It's smart to keep a backup of this file in case something goes wrong, so you can restore the configuration to its original if needed.
