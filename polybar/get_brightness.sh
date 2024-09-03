
#!/bin/bash

# Get the current brightness level using brightnessctl
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)

# Calculate the brightness percentage
brightness_percentage=$(echo "$brightness * 100 / $max_brightness" | bc)

# Display the brightness percentage
echo "$brightness_percentage%"
