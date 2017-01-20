Create symlinks
---------------

    mkdir ~/github
    cd ~/github
    git clone git@github.com:zevlg/dot-files.git
    ln -s ~/github/dot-files/dot.screenrc ~/.screenrc
    ln -s ~/github/dot-files/dot.gitconfig ~/.gitconfig
    ln -s ~/github/dot-files/dot.githubconfig ~/.githubconfig
    ln -s ~/github/dot-files/dot.Xdefaults ~/.Xdefaults
    ln -s ~/github/dot-files/dot.Xmodmap ~/.Xmodmap
    ln -s ~/github/dot-files/dot.xinitrc ~/.xinitrc
    ln -s ~/github/dot-files/dot.zprofile ~/.zprofile
    ln -s ~/github/dot-files/dot.zsh ~/.zsh
    ln -s ~/github/dot-files/dot.signature ~/.signature

Install packages
----------------

    sudo apt-get install zsh
    sudo apt-get install unclutter
    sudo apt-get install xfonts-terminus
    sudo apt-get install xwrits
