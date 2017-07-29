#!/system/bin/sh

BB=/sbin/busybox;

# Remount root and system read/write
mount -t rootfs -o remount,rw rootfs
mount -o remount,rw /system
mount -o remount,rw /data

#
# Stop Google Service and restart it on boot (dorimanx)
# This removes high CPU load and ram leak!
#
if [ "$($BB pidof com.google.android.gms | wc -l)" -eq "1" ]; then
	$BB kill $($BB pidof com.google.android.gms);
fi;
if [ "$($BB pidof com.google.android.gms.unstable | wc -l)" -eq "1" ]; then
	$BB kill $($BB pidof com.google.android.gms.unstable);
fi;
if [ "$($BB pidof com.google.android.gms.persistent | wc -l)" -eq "1" ]; then
	$BB kill $($BB pidof com.google.android.gms.persistent);
fi;
if [ "$($BB pidof com.google.android.gms.wearable | wc -l)" -eq "1" ]; then
	$BB kill $($BB pidof com.google.android.gms.wearable);
fi;

# Check for init.d folder and create it if it doesn't available
if [ ! -e /system/etc/init.d ] ; then
	mkdir /system/etc/init.d
	chown -R root.root /system/etc/init.d
	chmod -R 755 /system/etc/init.d
else
	chown -R root.root /system/etc/init.d
	chmod -R 755 /system/etc/init.d
fi

# Run init.d scripts
export PATH=${PATH}:/system/bin:/system/xbin
$BB run-parts /system/etc/init.d

chmod 777 /sbin/uci;
chmod 777 /res/synapse/;
chmod 777 /res/synapse/actions/;
chmod 644 /res/synapse/*;
chmod 644 /res/synapse/actions/*;
/sbin/uci

mount -o remount,rw -t auto /system;
chmod -R 777 /system/etc/init.d;
mount -o remount,ro -t auto /system;

sync
mount -t rootfs -o remount,ro rootfs
mount -o remount,ro /system

# Block Mdnie Hook

echo "Mdnie Executed" > /data/mdniehookblocked
touch /data/mdniehookblocked

# Block Hook Tweaks

echo 0 > /sys/class/misc/mdnie/hook_control/s_edge_enhancement
echo 1 > /sys/class/misc/mdnie/hook_control/s_edge_enhancement
chmod 777 /sys/class/misc/mdnie/hook_control/scr_black_blue
echo 0 > /sys/class/misc/mdnie/hook_control/scr_black_blue
chmod 444 /sys/class/misc/mdnie/hook_control/scr_black_blue
chmod 777 /sys/class/misc/mdnie/hook_control/scr_black_green
echo 0 > /sys/class/misc/mdnie/hook_control/scr_black_green
chmod 444 /sys/class/misc/mdnie/hook_control/scr_black_green
chmod 777 /sys/class/misc/mdnie/hook_control/scr_black_red
echo 0 > /sys/class/misc/mdnie/hook_control/scr_black_red
chmod 444 /sys/class/misc/mdnie/hook_control/scr_black_red
chmod 777 /sys/class/misc/mdnie/hook_control/scr_blue_blue
echo 255 > /sys/class/misc/mdnie/hook_control/scr_blue_blue
chmod 444 /sys/class/misc/mdnie/hook_control/scr_blue_blue
chmod 777 /sys/class/misc/mdnie/hook_control/scr_blue_green
echo 0 > /sys/class/misc/mdnie/hook_control/scr_blue_green
chmod 444 /sys/class/misc/mdnie/hook_control/scr_blue_green
chmod 777 /sys/class/misc/mdnie/hook_control/scr_blue_red
echo 0 > /sys/class/misc/mdnie/hook_control/scr_blue_red
chmod 444 /sys/class/misc/mdnie/hook_control/scr_blue_red
chmod 777 /sys/class/misc/mdnie/hook_control/scr_cyan_blue
echo 255 > /sys/class/misc/mdnie/hook_control/scr_cyan_blue
chmod 444 /sys/class/misc/mdnie/hook_control/scr_cyan_blue
chmod 777 /sys/class/misc/mdnie/hook_control/scr_cyan_green
echo 240 > /sys/class/misc/mdnie/hook_control/scr_cyan_green
chmod 444 /sys/class/misc/mdnie/hook_control/scr_cyan_green
chmod 777 /sys/class/misc/mdnie/hook_control/scr_cyan_red
echo 42 > /sys/class/misc/mdnie/hook_control/scr_cyan_red
chmod 444 /sys/class/misc/mdnie/hook_control/scr_cyan_red
chmod 777 /sys/class/misc/mdnie/hook_control/scr_green_blue
echo 0 > /sys/class/misc/mdnie/hook_control/scr_green_blue
chmod 444 /sys/class/misc/mdnie/hook_control/scr_green_blue
chmod 777 /sys/class/misc/mdnie/hook_control/scr_green_green
echo 245 > /sys/class/misc/mdnie/hook_control/scr_green_green
chmod 444 /sys/class/misc/mdnie/hook_control/scr_green_green
chmod 777 /sys/class/misc/mdnie/hook_control/scr_green_red
echo 64 > /sys/class/misc/mdnie/hook_control/scr_green_red
chmod 444 /sys/class/misc/mdnie/hook_control/scr_green_red
chmod 777 /sys/class/misc/mdnie/hook_control/scr_magenta_blue
echo 255 > /sys/class/misc/mdnie/hook_control/scr_magenta_blue
chmod 444 /sys/class/misc/mdnie/hook_control/scr_magenta_blue
chmod 777 /sys/class/misc/mdnie/hook_control/scr_magenta_green
echo 20 > /sys/class/misc/mdnie/hook_control/scr_magenta_green
chmod 444 /sys/class/misc/mdnie/hook_control/scr_magenta_green
chmod 777 /sys/class/misc/mdnie/hook_control/scr_magenta_red
echo 255 > /sys/class/misc/mdnie/hook_control/scr_magenta_red
chmod 444 /sys/class/misc/mdnie/hook_control/scr_magenta_red
chmod 777 /sys/class/misc/mdnie/hook_control/scr_red_blue
echo 0 > /sys/class/misc/mdnie/hook_control/scr_red_blue
chmod 444 /sys/class/misc/mdnie/hook_control/scr_red_blue
chmod 777 /sys/class/misc/mdnie/hook_control/scr_red_green
echo 17 > /sys/class/misc/mdnie/hook_control/scr_red_green
chmod 444 /sys/class/misc/mdnie/hook_control/scr_red_green
chmod 777 /sys/class/misc/mdnie/hook_control/scr_red_red
echo 247 > /sys/class/misc/mdnie/hook_control/scr_red_red
chmod 444 /sys/class/misc/mdnie/hook_control/scr_red_red
chmod 777 /sys/class/misc/mdnie/hook_control/scr_white_blue
echo 246 > /sys/class/misc/mdnie/hook_control/scr_white_blue
chmod 444 /sys/class/misc/mdnie/hook_control/scr_white_blue
chmod 777 /sys/class/misc/mdnie/hook_control/scr_white_green
echo 245 > /sys/class/misc/mdnie/hook_control/scr_white_green
chmod 444 /sys/class/misc/mdnie/hook_control/scr_white_green
chmod 777 /sys/class/misc/mdnie/hook_control/scr_white_red
echo 255 > /sys/class/misc/mdnie/hook_control/scr_white_red
chmod 444 /sys/class/misc/mdnie/hook_control/scr_white_red
chmod 777 /sys/class/misc/mdnie/hook_control/scr_yellow_blue
echo 8 > /sys/class/misc/mdnie/hook_control/scr_yellow_blue
chmod 444 /sys/class/misc/mdnie/hook_control/scr_yellow_blue
chmod 777 /sys/class/misc/mdnie/hook_control/scr_yellow_green
echo 241 > /sys/class/misc/mdnie/hook_control/scr_yellow_green
chmod 444 /sys/class/misc/mdnie/hook_control/scr_yellow_green
chmod 777 /sys/class/misc/mdnie/hook_control/scr_yellow_red
echo 255 > /sys/class/misc/mdnie/hook_control/scr_yellow_red
chmod 444 /sys/class/misc/mdnie/hook_control/scr_yellow_red

#
# Set correct r/w permissions for LMK parameters
#

chmod 666 /sys/module/lowmemorykiller/parameters/cost;
chmod 666 /sys/module/lowmemorykiller/parameters/adj;
chmod 666 /sys/module/lowmemorykiller/parameters/minfree;

#
# We need faster I/O so do not try to force moving to other CPU cores (dorimanx)
#
for i in /sys/block/*/queue; do
        echo "2" > $i/rq_affinity
done

#
# Allow untrusted apps to read from debugfs (mitigate SELinux denials)
#
/system/xbin/supolicy --live \
	"allow untrusted_app debugfs file { open read getattr }" \
	"allow untrusted_app sysfs_lowmemorykiller file { open read getattr }" \
	"allow untrusted_app sysfs_devices_system_iosched file { open read getattr }" \
	"allow untrusted_app persist_file dir { open read getattr }" \
	"allow debuggerd gpu_device chr_file { open read getattr }" \
	"allow netd netd capability fsetid" \
	"allow netd { hostapd dnsmasq } process fork" \
	"allow { system_app shell } dalvikcache_data_file file write" \
	"allow { zygote mediaserver bootanim appdomain }  theme_data_file dir { search r_file_perms r_dir_perms }" \
	"allow { zygote mediaserver bootanim appdomain }  theme_data_file file { r_file_perms r_dir_perms }" \
	"allow system_server { rootfs resourcecache_data_file } dir { open read write getattr add_name setattr create remove_name rmdir unlink link }" \
	"allow system_server resourcecache_data_file file { open read write getattr add_name setattr create remove_name unlink link }" \
	"allow system_server dex2oat_exec file rx_file_perms" \
	"allow mediaserver mediaserver_tmpfs file execute" \
	"allow drmserver theme_data_file file r_file_perms" \
	"allow zygote system_file file write" \
	"allow atfwd property_socket sock_file write" \
	"allow untrusted_app sysfs_display file { open read write getattr add_name setattr remove_name }" \
	"allow debuggerd app_data_file dir search" \
	"allow sensors diag_device chr_file { read write open ioctl }" \
	"allow sensors sensors capability net_raw" \
	"allow init kernel security setenforce" \
	"allow netmgrd netmgrd netlink_xfrm_socket nlmsg_write" \
	"allow netmgrd netmgrd socket { read write open ioctl }"

# Google play services wakelock fix
sleep 40
su -c "pm enable com.google.android.gms/.update.SystemUpdateActivity"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$Receiver"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateActivity"
su -c "pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver"

cortexbrain_background_process=$(cat /res/synapse/sp/cortexbrain_background_process);
if [ "$cortexbrain_background_process" == "1" ]; then
	sleep 30
	$BB nohup $BB sh /sbin/cortexbrain-tune.sh > /dev/null 2>&1 &
fi;

cron_master=$(cat /res/synapse/sp/cron_master);
if [ "$cron_master" == "1" ];then
	$BB nohup $BB sh /res/crontab_service/service.sh 2> /dev/null;
fi;
0
