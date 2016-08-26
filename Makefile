munin:
    cp sys/munin/munin-cron.service /etc/systemd/system/
    cp sys/munin/munin-cron.timer /etc/systemd/system/
    cp sys/munin/munin.conf /etc/munin/
	cp sys/munin/munin-node /etc/munin/plugin-conf.d/
