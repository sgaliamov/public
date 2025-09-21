# Arch on WSL

<https://wiki.archlinux.org/title/Install_Arch_Linux_on_WSL>

## First get it

``` pwsh
winget install --id=Microsoft.WSL -e
wsl --install archlinux
# need reboot?
```

## Initial upgrade

``` sh
pacman -Sy --needed archlinux-keyring # pull new keys first
pacman -Su                            # then upgrade everything else
```

It's safer that `pacman -Syu`, as it will die the moment it meets a package signed with a key you do not yet have.

## Locale

Needed for perl.

``` sh
sudo sed -i 's/^#\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
sudo locale-gen
echo 'LANG=en_US.UTF-8' | sudo tee /etc/locale.conf
```

## Nushell

Install nushell before users to be able set it as a default shell during the creation.

``` sh
# Install Nu and some other useful tools.
pacman -S --noconfirm git xclip fd ripgrep sudo neovim which nushell zoxide

# https://nanthony007.medium.com/the-best-fully-rust-based-terminal-setup-f6384ea3de1d
# zellij
# hyperfine: CLI benchmarking tool
# exa
# starship

# Tell Arch that Nu is a legal login shell
which nu | sudo tee -a /etc/shells        # adds e.g. /usr/bin/nu to /etc/shells

```

## Create user

When we connect to `Arch` first time we connect under the `root` user.
That why we need create a new one.

``` sh
useradd -m -G wheel,video -s "$(which nu)" archie
```

It will create the user and set `nu` as a default shell.

Open `/etc/sudoers` and uncomment `%wheel ALL=(ALL:ALL) NOPASSWD: ALL`

`wheel` is a local admin.

## Configure default WSL user.

If you are using WSL 2.4.10 or later, you can set the default user for your distribution with:

End current WSL session:

``` sh
exit
```

``` pwsh
wsl --manage archlinux --set-default-user archie
```

## Configure git

``` sh
git config --global user.name "s. galiamov"
git config --global user.email "6alyamov@gmail.com"
git config --global credential.helper "/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"
```

## Configure Nushell

<https://www.nushell.sh/book/configuration.html>

``` sh
$env.config.buffer_editor = "nvim"
config nu
```

Add to the file:

``` conf
$env.config.buffer_editor = 'nvim'
$env.config.edit_mode = 'vi'
```

## Neo vim

TBD

### Rust

``` sh
sudo pacman -Syu
sudo pacman -Sy base-devel lld mold clang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-edit # to run `cargo upgrade`
```

## ZSH

``` sh
pacman -S --noconfirm zsh
```

### Basic zsh config

``` sh
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v # for vim bindings

zstyle :compinstall filename '/root/.zshrc'
autoload -Uz compinit
compinit

setopt PROMPT_SUBST
PROMPT=$'%n: %~\n%F{047}λ%f '
```

### OMZ

Optional and slow

``` sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Other

### Legacy way to install

Follow <https://github.com/yuk7/ArchWSL>

### Fix keyring

If fails with errors like:

- error: keyring is not writable
- error: libcap: signature from "..." is unknown trust
- ... invalid or corrupted package (PGP signature)

run:

``` sh
# Nuke and rebuild the keyring
# rm -rf /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux        # pulls in the official master keys
# Grab the *latest* arch key bundle first, THEN upgrade everything
pacman -Sy --needed archlinux-keyring  # don’t ask, just install
# ? pacman-key --populate
pacman -Syu                            # now a normal full upgrade works
# Optional: refresh keys from keyserver (slow, but thorough)
pacman-key --refresh-keys
# Check
timedatectl status                     # wrong clock = expired keys
```
