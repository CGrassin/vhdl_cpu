#   ___  _          _    ___  __  __ 
#  / __|| |   ___  /_\  / __||  \/  |
# | (__ | |__|___|/ _ \ \__ \| |\/| |
#  \___||____|   /_/ \_\|___/|_|  |_|
#                  ---
#              Version 1.1
# 
# Assembler for the VHDL processor project.

# Usage : awk -f CGASM.AWK [-v verbose=<0/1>] file.clasm
# Features : Support CL-ASM assembly language with labels and variables
# Limitation : can only assemble one file at a time

#Trim leading spaces
function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }

# Print an error message and set error bit
function error(message){
	printf("[Line: %d] Error : %s\n",NR,message);
	error_happened = 1;
}

# Convert a decimal/binary value to 8 bits binary string
function bits2str(bits,			__data)
{
	#If arg is missing
    if (bits == "")
        error("Missing mandatory arg for instruction");

    #BINARY
    if (bits ~ /^B/){
    	if (!(bits ~ /^B[01]*$/))
    		error("Invalid caracter found in \"" bits "\" (expecting only 0's and 1's)");

    	if (length(bits)!=9)
    		error("Invalid size for \"" bits "\" (expecting 8 bits, read " length(bits)-1 ")");
    	
    	__data = substr(bits, 2, 8);
    }
    #DECIMAL
    else {
    	if (!(bits ~ /^[0-9]*$/))
    		error("Invalid caracter found in \"" bits "\" (expecting numbers)");

    	for (; bits != 0; bits = rshift(bits, 1))
	    	__data = (and(bits, 1) ? "1" : "0") __data

	    # Check if length > 8 bits (orverflow)
	    if (length(__data)>8) 
	    	error("Value > 255, overflow detected");

	    # Fill MSBs with 'O'
	    while (length(__data)<8)
	        __data = "0" __data
    }

	return __data
}

# Get "ResSel" OP field from the instruction name
function getReg(instruction,		__reg){
	split(instruction,arg,".");

	if (arg[2] == "") 
		error("Missing register name in command \""instruction"\"");

	if (arg[2] == "0")
		__reg = "01"
	else if (arg[2] == "1")
		__reg = "10"
	else
		error("Invalid ResSel \""arg[2]"\" for \""instruction"\"");

	return __reg
}

#Function to print result. Verbose print more info
function printOP(code,instruction){
	if (verbose)
		program = program NR ":\t"code " -> " instruction "\n";
	else
		program = program code "\n";

}

#Specific function to handle goto arg
function gotoArg(arg){
	if (arg ~ /[a-ZA-Z0-9_]*/)
		return "#" arg "#"
	else
		return bits2str(arg)
}

# Function launched once 
BEGIN{
	# Parameter : verbose. Default : OFF.
	if (verbose=="") verbose = 0;

	# Ignore caase in regex
	IGNORECASE = 1;
	
	# OPCode values
	OPCODE["NOP"]		=	"00000" ;
	OPCODE["GET"]		=	"00001" ;
	OPCODE["SET"]		=	"00010" ;
	OPCODE["SETL"]		=	"00011" ;
	OPCODE["GOTO"]		=	"00110" ;
	OPCODE["GOTOIFNULL"]=	"0010" ;
	OPCODE["ADD"]		=	"00111" ;
	OPCODE["SUB"]		=	"01100" ;
	OPCODE["AND"]		=	"01101" ;
	OPCODE["OR"]		=	"01110" ;
	OPCODE["INC"]		=	"0100" ;
	OPCODE["DEC"]		=	"0101" ;

	# Program variables (declared for readbility)
	error_happened = 0;
	program = "";
	emptylines = 0;
}

#Function called each line
{
	#Trim leading spaces
	$0 = ltrim($0);

	# Remove comments
	gsub(/;.*/, "", $0);

	#-------Nothing-------
	if($0 == ""){
		emptylines++;
		next;
	#--------NOP----------
	} else if ($0 ~ /^NOP$/){
		printOP(OPCODE["NOP"] "0" "00" "00000000",$0);
	#--------SET----------
	} else if ($0 ~ /^Set\./){
		reg = getReg($1)
		printOP(OPCODE["SET"] "0" reg bits2str($2),$0);
	#--------SETL----------
	} else if ($0 ~ /^SetL\./){
		reg = getReg($1)
		printOP(OPCODE["SETL"] "0" reg bits2str($2),$0);
	#--------GET----------
	} else if ($0 ~ /^Get\./){
		split($1,arg,".");
		if(arg[2] != "0" && arg[2] != "1") 
			error("Invalid OutSel \""arg[2]"\" for \""$0"\"");
		printOP(OPCODE["GET"] arg[2] "00" bits2str($2),$0);
	#--------GOTO----------
	}  else if ($0 ~ /^GoTo /){
		printOP(OPCODE["GOTO"] "0" "00" gotoArg($2),$0);
	#--------GOTOIFNULL----------
	}  else if ($0 ~ /^GOTOIFNULL\./){
		# error("Not implemented");
		split($1,arg,".");
		if(arg[2] != "0" && arg[2] != "1") 
			error("Invalid register \""arg[2]"\" for \""$0"\"");
		printOP(OPCODE["GOTOIFNULL"] arg[2] "0" "00" gotoArg($2),$0);
	#--------Add----------
	}  else if ($0 ~ /^Add\./){
		reg = getReg($1);
		printOP(OPCODE["ADD"] "0" reg "00000000",$0);
	#--------Sub----------
	}  else if ($0 ~ /^Sub\./){
		reg = getReg($1);
		printOP(OPCODE["SUB"] "0" reg "00000000",$0);
	#--------AND----------
	}  else if ($0 ~ /^And\./){
		reg = getReg($1);
		printOP(OPCODE["AND"] "0" reg "00000000",$0);
	#--------OR----------
	}  else if ($0 ~ /^Or\./){
		reg = getReg($1);
		printOP(OPCODE["OR"] "0" reg "00000000",$0);
	#--------INC----------
	}  else if ($0 ~ /^INC\./){
		# error("Not implemented");
		reg = getReg($1);
		split($1,arg,".");
		if(arg[2] != "0" && arg[2] != "1") 
			error("Invalid register \""arg[2]"\" for \""$0"\"");
		printOP(OPCODE["INC"] arg[2] "0" reg "00000000", $0 );
	#--------DEC----------
	}  else if ($0 ~ /^DEC\./){
		# error("Not implemented");
		reg = getReg($1);
		split($1,arg,".");
		if(arg[2] != "0" && arg[2] != "1") 
			error("Invalid register \""arg[2]"\" for \""$0"\"");
		printOP(OPCODE["DEC"] arg[2] "0" reg "00000000", $0 );
	#--------Variable----------
	} else if ($0 ~ /^[B]?[0-9]+$/){
		printOP("00000000" bits2str($0),$0);
	#--------Label----------
	} else if ($0 ~ /^[a-ZA-Z0-9_]*:$/){
		# Discard the ":"
		sub(":","",$0);

		#Check for label existence
		if (labels[$0]!="")
			error("Multiple definitions for label \"" $0 "\"")

		#Store the address in the array
		labels[$0]= NR-1-emptylines;
		emptylines ++;
	#--------ERROR----------
	}else 
		error("Unkown expression \""$0"\" (maybe missing \".\" ?)");
}

END{
	# Replacement of labels by their address
	for (i in labels) 
		gsub("#"i"#",bits2str(labels[i]),program);

	# Check if there are still labels
	if( ! (program ~ /^[01\n]*$/) && verbose = false)
		error("One or more goto label(s) are used but undefined");

	#Finally, write program
	if (error_happened) printf("\nFailed to assemble program. Check error log.\n\n");
	else {
		# printf("\nSuccessfully assembled program \"" FILENAME "\" !\n\n");
		printf(program);
	}
}