export hn=cadc02

export IMAGES=/var/lib/libvirt/images
export CONFIG_DRIVE=./CONFIG-DRIVE
export ISOs=./ISOs

mkisofs -R -V config-2 -o $ISOs/drive-ubuntu.iso $CONFIG_DRIVE

qemu-img create -f qcow2 -b $IMAGES/CentOS-7-x86_64-GenericCloud.qcow2 $IMAGES/$hn.qcow2 50G

virt-install \
--name "$hn" \
--virt-type kvm \
--vcpus 4 \
--ram 8192 \
--os-type=linux \
--os-variant=rhel7 \
--disk path=$IMAGES/$hn.qcow2 \
--disk path=$ISOs/drive-ubuntu.iso \
--network network=default  \
--network bridge=br0  \
--graphics vnc,listen=0.0.0.0 \
--noautoconsole \
--import

