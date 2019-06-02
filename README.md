# arch-kvm-lab

This repo contains scripts and such used to bootstrap a qemu+kvm-based lab. These are for my own
reference and are not intended for re-use.

### Gather dependencies

```
./install.sh
```

### Setup Hypervisor-host to automatically configure bridge

This uses `ip` tool rather than the deprecated `brctl`. Adding it as a systemd unit and enabling
it ensures everything is in place after boot-up.

```
cp -v bridge-net.service /etc/systemd/system/
cp -v net-start.sh /usr/local/bin/
systemctl daemon-reload
systemctl enable bridge-net
```


### Dynamic hostnames for guests

In machine images, the following script will set the hostname to the ip address with `.` replaced
by `-`. This would be baked into the guest machine image. This will enable cloning guests and
ensuring unique hostnames.

```
cp -v reset-hostname.service /etc/systemd/system/
cp -v reset-hostname.sh /usr/local/bin/
systemctl daemon-reload
systemctl enable reset-hostname
```

### Creating machine clones

This step allows for quick cloning of machines in virsh.

1. shutdown guest

    ```
    virsh shutdown $DOMAIN
    ```

1. Clone image

    ```
    virt-clone --original $DOMAIN --name $NEW_NAME --file $LOCATION
    ```

### libvirt polkit access

The following provides access to everyone in wheel.

file: `/etc/polkit-1/rules.d/50-libvirt.rules`

```
/* Allow users in wheel group to manage the libvirt
daemon without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" &&
        subject.isInGroup("wheel")) {
            return polkit.Result.YES;
    }
});
```

### qemu connect sample string

The following is a sample connection string that can be used to connect to libvirtd remotely.

```
qemu+ssh://josh@192.168.0.4/system?key_file=/home/joshrosso/.ssh/key.pem
```

### Unifi controller install

run shell script

```
./unifi-install.sh
```
