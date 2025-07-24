#!/bin/bash

# Read lines from input or a file
while IFS= read -r line; do
  # Extract the ID - match "C" followed by digits and optional letters in src or alt
  id=$(echo "$line" | grep -oE "C[0-9A-Z]+" | head -1)

  # Extract the src URL
  src=$(echo "$line" | grep -oE "src='[^']+'" | head -1 | cut -d"'" -f2)
  
  # Convert full URL to relative path by removing domain prefix
  rel_src=${src#https://www.bomcondutor.pt}

  # Extract the alt text
  alt=$(echo "$line" | grep -oE "alt='[^']+'" | head -1 | cut -d"'" -f2)

  # Extract the description HTML after </td> <td>
  desc=$(echo "$line" | sed -E "s/^.*<\/td> <td>//")

  # Clean the trailing semicolon after img if any
  img_tag="<img src=\"$rel_src\" alt=\"$alt\" width=\"100px\">"

  # Print the formatted row
  echo "<tr id=\"$id\">"
  echo "  <td>$img_tag</td>"
  echo "  <td>$desc</td>"
  echo "</tr>"
done
