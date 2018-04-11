#!/usr/bin/awk -f

BEGIN{
	FS=" # |context.|="
}
{
	if ($0 ~ /^context./ && $4 != "") {
		CONTEXT=$2
		for (i = 4; i <= NF; i++) {
			gsub(/\~/, ENVIRON["HOME"], $i)
			split($i, directories, " ")
			for (d in directories) {
				if (directories[d] ~ /\*/) {
					if (ENVIRON["PWD"] ~ directories[d]) {
						print CONTEXT
						exit_invoked=1
						exit(0)
					}
				} else {
					if (ENVIRON["PWD"] == directories[d]) {
						print CONTEXT
						exit_invoked=1
						exit(0)
					}
				}
			}
		}
	}
}
END{
	if ( ! exit_invoked ) {
		exit(1)
	}
}
