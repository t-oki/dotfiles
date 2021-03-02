 #!/bin/bash

  DOT_FILES=(.zshrc .gitconfig .gitignore_global)

 for file in ${DOT_FILES[@]}
 do
     ln -s $HOME/src/github.com/t-oki/dotfiles/$file $HOME/$file
 done
