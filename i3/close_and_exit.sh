#!/bin/bash
# Close all windows
i3-msg '[class=".*"] kill'
# Wait a moment to ensure all windows are closed
sleep 0.5
# Exit i3
i3-msg exit
