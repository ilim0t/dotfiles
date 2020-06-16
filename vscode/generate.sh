#!/bin/bash
echo "#!/bin/bash" > ./vscode/install.sh
code --list-extensions | xargs -L 1 echo code --install-extension >> ./vscode/install.sh