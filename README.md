# crt - C in real time

A simple bash script for testing out small C programs interactively.

## Instructions

The program automatically begins with a basic template.
When you run or save your file, the program will add 
return 0 and a closing } at the end of the file.  Do not
add these yourself.

At present, any functions must be defined within main(). 

You can specify a filename as a command-line parameter.
Saving will save to that file.

Commands:
* d - delete last line<br> 
* c - clear all <br>
* r - run <br>
* q - quit <br>
* s - save <br> 
* l - load <br>
* n - save under new filename <br>
* i - insert line <br>
* line# - replace line <br>
* p - quick printf (enter format without "%") <br>