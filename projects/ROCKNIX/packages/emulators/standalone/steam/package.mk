# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026 ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="steam"
PKG_VERSION="1.0.0.85"
PKG_LICENSE="proprietary"
PKG_SITE="https://steampowered.com"
PKG_URL="https://repo.steampowered.com/steam/archive/stable/steam-launcher_${PKG_VERSION}_amd64.deb"
PKG_DEPENDS_TARGET="mesa:host fex-emu gamescope nss networkmanager"
PKG_LONGDESC="Steam is the ultimate destination for playing, discussing, and creating games"
PKG_TOOLCHAIN="manual"


unpack() {
 mkdir -p ${PKG_BUILD}
 cd ${PKG_BUILD}
 ar x ${SOURCES}/${PKG_NAME}/steam-${PKG_VERSION}.deb
 tar -xf data.tar.xz
}

makeinstall_target() {
  sed -i '/^# Don'\''t allow running as root$/,/^fi$/d' "${PKG_BUILD}/usr/lib/steam/bin_steam.sh"
  mkdir -p ${INSTALL}/usr/config/modules
  mkdir -p ${INSTALL}/usr/share/steam
  cp -rf ${PKG_BUILD}/usr/bin ${INSTALL}/usr/bin
  cp -rf ${PKG_BUILD}/usr/lib ${INSTALL}/usr/lib
  install -Dm755 ${PKG_DIR}/scripts/start_steam.sh ${INSTALL}/usr/bin/start_steam.sh
  install -Dm755 ${PKG_DIR}/scripts/start_steam_arm64.sh ${INSTALL}/usr/bin/start_steam_arm64.sh
  install -Dm755 ${PKG_DIR}/scripts/start_steam_x86.sh ${INSTALL}/usr/bin/start_steam_x86.sh
  install -Dm755 ${PKG_DIR}/scripts/steamos-session-select ${INSTALL}/usr/bin/steamos-session-select

  if [ "${DEVICE}" = "SM8550" ]; then
    install -Dm755 ${PKG_DIR}/scripts/starmos-common ${INSTALL}/usr/bin/starmos-common
    install -Dm755 ${PKG_DIR}/scripts/starmos-steam-bootstrap ${INSTALL}/usr/bin/starmos-steam-bootstrap
    install -Dm755 ${PKG_DIR}/scripts/starmos-gamemode ${INSTALL}/usr/bin/starmos-gamemode
    install -Dm755 ${PKG_DIR}/scripts/starmos-recovery ${INSTALL}/usr/bin/starmos-recovery
    install -Dm755 ${PKG_DIR}/scripts/starmos-enable-gamemode ${INSTALL}/usr/bin/starmos-enable-gamemode
    install -Dm755 ${PKG_DIR}/scripts/starmos-disable-gamemode ${INSTALL}/usr/bin/starmos-disable-gamemode
    install -Dm755 ${PKG_DIR}/scripts/starmos-healthcheck ${INSTALL}/usr/bin/starmos-healthcheck

    mkdir -p ${INSTALL}/usr/lib/systemd/system
    install -Dm644 ${PKG_DIR}/system.d/starmos-firstboot.service ${INSTALL}/usr/lib/systemd/system/starmos-firstboot.service
    install -Dm644 ${PKG_DIR}/system.d/starmos-firstboot.timer ${INSTALL}/usr/lib/systemd/system/starmos-firstboot.timer
    install -Dm644 ${PKG_DIR}/system.d/starmos-gamemode.service ${INSTALL}/usr/lib/systemd/system/starmos-gamemode.service
    install -Dm644 ${PKG_DIR}/system.d/starmos-recovery.service ${INSTALL}/usr/lib/systemd/system/starmos-recovery.service

    enable_service starmos-firstboot.timer
  fi
  cp -rf ${PKG_DIR}/resources/compatibilitytool.vdf ${INSTALL}/usr/share/steam
  cp -rf ${PKG_DIR}/resources/toolmanifest.vdf ${INSTALL}/usr/share/steam
  cp -rf ${PKG_DIR}/resources/registry.vdf ${INSTALL}/usr/share/steam
}
