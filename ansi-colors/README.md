
# Ansi color printing for Bash Scripts

Some functions for using ANSI colors as needed for output.

While nodejs and chalk would work, I cannot get chalk installed on Linux 7

And so these functions were created.

Only the basic 16 colors for foreground and background are used.

## Usage

The following command line will print a display of all color combinations:

```bash
SHOW_COLORS=1 bash ansi-color.sh
```
![Ansi Colors](/images/bash-colors.png)

The ansi-color-demo.sh script is a simple example to show useage:

```
bash ansi-color-demo.sh
```

![Ansi Color Demo](/images/ansi-color-demo.png)



