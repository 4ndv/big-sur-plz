# READ ME FIRST

This repository here is mostly for the historic purposes. Please use [OpenCore Legacy Patcher](https://dortania.github.io/OpenCore-Legacy-Patcher/)!

# Big Sur, Please

[Full installation guide for Catalina-capable Macs](https://medium.com/@andv/how-to-install-big-sur-to-mac-mini-late-2012-9d674b563174)

[All the information about Big Sur on unsupported Macs, structured in one place](https://lynx.pink/big-sur-unsupported-macs-tldr/)

[Buy me a ☕️ if you like my projects :)](https://lynx.pink/buymeacoffee)

----------

## What's this?

It's a simple script, that automates some of the actions, required to setup Big Sur on unsupported macs.

Here's my [full installation guide for Catalina-capable Macs](https://medium.com/@andv/how-to-install-big-sur-to-mac-mini-late-2012-9d674b563174).

Also, follow this topic on MacRumors for more info: [https://forums.macrumors.com/threads/macos-11-big-sur-on-unsupported-macs-thread.2242172/](https://forums.macrumors.com/threads/macos-11-big-sur-on-unsupported-macs-thread.2242172/).

Please report any issues in the github issues section.

This script:

- Checks if SIP disabled
- Checks if FileVault disabled (will remove in the future if error 66 not caused by FileVault), this check can be skipped
- Disables library validation
- Adds -no_compat_check to the boot-args
- Automatically downloads and extracts patcher
- Runs installer with patcher, with a little bit different, but more stable method

## How to run?

Clone repository:

```bash
cd ~
git clone https://github.com/4ndv/big-sur-plz.git
```

Navigate to `big-sur-plz` folder:

```bash
cd ~/big-sur-plz
```

Run with default installer path:

```bash
/usr/bin/ruby big_sur_plz.rb
```

Run with custom installer path:

```bash
/usr/bin/ruby big_sur_plz.rb "/Users/user/Downloads/Install macOS Beta.app"
```

And follow the instructions

## Huge thanks

- [ASentientBot](https://forums.macrumors.com/members/asentientbot.1135186/) for the installer patcher
- MacRumors community in a nutshell
