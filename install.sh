#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status

echo "🚀 Starting Bootstrap..."

# --- 1. System Dependencies & Repositories ---
echo "📦 Configuring Repositories..."

sudo dnf copr enable -y jdxcode/mise
sudo dnf copr enable -y wezfurlong/wezterm-nightly

echo "📦 Installing System Tools..."

# Install all system packages in one go:
# - build tools: gcc-c++, make, etc. (for compiling treesitter/mason tools)
# - utilities: unzip, ripgrep (for grug-far), wl-clipboard (neovim clipboard)
# - shell: zsh, util-linux-user (chsh), bat
# - archive tools: p7zip, p7zip-plugins
# - core tools: git, chezmoi, mise, wezterm
sudo dnf install -y \
    gcc-c++ make unzip ripgrep wl-clipboard git \
    zsh util-linux-user bat \
    p7zip p7zip-plugins \
    chezmoi mise wezterm

# --- 2. Install Fonts ---
FONT_DIR="$HOME/.local/share/fonts"
FONT_NAME="Iosevka"

if [ ! -d "$FONT_DIR/$FONT_NAME" ]; then
    echo "🔤 Installing $FONT_NAME Nerd Font..."
    mkdir -p "$FONT_DIR/$FONT_NAME"

    curl -fLo "/tmp/$FONT_NAME.zip" \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT_NAME.zip"
    unzip -q "/tmp/$FONT_NAME.zip" -d "$FONT_DIR/$FONT_NAME"
    rm "/tmp/$FONT_NAME.zip"
    echo "🔄 Refreshing font cache..."
    fc-cache -fv &> /dev/null
else
    echo "✅ $FONT_NAME Nerd Font is already installed."
fi

# --- 3. Activate mise ---
# Since we installed via dnf, 'mise' is in the global PATH.
# We activate it for this script session so we can use 'mise use/x'.
eval "$(mise activate bash)"

# --- 4. Install Runtimes via mise ---
echo "📦 Installing Language Runtimes..."
# Add here more languages as needed
mise use --global node@lts
mise use --global usage

# --- 5. Install Bitwarden CLI via npm ---
# We use 'mise x' to ensure we are using the Node version we just installed
if ! command -v bw &> /dev/null; then
    echo "📦 Installing Bitwarden CLI..."
    mise x -- npm install -g @bitwarden/cli
else
    echo "✅ Bitwarden CLI is already installed."
fi

# --- 6. Install Oh-My-Zsh (Unattended) ---
OMZ_DIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZ_DIR" ]; then
    echo "📦 Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh-My-Zsh is already installed."
fi

# --- 7. Install Zsh Third-Party Plugins ---
# We clone these directly into the OMZ custom plugins folder so your .zshrc
# finds them immediately.
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_plugin() {
    local repo_url=$1
    local plugin_name=$2
    if [ ! -d "$ZSH_CUSTOM/plugins/$plugin_name" ]; then
        echo "🔌 Installing plugin: $plugin_name..."
        git clone --depth 1 "$repo_url" "$ZSH_CUSTOM/plugins/$plugin_name"
    else
        echo "✅ Plugin $plugin_name already exists."
    fi
}

install_plugin "https://github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions"
install_plugin "https://github.com/zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting"
install_plugin "https://github.com/MichaelAquilina/zsh-you-should-use" "you-should-use"
install_plugin "https://github.com/fdellwing/zsh-bat" "zsh-bat"

# --- 8. Initialize Chezmoi ---
# Initialize chezmoi with your repo if the destination directory doesn't exist
if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    echo "📂 Initializing chezmoi..."
    chezmoi init https://github.com/Alejojooo/dotfiles.git
fi

# --- 9. Bitwarden Authentication ---
# Loop 1: Login
while ! bw login --check &> /dev/null; do
    echo "🔐 You are not logged in to Bitwarden."
    if ! bw login; then
        echo "❌ Login failed. Retrying..."
        echo ""
    else
        echo "✅ Login successful."
    fi
done

# Loop 2: Unlock
while [ -z "$BW_SESSION" ]; do
    echo "🔓 Unlocking Bitwarden Vault..."
    if session_key=$(bw unlock --raw); then
        export BW_SESSION="$session_key"
        echo "✅ Vault unlocked successfully."
    else
        echo "❌ Unlock failed (wrong password?). Retrying..."
        echo ""
    fi
done

# --- 10. Apply Dotfiles ---
echo "✨ Applying configuration..."
chezmoi apply

# --- 11. Change Default Shell to Zsh ---
CURRENT_SHELL=$(grep "^$USER" /etc/passwd | cut -d: -f7)
TARGET_SHELL=$(command -v zsh)

if [ "$CURRENT_SHELL" != "$TARGET_SHELL" ]; then
    echo "🐚 Changing default shell to Zsh (requires password)..."
    chsh -s "$TARGET_SHELL"
fi

# --- 12. Post-Install: LazySync ---
# Trigger Neovim to install plugins immediately
# Headless run to let Lazy install everything and quit
if command -v nvim &> /dev/null; then
    echo "💤 Syncing Neovim Plugins..."
    nvim --headless "+Lazy! sync" +qa
fi

echo "🎉 Done! Restart your terminal to see changes."
