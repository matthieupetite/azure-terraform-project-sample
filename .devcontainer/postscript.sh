#!/bin/sh

# Install npm check updates 
sudo npm i -g npm-check-updates

# Install all the node packages needed for development
for folder in $(find /home/vscode/workspace -maxdepth 2 -name "package.json" -type f -print0 | xargs -0 -n1 dirname)
do
    cd $folder; npm install
done

# Install azure-cost-cli 
dotnet tool install --global azure-cost-cli 

# Install Oh My Zsh 
[ -x $HOME/.oh-my-zsh ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# If you whish to install spaceship zsh custom theme, you can uncomment the following two commands and set ZSH_THEME="spaceship" in your .zshrc 
# git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1 \
# && ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Figlet
figlet -ck -w 60 Azure Practice Labs
