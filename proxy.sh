#/usr/bin/env bash


PROXY_HOST="192.168.0.11"
PROXY_PORT="3128"
PROXY_USER=""
PROXY_PASS=""
PROXY_USER_ACCOUNT=""


ERROR_MSG="Error: proxy.sh on/off [--disable-git] [--disable-apt]"



function configure_git_proxy
{
	echo "TODO"
}

function configure_sys_proxy
{
	export HTTP_PROXY=$PROXY_STRING	
	export HTTPS_PROXY=$PROXY_STRING
	export FTP_PROXY=$PROXY_STRING
}

function remove_sys_proxy
{
	unset HTTP_PROXY
	unset HTTPS_PROXY
	unset FTP_PROXY
}

function configure_gnome_proxy
{
	gsettings set org.gnome.system.proxy mode 'manual';
	gsettings set org.gnome.system.proxy.http host "'$PROXY_HOST'";
	gsettings set org.gnome.system.proxy.http port "$PROXY_PORT";
	gsettings set org.gnome.system.proxy.https host "'$PROXY_HOST'";
	gsettings set org.gnome.system.proxy.https port "$PROXY_PORT";
	gsettings set org.gnome.system.proxy.ftp host "'$PROXY_HOST'";
	gsettings set org.gnome.system.proxy.ftp port "$PROXY_PORT";
}

function remove_gnome_proxy
{
	gsettings set org.gnome.system.proxy mode 'auto';
        gsettings set org.gnome.system.proxy.http host "''";
        gsettings set org.gnome.system.proxy.http port "8081";
        gsettings set org.gnome.system.proxy.https host "''";
        gsettings set org.gnome.system.proxy.https port "8081";
        gsettings set org.gnome.system.proxy.ftp host "''";
        gsettings set org.gnome.system.proxy.ftp port "8081";
}


function configure_apt_proxy
{
	APT_PROXY_CONF="
	Acquire::http::Proxy \"$PROXY_STRING\";
	Acquire::https:Proxy \"$PROXY_STRING\";
	Acquire::ftp::Proxy \"$PROXY_STRING\";
	"
	echo "$APT_PROXY_CONF" | sudo tee /etc/apt/apt.conf.d/proxy.conf > /dev/null
}

function remove_apt_proxy 
{
	sudo rm /etc/apt/apt.conf.d/proxy.conf > /dev/null
}

function print_help
{
	echo $ERROR_MSG
	echo "All proxy configurations are activated by default"
}


if [ $# == 0 ]
then
	print_help
else
	if [ $1 == "on" ]
	then
		if [ ! -z "$PROXY_USER" ] && [ ! -z "$PROXY_PASS" ]
		then
			PROXY_USER_ACCOUNT="$PROXY_USER:$PROXY_PASS@"
		fi
		PROXY_STRING="http://$PROXY_USER_ACCOUNT$PROXY_HOST:$PROXY_PORT/"
	
		# TODO disable flags
		configure_sys_proxy
		configure_gnome_proxy
		configure_apt_proxy
	elif [ $1 == "off" ]
	then
		remove_sys_proxy
		remove_apt_proxy
		remove_gnome_proxy
	else
		print_help
	fi

fi
