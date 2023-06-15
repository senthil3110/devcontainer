#!/bin/bash

# Set the folder to copy
source_folder="/path/to/source/folder"

# Set the destination folder on the servers
destination_folder="/path/to/destination/folder"

# Read the servers from an external file (one server per line)
servers_file="servers.txt"
servers=()

# Check if the servers file exists
if [ -f "$servers_file" ]; then
  # Read each line in the file and add it to the servers array
  while IFS= read -r server; do
    servers+=("$server")
  done < "$servers_file"
else
  echo "Servers file not found: $servers_file"
  exit 1
fi

# Loop through each server and perform the copy
for server in "${servers[@]}"; do
  # Check if the folder exists on the server
  folder_exists=$(ssh "$server" "[ -d \"$destination_folder\" ]" && echo "true" || echo "false")

  if [ "$folder_exists" = "false" ]; then
    # Copy the folder to the server
    scp -r "$source_folder" "$server":"$destination_folder"
    echo "Folder copied to $server"
  else
    echo "Folder already exists on $server"
  fi
done
