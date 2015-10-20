export hn=cadc01

export IMAGES=/var/lib/libvirt/images
export CONFIG_DRIVE=./CONFIG-DRIVE
export ISOs=./ISOs

mkisofs -R -V config-2 -o $ISOs/drive-ubuntu.iso $CONFIG_DRIVE

qemu-img create -f qcow2 -b $IMAGES/rhel-guest-image-6.6-20141222.0.x86_64.mv.qcow2 $IMAGES/$hn.qcow2 50G

virt-install \
--name "$hn" \
--virt-type kvm \
--vcpus 2 \
--ram 2048 \
--os-type=linux \
--os-variant=rhel6 \
--disk path=$IMAGES/$hn.qcow2 \
--disk path=$ISOs/drive-ubuntu.iso \
--network bridge=br0  \
--graphics vnc,listen=0.0.0.0 \
--noautoconsole \
--import

