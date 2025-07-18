#!/usr/bin/env fish

# Check for NVIDIA GPU
lspci | grep 'VGA.*NVIDIA' >/dev/null
set nvidia_check $status

echo "Going to ask for sudo password to install packages"
if sudo -v
    echo "Thanks! ☺️"
else
    echo "Sudo password is required to proceed."
    exit 1
end

# Update system and install packages using Pacman
echo "Installing packages with Pacman..."
sudo pacman -Sq --needed --noconfirm \
    bitwarden \
    bitwarden-cli \
    discord \
    dotnet-host-bin \
    dotnet-runtime-bin \
    dotnet-sdk-bin \
    dotnet-targeting-pack-bin \
    freerdp \
    git \
    git-lfs \
    git-delta \
    github-cli \
    go \
    helm \
    jq \
    krdc \
    krew \
    kubectl \
    kubectx \
    kustomize \
    meld \
    podman \
    podman-compose \
    podman-docker \
    pulumi \
    ttf-jetbrains-mono \
    ttf-jetbrains-mono-nerd \
    virt-manager \
    wl-clipboard \
    yq \
    zen-browser-bin

# Install AUR packages using Paru
echo "Installing AUR packages with Paru..."
paru -Sq --needed --noconfirm \
    aws-cli-bin \
    jetbrains-toolbox \
    lens-bin \
    oh-my-posh-bin \
    powershell-bin \
    pulumi-language-dotnet \
    slack-desktop-wayland \
    visual-studio-code-bin \
    youtube-music-bin

# Install game-related packages if NVIDIA GPU is detected
if test $nvidia_check -eq 0
    echo "Installing game-related packages with Pacman..."
    sudo pacman -Sq --needed --noconfirm \
        protonup-qt

    echo "Installing game-related AUR packages with Paru..."
    paru -Sq --needed --noconfirm \
        raiderio-client \
        wowup-cf-bin

end

# Update all packages
echo "Updating all packages..."
paru -Syu --noconfirm

# Create sensitive directories
echo "Creating sensitive directories..."
for dir in ~/.ssh ~/.aws ~/.kube ~/.local
    mkdir -p -m 700 $dir
end

# Create general directories
echo "Creating general directories..."
for dir in ~/.local/bin ~/git/code ~/git/work
    mkdir -p -m 751 $dir
end

echo "Setup complete!"
