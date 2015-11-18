#!/bin/bash

function restart {
	printf "\n"
	printf "Press Enter to continue..."
	read
	clear
}

selection=
until [ "$selection" = "0" ]; do
	printf "\nSelect from the menu: \n\n"
	printf "  1) VM Connection Test\n"
	printf "  2) List all Containers\n"
	printf "  3) List Running Containers\n"
	printf "  4) Inspect a Container\n"
	printf "  5) Delete a Container\n"
	printf "  6) Delete all Containers\n"
	printf "  7) Create a Container from an Image\n"
	printf "  8) Restart a Container\n"
	printf "  9) Stop a Container\n"
	printf " 10) Show Logs from a Container\n"
	printf " 11) List all Images\n"
	printf " 12) Delete an Image\n"
	printf " 13) Delete all Images\n"
	printf " 14) TAG an Image\n"
	printf " 15) Create Docker Images from Local Dockerfile\n"
	printf " \n 99) Exit\n"

	printf "\nSelection: "
	read selection

	case $selection in
		1  ) 	telnet snf-35274.vm.okeanos-global.grnet.gr 8181
			restart
			;;
		2  )   	curl -s -X GET -H 'Accept: application/json' http://localhost:8181/containers | python -mjson.tool
			restart
			;;
		3  ) 	curl -s -X GET -H 'Accept: application/json' http://localhost:8181/containers?state=running | python -mjson.tool
			restart
			;;
		4  ) 	curl -s -X GET -H 'Accept: application/json' http://localhost:8181/containers/bfe2305d5b31 | python -mjson.tool
			restart
			;;
		5  ) 	curl -s -X DELETE -H 'Accept: application/json' http://localhost:8181/containers/bfe2305d5b31 | python -mjson.tool
			restart
			;;
		6  ) 	curl -s -X DELETE -H 'Accept: application/json' http://localhost:8181/containersDel | python -mjson.tool
			restart
			;;
		7  ) 	curl -X POST -H 'Content-Type: application/json' http://localhost:8181/containers -d '{"image": "49b7d316bf66"}' | python -mjson.tool
			restart
			;;
		8  )	curl -X PATCH -H 'Content-Type: application/json' http://localhost:8181/containers/bfe2305d5b31 -d '{"state": "running"}'
			restart
			;;
		9  ) 	curl -X PATCH -H 'Content-Type: application/json' http://localhost:8181/containers/bfe2305d5b31 -d '{"state": "stopped"}'
			restart
			;;
		10 )	curl -s -X GET -H 'Accept: application/json' http://localhost:8181/containers/bfe2305d5b31/logs | python -mjson.tool
			restart
			;;
		11 )	curl -s -X GET -H 'Accept: application/json' http://localhost:8181/images | python -mjson.tool
			restart
			;;
		12 )	curl -s -X DELETE -H 'Accept: application/json' http://localhost:8181/images/imgID | python -mjson.tool
			restart
			;;
		13 )	curl -s -X DELETE -H 'Accept: application/json' http://localhost:8181/containersDel | python -mjson.tool
			restart
			;;
		14 )	curl -s -X PATCH -H 'Content-Type: application/json' http://localhost:8181/images/id -d '{"tag": "test:1.0"}'
			restart
			;;
		15 )	curl -H 'Accept: application/json' -F file=@Dockerfile http://localhost:8181/images | python -mjson.tool
			restart
			;;
		99) exit
			;;
		* ) printf "You did not choose a valid option!\n"
	esac
done

printf "\n"
