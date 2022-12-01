# bash-osx-autoproxy

[![License](https://img.shields.io/github/license/sukkaw/zsh-osx-autoproxy.svg?style=flat-square)](./LICENSE)

:nut_and_bolt: An [`oh-my-bash`](https://github.com/ohmybash/oh-my-bash) plugin that configures proxy environment variables based on macOS's system preferences automatically.

## Installation

### oh-my-bash

1. Clone this repository into `$OSH_CUSTOM/plugins` (by default `~/.oh-my-bash/custom/plugins`)

```bash
git clone https://github.com/Artoria2e5/bash-osx-autoproxy ${OSH_CUSTOM:-~/.oh-my-bash/custom}/plugins/osx-autoproxy
```

2. Add the plugin to the list of plugins for oh-my-bash to load (inside `~/.bashrc`):

```
plugins=(
    [plugins
     ...]
    osx-autoproxy
)
```

3. Start a new terminal session.

### Vanilla

Who the heck uses OMB unless they are trying to be edgy? Just download the file into your dotfile directory and somehow source it.

I mean, I wrote this because I was trying to be edgy. I almost gave up when I realized I don't have bash 4 but OMB works fine on bash 3. The thing could've been much leaner in `eval` if I didn't care about OMB compat...

## Usage

After install the plugin and have proxy configured in `System Prefrences`, start a new terminal session and following environment variables will be set (if applicable):

- `http_proxy`
- `https_proxy`
- `ftp_proxy`
- `all_proxy`

You can even reload it via `__osx_autoproxy_reload`! How cool is that! (No it's not cool at all I know.)

## Uninstallation

**If you install `bash-osx-autoproxy` with oh-myzsh**, you need to remove `osx-autoproxy` item from plugin array, then `rm -rf ${OSH_CUSTOM:-~/.oh-my-bash/custom}/plugins/osx-autoproxy` to remove the plugin.

## Author

**zsh-osx-autoproxy** © [Sukka](https://github.com/SukkaW), MIT License.

**bash-osx-autoproxy** © Artoria2e5, MIT License. I wish I can beg for cash here lol. 
