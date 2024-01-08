finfs () 
(
	: finfs keyword '*.R'
	: will find keyword in all .R files at current dir
	: then print them.
	
	find . -name "${2:-*.*}" -type f | 
		xargs -i -P0 -- sh -c 'echo ":::::::: {} ::: $(cat -n -- {} | fgrep '"'$1'"' -- -)"' | 
		fgrep "$1" | 
		sed s'/ ::: / ::: \n/' &&
  
  : )
