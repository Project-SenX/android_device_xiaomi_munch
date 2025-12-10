KERNEL_DIR="kernel/xiaomi/sm8250"
PATCH_SCRIPT="nextpatch.sh"

if [ -f "$KERNEL_DIR/$PATCH_SCRIPT" ]; then
    echo "Found $PATCH_SCRIPT in $KERNEL_DIR. Applying KernelSU patch."
    
    cd "$KERNEL_DIR"
    chmod +x "$PATCH_SCRIPT" && bash "$PATCH_SCRIPT"
    
    if [ -d "KernelSU-Next" ]; then
        if [ -d "KernelSU-Next/userspace/su" ]; then
            echo "Removing KernelSU-Next/userspace/su directory."
            rm -rf KernelSU-Next/userspace/su
        else
            echo "KernelSU-Next/userspace/su not found. Skipping removal."
        fi
    else
        echo "KernelSU-Next directory not found. Skipping KernelSU operations."
    fi
    
    cd ../../..
else
    echo "Kernel patch script ($PATCH_SCRIPT) not found in $KERNEL_DIR. Skipping KernelSU operations."
fi

# Define a variable for the target clang directory path to make the script cleaner
CLANG_DIR="prebuilts/clang/host/linux-x86/clang-r574158"

if [ ! -d "$CLANG_DIR" ]; then
  echo "Clang directory not found. Cloning..."
  mkdir -p "$CLANG_DIR"
  wget -qO- "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/508ea7dd0d8f681904d0422e98af9613aaabf180/clang-r574158.tar.gz" | tar -xzf - -C "$CLANG_DIR"
  echo "Clang has been downloaded and extracted successfully."
else
  echo "Clang directory already exists. Skipping download."
fi
CLANG_DIR="prebuilts/clang/host/linux-x86/clang-r574158"
if [ ! -d "$CLANG_DIR" ]; then
  echo "Clang directory not found. Cloning..."
  mkdir -p "$CLANG_DIR"
  wget -qO- "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/508ea7dd0d8f681904d0422e98af9613aaabf180/clang-r574158.tar.gz" | tar -xzf - -C "$CLANG_DIR"
  
  echo "Clang has been downloaded and extracted successfully."
else
  echo "Clang directory already exists. Skipping download."
fi