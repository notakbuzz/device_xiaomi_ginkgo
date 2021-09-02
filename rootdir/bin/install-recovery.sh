#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):67108864:e8dc8ad17f033137d0c311d73bc231e0a2a180d9; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot$(getprop ro.boot.slot_suffix):67108864:8a71a363cba61d073be17cc7264d5f19b5e51e79 \
          --target EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):67108864:e8dc8ad17f033137d0c311d73bc231e0a2a180d9 && \
      log -t recovery "Installing new recovery image: succeeded" && \
        echo "Installing new recovery image: succeeded" > /cache/recovery/last_install_recovery_status || \
      (log -t recovery "Installing new recovery image: failed" && \
        echo "Installing new recovery image: failed" > /cache/recovery/last_install_recovery_status)
else
  log -t recovery "Recovery image already installed" && \
  echo "Recovery image already installed" > /cache/recovery/last_install_recovery_status
fi
