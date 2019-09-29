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

Known Issues:
- Cocoon of Evolution, which has a complicated filter function that checks a group called "g2", tricks the parser and returns the "2" in "g2" instead of the card's ID at the end of the function (however the ID is also listed elsewhere in the script, and no card will ever have the ID "2").
- Magic Formula contains a Filter Function for IsCode that lists 2 codes, the parser can only find 1.