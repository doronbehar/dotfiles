#!/usr/bin/awk -f

BEGIN{
	FS=" # |context.|="
}
{
	if ($0 ~ /^context./ && $4 != "") {
		CONTEXT=$2
		for (i = 4; i <= NF; i++) {
			sub(/\~/, ENVIRON["HOME"],$i)
			if (ENVIRON["PWD"] == $i) {
				system("task context "CONTEXT)
				exit_invoked=1
				exit(0)
			}
		}
	}
}
END{
	if ( ! exit_invoked ) {
		exit(1)
	}
}
