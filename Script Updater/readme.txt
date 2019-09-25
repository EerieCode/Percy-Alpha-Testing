YGOPro Percy Script Moderniser
by AlphaKretin, November 2018
Applies modern script standard updates to YGOPro card script files.
Usage:
Create a "script" folder with the card scripts you want to update.
Create an empty "newscript" folder for the output.
Run the script outside the folders using NodeJS. It has no dependencies, but fairly recent features.
You can edit the expected names of the folders in constants around line 215-220ish.

Updates applied by this script
- GetID()
- Renamed functions, new constants and other find-replace jobs, including RegisterEffect flags
- # for Group Size
- Lua 5.3 Bitwise operators
- Listed names
- Listed setcodes
