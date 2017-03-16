set -o vi
alias ls='ls -F --color'

BASH_HOME=/c/users/deocampo

# Setup XDG directories
export XDG_CONFIG_HOME=$USERPROFILE/AppData/Local
export XDG_DATA_HOME=$HOME/.local/share

# export CONDA_HOME=$LOCALAPPDATA/Continuum/MiniConda3
export GOPATH=$HOME/go
export WORKON_HOME=$BASH_HOME/python/venv
export MSYS_HOME=$PROGRAMFILES/Git

# export pandoc location
export PATH=$PATH:$HOME/AppData/Local/Pandoc:/c/texlive/2015/bin/win32

# export neovim location
export PATH=$PATH:$HOME/opt/neovim/bin

# export conda location
export PATH=$PATH:$HOME/python/miniconda3/Scripts

# Setup neovim path
export PATH=$PATH:$HOME/opy/Neovim/bin

# export VS17 bin, lib, and includes
VS17_HOME="/c/Program Files/Microsoft Visual Studio/2017/Community"
SDK_HOME="/c/Program Files/Windows Kits"
UCRT_VER="10.0.10240.0" 

export PATH="$VS17_HOME/VC/Tools/MSVC/14.10.24728/bin/HostX86/x86":"$SDK_HOME/8.1/bin/x86":$PATH
export INCLUDE="$SDK_HOME/10/Include/$UCRT_VER/ucrt":"$VS17_HOME/VC/Tools/MSVC/14.10.24728/include":"$SDK_HOME/8.1/Include/shared":"$SDK_HOME/8.1/Include/um"
export LIB="$SDK_HOME/8.1/Lib/winv6.3/um/x86":"$VS17_HOME/VC/Tools/MSVC/14.10.24728/lib/x86":"$SDK_HOME/10/Lib/$UCRT_VER/ucrt/x86"

# Exports for Rust
export RUST_SRC_PATH=$HOME/.rustup/toolchains/nightly-i686-pc-windows-msvc/lib/rustlib/src/rust/src

# Set utf8 encoding for python3.5+
/c/windows/system32/chcp.com 65001 > /dev/null

# Set utf-8 for python2.7
export PYTHONIOENCODING=UTF-8

# Set quote style
export QUOTING_STYLE=literal

# VENV_WRAPPER_BIN=/c/python35/Scripts/virtualenvwrapper.sh
# VENV_WRAPPER_BIN=/C/users/deocampo/python/miniconda3/envs/bare-devel/Scripts/virtualenvwrapper.sh
# if [ -f $VENV_WRAPPER_BIN ]; then
#     source $VENV_WRAPPER_BIN 
# fi

source $BASH_HOME/.config/bash/bash_completion.d/git-flow-completion.bash

# Setup SSH

# ssh-pageant
# eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")

SSH_ENV="$HOME/.ssh/environment"
GIT_SSH="/usr/bin/ssh.exe"

function start_agent 
{
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cygwin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
	start_agent;
    }
else
    start_agent;
fi

# System venv
# . $BASH_HOME/python/venv/devel-3.5.2/Scripts/activate

# Conda venv
. activate devel-3.6.0
# . activate devel
