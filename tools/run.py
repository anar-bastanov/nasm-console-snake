#!/usr/bin/env python3

import os
import platform
import subprocess
import sys

ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
BUILD_DIR = os.path.join(ROOT_DIR, "build")
EXE_NAME = "qrgen.exe" if platform.system() == "Windows" else "qrgen"
EXE_PATH = os.path.join(BUILD_DIR, "bin", EXE_NAME)

def run_command(command, cwd=None):
    print(f"[CMD] {command}")
    result = subprocess.run(command, shell=True, cwd=cwd)
    if result.returncode != 0:
        print(f"[ERROR] Command failed: {command}")
        sys.exit(result.returncode)

def main():
    print("[*] Configuring...")
    run_command(f'cmake -S "{ROOT_DIR}" -B "{BUILD_DIR}"')

    print("[*] Building...")
    run_command(f'cmake --build "{BUILD_DIR}"')

    print("[*] Running...")
    argv = sys.argv
    argv[0] = EXE_PATH

    if (new_window := len(argv) > 1 and argv[1] == "--new-window"):
        argv.pop(1)

    if platform.system() == "Windows" and new_window:
        args_str = subprocess.list2cmdline(argv)
        subprocess.Popen(f'start "" {args_str}', shell=True)
    else:
        print("------------------------------\n")
        subprocess.run(argv)

if __name__ == "__main__":
    main()
