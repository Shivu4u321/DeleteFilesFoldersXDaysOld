import os
import time
import sys

if len(sys.argv) > 1:
    directory_to_check = sys.argv[1]
    days_old = int(sys.argv[2])
    print(f"path of directory to be deleted: {directory_to_check}")
    print(f"number of days older: {days_old}")
else:
    print("No arguments provided.")
    

def list_old_files_and_folders(directory, days=days_old):
    # Get the current time
    current_time = time.time()

    # List to store the paths of old files/folders
    old_files_and_folders = []

    # Iterate through the files and directories in the given directory (first level only)
    with os.scandir(directory) as entries:
        for entry in entries:
            if entry.is_file() or entry.is_dir():  # Check only files and directories
                entry_path = entry.path
                entry_age = current_time - os.path.getmtime(entry_path)
                if entry_age > (days * 86400):  # 86400 seconds in a day
                    old_files_and_folders.append(entry_path)
    
    return old_files_and_folders

# Function to log the old files and folders to a file
def log_old_files_to_file(old_files_and_folders, log_file='oldFilesAndFolders.txt'):
    with open(log_file, 'w') as file:
        if old_files_and_folders:
            for item in old_files_and_folders:
                file.write(item + '\n')
        else:
            file.write("No files or folders older than given number of days.\n")

# Function call to list the old files and folders in a given directory

old_files_and_folders = list_old_files_and_folders(directory_to_check, days_old)

# Log the result to oldFilesAndFolders.txt
log_old_files_to_file(old_files_and_folders)

print("Old files and folders have been logged in 'oldFilesAndFolders.txt'.")
