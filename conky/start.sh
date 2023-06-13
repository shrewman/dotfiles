cd $(dirname $0)
killall conky 2>/dev/null

pause="--pause=2"

case $1 in
	-f|--full)
		conky --daemonize --quiet "$pause" --config=./system.conf
	;;
	-s|--short)
		conky --daemonize --quiet "$pause" --config=./system-short.conf
	;;
	-t|--todo)
		conky --daemonize --quiet "$pause" --config=./system-short.conf & \
		conky --daemonize --quiet "$pause" --config=./todo.conf   
	;;
    -k|--kill)
		killall conky 2>/dev/null
	;;
	*)
		echo "Available arguments:
		-f, --full:  detailed system information
		-s, --short: short system information
		-t, --todo:  display todo file
		-k, --kill:  kill all conky instances"
		exit 1
	;;
esac
