 #!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
mkdir ../zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ../zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ../zsh/plugins/zsh-completions
