#！/bin/bash

# use:
#	  generate miniLinux
#     ./buildLinux nameOfMiniLinux
#
# 	  generate /boot/initramfs.img  
#     ./genRamfs.sh
#     

# @func : copy link lib
# linkLibDir : the dir to copy link lib  $1
# linkLibDrect : the dir to put link lib $2
function cpLinkLibrary(){
	for m in $(ls $1)
	do
		dependList=$( ldd $1/$m | awk '{if (match($3,"/")){ print $3}}' )
    cp $dependList $2
	done
}

# create dir
echo "mkdir all dir"
mkdir -p $1/boot
mkdir $1/dev
mkdir $1/mnt
mkdir $1/sys
mkdir $1/proc
mkdir $1/root

mkdir $1/bin
mkdir $1/sbin
mkdir $1/etc
mkdir $1/lib
mkdir $1/lib64
mkdir -p $1/usr/bin
mkdir -p $1/usr/sbin
mkdir -p $1/var/run


# cp bin
echo "copy /bin to $1/bin..."
cp /bin/ln /bin/sh /bin/login /bin/chown /bin/echo /bin/fgrep $1/bin/
cp /bin/ls /bin/mknod /bin/mount /bin/awk /bin/bash /bin/cat /bin/mkdir $1/bin/
#cp  /bin/hostname /bin/ls $1/bin/
# cp /bin lib
echo "copy $1/bin 's dynamic link library..."
cpLinkLibrary $1/bin $1/lib64/
# libtinfo.so.5

# cp sbin
echo "copy /sbin to $1/bin..."
cp /sbin/consoletype   /sbin/initctl /sbin/udevadm $1/sbin/
cp /sbin/mingetty /sbin/runlevel /sbin/udevd  $1/sbin/
cp /sbin/init /sbin/insmod /sbin/telinit /sbin/fstab-decode $1/sbin/
#cp /sbin/fsck.ext2 /sbin/fsck.ext3 /sbin/fsck.ext4 /sbin/fsck.ext4dev  \
#	/sbin/fsck.ext2 /sbin/fsck.ext3 /sbin/fsck.ext4 /sbin/fsck.ext4dev /sbin/fsck /sbin/modprobe  $1/sbin/
# cp /sbin lib
echo "copy $1/sbin 's dynamic link library..."
cpLinkLibrary $1/sbin $1/lib64/
cp /sbin/start_udev $1/sbin

#echo "usr/sbin usr/bin & dynamic link library"
# cp /usr/bin
#cp /usr/bin/passwd /usr/bin/strace $1/usr/bin/
# cp /usr/bin lib
#cpLinkLibrary $1/usr/bin $1/lib64/

# cp /usr/sbin
#cp /usr/sbin/chroot $1/usr/sbin/
# cp /usr/sbin lib
#cpLinkLibrary $1/usr/sbin $1/lib64/

# cp others
echo "copy other things~~~"
cp /lib64/ld-linux-x86-64.so.2 $1/lib64/
cp /lib64/libnss_* $1/lib64/
cp /lib64/libfreeblpriv3.so $1/lib64/

# cp etc subdir
echo "copy etc subdir ..."
cp -r /etc/udev $1/etc/
cp -r /etc/sysconfig $1/etc/
cp -r /etc/security $1/etc/
cp -r /etc/profile.d $1/etc/
cp -r /etc/pam.d $1/etc/
cp -r /etc/init.d $1/etc/
cp -r /etc/init $1/etc/
cp -r /etc/default $1/etc/
mkdir -p $1/etc/rc.d
cp -r /etc/rc.d/rc3.d $1/etc/rc.d
cp -r /etc/rc.d/init.d $1/etc/rc.d
cp -r /etc/rc.d/rc.local $1/etc/rc.d
cp -r /etc/rc.d/rc $1/etc/rc.d

echo "copy etc file ..."
cp /etc/shadow /etc/rc.sysinit /etc/rc /etc/profile /etc/passwd /etc/filesystems $1/etc/
cp /etc/inittab /etc/group /etc/fstab /etc/environment /etc/nsswitch.conf /etc/mtab $1/etc/
# cp /etc/login.defs /etc/ld.so.conf /etc/ld.so.cache /etc/hosts $1/etc/

echo "copy lib subdir..."
# cp lib subDir
mkdir -p $1/lib/udev
cp /lib/udev/fstab_import $1/lib/udev/

echo "copy lib64 subdir..."
# cp lib64 subDir
cp -r /lib64/security $1/lib64/
rm -rf $1/lib64/security/pam_filter
cpLinkLibrary $1/lib64/security $1/lib64/
cp -r /lib64/security/pam_filter $1/lib64/security/


# cp driver
echo "copy disk  driver..."
mkdir -p $1/lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/
cp /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/mptspi.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/
cp /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/mptbase.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/
cp /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/mptscsih.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/

mkdir -p $1/lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/scsi/
cp /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/scsi/scsi_transport_spi.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/scsi/
cp /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/scsi/sd_mod.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/scsi/

mkdir -p $1/lib/modules/2.6.32-696.el6.x86_64/kernel/lib/
cp  /lib/modules/2.6.32-696.el6.x86_64/kernel/lib/crc-t10dif.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/lib/

echo "copy filesystems  driver..."
mkdir -p $1/lib/modules/2.6.32-696.el6.x86_64/kernel/fs/
cp /lib/modules/2.6.32-696.el6.x86_64/kernel/fs/mbcache.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/fs/
mkdir -p $1/lib/modules/2.6.32-696.el6.x86_64/kernel/fs/jbd2/
cp /lib/modules/2.6.32-696.el6.x86_64/kernel/fs/jbd2/jbd2.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/fs/jbd2/
mkdir -p $1/lib/modules/2.6.32-696.el6.x86_64/kernel/fs/ext4/
cp /lib/modules/2.6.32-696.el6.x86_64/kernel/fs/ext4/ext4.ko $1/lib/modules/2.6.32-696.el6.x86_64/kernel/fs/ext4/


# create init
echo "create init~"
touch $1/init
echo "#!/bin/bash" >> $1/init
echo "" >> $1/init
echo "export PATH=/sbin:/bin:/usr/sbin:/usr/bin" >> $1/init
echo "" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/scsi/scsi_transport_spi.ko" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/mptbase.ko" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/mptscsih.ko" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/message/fusion/mptspi.ko" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/lib/crc-t10dif.ko" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/drivers/scsi/sd_mod.ko" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/fs/mbcache.ko" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/fs/jbd2/jbd2.ko" >> $1/init
echo "insmod /lib/modules/2.6.32-696.el6.x86_64/kernel/fs/ext4/ext4.ko" >> $1/init
echo "" >> $1/init
echo "mount -t proc proc /proc > /dev/null 2>&1" >> $1/init
echo "mount -t sysfs sysfs /sys > /dev/null 2>&1" >> $1/init
echo "" >> $1/init
echo "/sbin/start_udev" >> $1/init
echo "mount /dev/sda1 /mnt" >> $1/init
echo "#/bin/bash" >> $1/init
echo "exec /sbin/init" >> $1/init
chmod a+x $1/init

# create genRamfs
echo "create genRamfs.sh~"
touch $1/genRamfs.sh
echo "find . | cpio -H newc -o | gzip > /boot/initramfs.img" >> $1/genRamfs.sh
chmod a+x $1/genRamfs.sh

# create etc/environment
echo "create etc/environment~"
echo "LANG=en_US.utf-8" >> $1/etc/environment
echo "LC_ALL=" >> $1/etc/environment