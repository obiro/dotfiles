brew tap sanemat/font
brew install --with-powerline ricty

cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf
