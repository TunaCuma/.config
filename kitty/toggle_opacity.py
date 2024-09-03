#!/usr/bin/env python3

from typing import List
from kitty.boss import Boss

def main(args: List[str]) -> str:
    pass

from kittens.tui.handler import result_handler


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss): 
    import kitty.fast_data_types as f
    os_window_id = f.current_focused_os_window_id()
    current_opacity = f.background_opacity_of(os_window_id)

    # Define the opacity levels to toggle between
    opaque = 1.0
    transparent = 0.75
    
    # Toggle the opacity
    new_opacity = transparent if current_opacity == opaque else opaque
    
    # Convert the float to a string (if necessary)
    new_opacity_str = str(new_opacity)
    
    # Apply the new opacity as a string
    boss.set_background_opacity(new_opacity_str)

