#!/bin/sh
clear

if [ $2 ]; then
	FILENAME="$2"
	SAVE_FILENAME="crt_save_$2"
else
	FILENAME="crt.c"
	SAVE_FILENAME="crt_save.c"
fi

echo > "$FILENAME"
echo '#include <stdio.h>\n#include <math.h>\n#include <stdlib.h>\n\nint main(int argc, char** argv)\n{' >> "$FILENAME"

load()
{
	if [ "$1" = "l" ]; then
		cat "$SAVE_FILENAME" > "$FILENAME"
		sed '$d' < "$FILENAME" > tmp_crt.c ; mv tmp_crt.c "$FILENAME"  #Delete last two lines (return and "}")
		sed '$d' < "$FILENAME" > tmp_crt.c ; mv tmp_crt.c "$FILENAME"  #Delete last two lines (return and "}")
		rm temp_crt.c
	fi
}

save()
{
	if [ "$1" = "s" ] || [ "$1" = "l" ]; then
		cat "$FILENAME" > "$SAVE_FILENAME"
		echo '    return 0;' >> "$SAVE_FILENAME"
		echo '}' >> "$SAVE_FILENAME"
		load "s"
	fi
}

run()
{
	echo "Running program..."
	gcc "$FILENAME" -o crt_run_file
	./crt_run_file  
	sed '$d' < "$FILENAME" > tmp_crt.c ; mv tmp_crt.c "$FILENAME"  #Delete last two lines (return and "}")
	sed '$d' < "$FILENAME" > tmp_crt.c ; mv tmp_crt.c "$FILENAME"  #Delete last two lines (return and "}")  
	echo
}

print_header()
{
	clear
	echo "***crt - C in real time***" 
	echo "[d to delete last line, c to clear all, r to run, q to quit,"
	echo "s to save, l to load, n to save under new filename," 
	echo "i to insert line, # to replace line.]"
	echo
	cat -n "$FILENAME"
	echo	
}

clean_up()
{
	rm crt.c
	rm crt_run_file
}

load "$1"

while :
do
	print_header
	echo "Next line:"
	read INPUT
	if [ "$INPUT" -eq "$INPUT" ] 2>/dev/null; then
		print_header
		echo "Replace line $INPUT with:"
		read REPLACE_LINE
		sed -i "$INPUT c\    $REPLACE_LINE" "$FILENAME"
		continue
	fi
	if [ "$INPUT" = "i" ]; then
		print_header
		echo "Where will you insert your line?"
		read INSERT_LINE
		echo "Type line to insert:"
		read REPLACE_LINE
		sed -i "$INSERT_LINE a\    $REPLACE_LINE" "$FILENAME"
		continue
	fi
	if [ "$INPUT" = "s" ]; then
		save "s"
		continue
	fi
	if [ "$INPUT" = "n" ]; then
		echo "Save as..."
		read SAVE_FILENAME
		save "s"
		continue
	fi
	if [ "$INPUT" = "l" ]; then
		load "l"
		continue
	fi
	if [ "$INPUT" = "q" ]; then
		save "$1"
		clean_up
		break
	fi
	if [ "$INPUT" = "d" ]; then
		sed '$d' < "$FILENAME" > tmp_crt.c ; mv tmp_crt.c "$FILENAME"
		rm tmp_crt.c
		continue
	fi
	if [ "$INPUT" = "c" ]; then
		echo > "$FILENAME"
		echo '#include <stdio.h>\n#include <math.h>\n#include <stdlib.h>\n\nint main(int argc, char** argv)\n{' >> "$FILENAME"
		continue
	fi
	if [ "$INPUT" = "r" ]; then
		echo '    return 0;' >> "$FILENAME"
		echo '}' >> "$FILENAME"
		clear
		cat -n "$FILENAME"
		echo
		save "$1"
		run
		echo
		echo "**Continue...**"
		read CONTINUE


		else
			echo "    $INPUT" >> "$FILENAME"
			hi
    fi
done 



