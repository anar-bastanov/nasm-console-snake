import os
import platform
import subprocess
import sys

# Configuration
build_dir = "build"
exe_name = "snake.exe" if platform.system() == "Windows" else "snake"
exe_path = os.path.join(build_dir, "bin", exe_name)

def run_command(command, cwd=None):
    result = subprocess.run(command, shell=True, cwd=cwd)
    if result.returncode != 0:
        print(f"[ERROR] Command failed: {command}")
        sys.exit(result.returncode)

def main():
    # Step 1: Configure the project with CMake
    print("Configuring project...")
    run_command(f"cmake -S . -B {build_dir}")

    # Step 2: Build the project
    print("Building project...")
    run_command(f"cmake --build {build_dir}")

    # Step 3: Run the executable
    print("Running executable...")
    if platform.system() == "Windows":
        subprocess.Popen(f'start cmd /c "{exe_path}"', shell=True)
    else:
        subprocess.run([exe_path])

if __name__ == "__main__":
    main()
