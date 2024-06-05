# Clone or update Flutter repository
if cd flutter; then
  git pull && cd ..;
else
  git clone https://github.com/flutter/flutter.git;
fi

# List files to check the directory structure
ls

# Ensure Flutter binaries are in PATH
export PATH="$PATH:$(pwd)/flutter/bin"

# Run Flutter doctor to check environment setup
flutter/bin/flutter doctor

# Install necessary dependencies for Linux development
sudo apt-get update
sudo apt-get install -y clang cmake ninja-build libgtk-3-dev

# Clean previous builds
flutter/bin/flutter clean

# Enable web support in Flutter
flutter/bin/flutter config --enable-web