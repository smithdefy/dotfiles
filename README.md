# My Dotfiles
## Dependencies
- zsh: `brew install zsh`
- Oh My Zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- Powerlevel10k: `git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k`
- Fonts: Install Inconsolata or another Powerline font from https://github.com/powerline/fonts
- Plugins: zsh-autosuggestions, zsh-syntax-highlighting
## Setup Instructions
1. Clone this repo: `git clone <repo-url> ~/dotfiles`
2. Symlink .zshrc: `ln -s ~/dotfiles/.zshrc ~/.zshrc`
3. Install dependencies as listed above.
4. For Kitty, configure theme and font manually (see Kitty setup below).
