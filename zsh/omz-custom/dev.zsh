#
# shortcuts for development
#

# logs
alias authlog='tail -F /jails/alcatraz/usr/local/www-conf/logs/auth-phplog'
alias deliverylog='tail -F /jails/alcatraz/usr/local/www-conf/logs/delivery-phplog'
alias oarslog='tail -F /jails/alcatraz/usr/local/www-conf/logs/oars-phplog'
alias schoolslog='tail -F /jails/alcatraz/usr/local/www-conf/logs/schools-phplog'

# apps
alias cda='cd /jails/alcatraz/usr/local/www/auth'
alias cdd='cd /jails/alcatraz/usr/local/www/delivery'
alias cdo='cd /jails/alcatraz/usr/local/www/oars'
alias cds='cd /jails/alcatraz/usr/local/www/schools'
alias cd.='cd ~/dotfiles'

# db
alias migrate='li3 migration db:migrate'
alias sqlo='mysql -u oars -p'

## shortcuts for Jails setup
#alias guantanamo-start='env -i /usr/sbin/chroot /jails/guantanamo /usr/local/apache2/bin/httpd -k start'
#alias guantanamo-graceful='env -i /usr/sbin/chroot /jails/guantanamo /usr/local/apache2/bin/httpd -k graceful'
#alias guantanamo-stop='env -i /usr/sbin/chroot /jails/guantanamo /usr/local/apache2/bin/httpd -k stop'
#alias guantanamo-check='chroot /jails/guantanamo /usr/local/apache2/bin/apachectl -t'

#alias woomera-start='env -i /usr/sbin/chroot /jails/woomera /usr/local/apache2/bin/httpd -k start'
#alias woomera-graceful='env -i /usr/sbin/chroot /jails/woomera /usr/local/apache2/bin/httpd -k graceful'
#alias woomera-stop='env -i /usr/sbin/chroot /jails/woomera /usr/local/apache2/bin/httpd -k stop'
#alias woomera-check='chroot /jails/woomera /usr/local/apache2/bin/apachectl -t'

#alias littlehey-start='env -i /usr/sbin/chroot /jails/littlehey /usr/local/apache2/bin/httpd -k start'
#alias littlehey-graceful='env -i /usr/sbin/chroot /jails/littlehey /usr/local/apache2/bin/httpd -k graceful'
#alias littlehey-stop='env -i /usr/sbin/chroot /jails/littlehey /usr/local/apache2/bin/httpd -k stop'
#alias littlehey-check='chroot /jails/littlehey /usr/local/apache2/bin/apachectl -t'

#alias alcatraz-start='env -i /usr/sbin/chroot /jails/alcatraz /usr/local/apache2/bin/httpd -k start'
#alias alcatraz-graceful='env -i /usr/sbin/chroot /jails/alcatraz /usr/local/apache2/bin/httpd -k graceful'
#alias alcatraz-stop='env -i /usr/sbin/chroot /jails/alcatraz /usr/local/apache2/bin/httpd -k stop'
#alias alcatraz-check='chroot /jails/alcatraz /usr/local/apache2/bin/apachectl -t'

#alias kerobokan-start='env -i /usr/sbin/chroot /jails/kerobokan /usr/local/apache2/bin/httpd -k start'
#alias kerobokan-graceful='env -i /usr/sbin/chroot /jails/kerobokan /usr/local/apache2/bin/httpd -k graceful'
#alias kerobokan-stop='env -i /usr/sbin/chroot /jails/kerobokan /usr/local/apache2/bin/httpd -k stop'
#alias kerobokan-check='chroot /jails/kerobokan /usr/local/apache2/bin/apachectl -t'

#alias changi-start='/etc/init.d/tc-chroot start'
#alias changi-stop='/etc/init.d/tc-chroot stop'
