# My Dotfiles

## Dependencies
- zsh: `brew install zsh`
- Oh My Zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- Powerlevel10k (if used): `git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k`
- Fonts: Install Powerline fonts from https://github.com/powerline/fonts
- Plugins: Check .zshrc for required plugins (e.g., zsh-autosuggestions, zsh-syntax-highlighting)

## Setup Instructions
1. Clone this repo: `git clone <repo-url> ~/dotfiles`
2. Symlink .zshrc: `ln -s ~/dotfiles/.zshrc ~/.zshrc`
3. Symlink Oh My Zsh custom: `ln -s ~/dotfiles/.oh-my-zsh/custom ~/.oh-my-zsh/custom`
4. Install dependencies as listed above.
5. For Kitty, configure theme and font manually using iTerm2 settings as reference.
