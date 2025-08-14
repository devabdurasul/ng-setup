#!/usr/bin/env bash

echo "Angular & Node.js Installer"
echo "------------------------------"

FAILED=0

run_step() {
  "$@" || FAILED=1
}

detect_os() {
  case "$OSTYPE" in
    linux*)   echo "linux" ;;
    darwin*)  echo "mac" ;;
    msys*|cygwin*|win32*) echo "windows" ;;
    *)        echo "unknown" ;;
  esac
}

OS=$(detect_os)

install_node_mac_linux() {
  echo "Installing Node.js (latest LTS)..."

  if [[ "$OS" == "mac" ]]; then
    if command -v brew >/dev/null; then
      echo "Homebrew found, installing Node.js..."
      run_step brew install node
    else
      echo "Homebrew not found, installing Homebrew..."
      run_step /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      # Set PATH for Homebrew in current session
      if [[ -d "/opt/homebrew/bin" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [[ -d "/usr/local/bin" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
      fi

      run_step brew install node
    fi
  elif [[ "$OS" == "linux" ]]; then
    echo "Detecting Linux distribution..."
    if [ -f /etc/debian_version ]; then
      echo "Debian/Ubuntu detected"
      run_step curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
      run_step sudo apt-get install -y nodejs
    else
      echo "Unsupported Linux distro. Please install Node.js manually."
      FAILED=1
    fi
  fi

  if command -v npm >/dev/null; then
    echo "Updating npm to latest version..."
    run_step npm install -g npm
  fi
}

install_angular() {
  echo "Installing Angular CLI v20..."
  run_step npm install -g @angular/cli@20
}

if command -v node >/dev/null; then
  echo "Node.js already installed ($(node -v))"
else
  echo "Node.js not found. Installing..."
  if [[ "$OS" == "windows" ]]; then
    echo "Windows detected. Use the PowerShell installer instead."
    FAILED=1
  elif [[ "$OS" == "mac" || "$OS" == "linux" ]]; then
    install_node_mac_linux
  else
    echo "Unsupported OS: $OS"
    FAILED=1
  fi
fi

if command -v ng >/dev/null; then
  echo "Angular CLI already installed (v$(ng --version | head -n 1))"
else
  install_angular
fi

echo ""
echo "Installation attempted!"
echo "   Node.js: $(command -v node >/dev/null && node -v || echo 'not installed')"
echo "   npm: $(command -v npm >/dev/null && npm -v || echo 'not installed')"
echo "   Angular CLI: $(command -v ng >/dev/null && ng --version | head -n 1 || echo 'not installed')"

if [[ $FAILED -ne 0 ]]; then
  echo ""
  echo "Some steps failed. See above logs."
  read -rp "Press Enter to exit..."
  exit 1
fi
