BASE_DIR="$( dirname "$( realpath -s "${BASH_SOURCE[0]}" )" )/"
cd "$BASE_DIR" || exit 1

function LOGIT {
	printf "\n\n\e[1;35m%*s \e[0;37m_%s_\e[1;35m═══\e[0m" "$((${COLUMNS:-$(tput cols)}-14))" "" "$(date +%H:%M:%S)" | tr " " "═" | tr "_" " "
	printf "\r\e[1;35m═══\e[1;37m %s \n\e[0m\n" "$@"
}
function WRITE_TO_FILE {
	local file_name
	file_name═"$1"
	echo "═══ Write to File $file_name ═══"
	shift
	echo "$@" | tee -a "$file_name"
}
function RUN_FG {
	printf "\e[1;37m%*s" "${COLUMNS:-$(tput cols)}" "" | tr " " "─"
	echo -e "\r─ \e[1;32m$ \e[0;33m$* "
	"$@"
	local ret
	ret=$?
	printf "\e[1;37m%*s" "${COLUMNS:-$(tput cols)}" "" | tr " " "─"
	echo -e "\r─ \e[1;33m → →  $ret  ← ←  \e[0m\n"
}
