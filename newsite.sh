#!/bin/bash
 
VHOSTS_DIR='/Applications/MAMP/conf/apache/vhosts'
HOSTS_FILE='/etc/hosts'
HTDOCS_DIR='/Applications/MAMP/htdocs'
 
if [ -z $1 ]; then
	echo "No domain name given"
	exit 1
fi
DOMAIN=$1
 
# Check if the domain is valid
PATTERN="^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$";
if [[ "$DOMAIN" =~ $PATTERN ]]; then
	DOMAIN=`echo $DOMAIN | tr '[A-Z]' '[a-z]'`
	echo "Adding new site:" $DOMAIN
else
	echo "Invalid domain name"
	exit 1
fi
 
# Copy & modify the vhost template
CONFIG=$VHOSTS_DIR/$DOMAIN.conf
sudo cp $VHOSTS_DIR/_template.conf $CONFIG
sudo sed -i.tmp "s/DOMAIN/$DOMAIN/g" $CONFIG
sudo rm $CONFIG.tmp

# Add the new domain names to the hosts file
sudo sh -c "echo '127.0.0.1\t\twww.$DOMAIN.dev\n127.0.0.1\t\t$DOMAIN.dev' >> $HOSTS_FILE"

# Restarting apache
sudo /usr/sbin/apachectl restart
 
# Add index file
WEB_ROOT="$HTDOCS_DIR/www.$DOMAIN/"
mkdir $WEB_ROOT
cp -r $HTDOCS_DIR/_default/* $WEB_ROOT/


echo -e "\nSite created for $DOMAIN"
echo "--------------------------"
echo "Host: "`hostname`
echo "URL: www.$DOMAIN.dev"
echo "--------------------------"
exit 0;