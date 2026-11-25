    #!/usr/bin/env bash
    
    # colored status banner: bold magenta [+] markers, bold cyan text
    msg() {
        printf '\n\033[1;95m[+]\033[0m \033[1;96m%s\033[0m \033[1;95m[+]\033[0m\n' "$*"
    }
    
    # GEF
    msg "Installing GEF"
    bash -c "$(curl -fsSL https://gef.blah.cat/sh)"
    
    # pwndbg
    msg "Installing pwndbg"
    curl --proto '=https' --tlsv1.2 -LsSf 'https://install.pwndbg.re' | sh -s -- -t pwndbg-gdb
    
    # rizin + pwntools + fish shell
    msg "Installing rizin + pwntools + fish"
    sudo apt update && sudo apt install python3-pwntools "rizin*" "rz*" fish -y
    
    # zed editor
    msg "Installing Zed editor"
    curl -f https://zed.dev/install.sh | sh
    
    # change shell to fish
    msg "Changing shell to fish"
    sudo chsh -s "$(command -v fish)" "$USER"
    
    # download nerd fonts
    msg "Installing Nerd fonts (JetBrainsMono & ZedMono)"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/JetBrainsMono.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/ZedMono.zip
    sudo unzip -o JetBrainsMono.zip -d /usr/share/fonts
    sudo unzip -o ZedMono.zip -d /usr/share/fonts
    rm ZedMono.zip JetBrainsMono.zip
    sudo fc-cache -f
    
    # download zellij
    msg "Installing Zellij"
    wget https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz
    tar -xvf zellij-x86_64-unknown-linux-musl.tar.gz
    sudo mv zellij /usr/local/bin/ && sudo chmod +x /usr/local/bin/zellij
    rm -f zellij-x86_64-unknown-linux-musl.tar.gz
    
    # eza + batcat
    msg "Installing eza + bat"
    sudo apt install eza bat -y
    
    # fish config (PATH + aliases, single write)
    msg "Writing fish config"
    mkdir -p "$HOME/.config/fish"
    cat > "$HOME/.config/fish/config.fish" << 'EOF'
    # PATH (system dirs are already in the default fish PATH)
    fish_add_path -g $HOME/.local/bin
    
    # Long views
    alias l='eza -blF --git --header --group-directories-first --icons=auto --color=auto'
    alias ll='eza -la --git --header --octal-permissions --group-directories-first --icons=auto --color=auto'
    alias la='eza -la --git --header --group-directories-first --icons=auto --color=auto'
    alias lm='eza -l --git --header --sort=modified --reverse --group-directories-first --icons=auto --color=auto'
    
    # Compact and specialist views
    alias l1='eza --oneline --group-directories-first --icons=auto --color=auto'
    alias lt='eza --tree --level=2 --group-directories-first --icons=auto --color=auto'
    alias l.='eza -a --oneline --color=never | grep -E "^\."'
    alias ls='eza --group-directories-first --icons=auto --color=auto'
    alias cat='batcat'
    EOF