#!/bin/bash

echo "Welcome to the DASO installer!"

# A solution for macOS
DASO="$HOME/DASO/src/__main__.py"
chmod +x "$DASO"
venv_path="$HOME/DASO/venv"

if [ ! -f "$DASO" ]; then
    echo "Error: DASO not found at $DASO. Clone the repo 'https://github.com/JoshuaKasa/DASO.git' into $HOME."
    exit 1
fi


echo "Setting up a new venv."

python3 -m venv "$venv_path"
source "$venv_path/bin/activate"
pip install -r "$HOME/DASO/requirements.txt"
deactivate

# Add src directory to user's PATH
scriptPath="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
srcPath="$scriptPath/src"

if [[ ":$PATH:" != *":$srcPath:"* ]]; then
    echo "export PATH=\$PATH:$srcPath" >> "$HOME/.bash_profile"
    source "$HOME/.bash_profile"
    echo "The directory has been added to your PATH."
else
    echo "The directory is already in your PATH."
fi

# Configure shell profile
SHELL_PROFILE=""
if [ -f "$HOME/.bash_profile" ]; then
    SHELL_PROFILE="$HOME/.bash_profile"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
fi

# Check if the shell profile file exists
if [ -n "$SHELL_PROFILE" ]; then
    # Check if the alias already exists in the shell profile
    ALIAS_COMMAND="alias daso='/usr/local/bin/python3 $DASO'"
    if ! grep -qF "$ALIAS_COMMAND" "$SHELL_PROFILE"; then
        # If not, append the alias to the shell profile
        echo -e "\n# Added by DASO installation script" >> "$SHELL_PROFILE"
        echo "$ALIAS_COMMAND" >> "$SHELL_PROFILE"
        echo "Alias added to $SHELL_PROFILE. Please restart your shell or run 'source $SHELL_PROFILE' to apply changes."
    else
        echo "Alias already exists in $SHELL_PROFILE. No changes made."
    fi
else
    echo "Unable to find a suitable shell profile file (.bash_profile or .zshrc)."
fi

read -p "Press Enter to exit setup..."
