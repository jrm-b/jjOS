#!/bin/bash

FEDORA_PACKAGES=(
	bootc
	containerd
	distrobox
	evtest
	gcc
	gcc-c++
	git
	git-credential-libsecret
	git-delta
	glow
	ifuse
	just
	libimobiledevice
	lm_sensors
	make
	neovim
	opendyslexic-fonts
	powerstat
	powertop
	pulseaudio-utils
	rclone
	restic
	ripgrep
	tmux
	usbmuxd
	vim
	waypipe
	wireguard-tools
	wl-clipboard
)

log INFO "Installing ${FEDORA_PACKAGES[*]} from fedora repository (official)"

if ! command -v dnf5 &>/dev/null; then
	log ERROR "Missing dnf5 dependency for copr_install_isolated"
	return 1
fi

dnf5 -y install "${FEDORA_PACKAGES[@]}"

log INFO "Installing additional from COPR repositories (community)"

copr_install_isolated "che/nerd-fonts" "nerd-fonts"
copr_install_isolated "jdxcode/mise" "mise"
copr_install_isolated "atim/starship" "starship"
copr_install_isolated "scottames/ghostty" "ghostty"

EXCLUDED_PACKAGES=(
	cosign
	fedora-bookmarks
	fedora-chromium-config
	fedora-chromium-config-gnome
	firefox
	firefox-langpacks
	gnome-extensions-app
	gnome-shell-extension-background-logo
	gnome-software
	gnome-software-rpm-ostree
	gnome-terminal-nautilus
	podman-docker
	yelp
)

# Remove excluded packages if they are installed
if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
	readarray -t INSTALLED_EXCLUDED < <(rpm -qa --queryformat='%{NAME}\n' "${EXCLUDED_PACKAGES[@]}" 2>/dev/null || true)
	if [[ "${#INSTALLED_EXCLUDED[@]}" -gt 0 ]]; then
		log INFO "Removing ${INSTALLED_EXCLUDED[*]} packages"
		dnf -y remove "${INSTALLED_EXCLUDED[@]}"
	else
		log INFO "No excluded packages found to remove."
	fi
fi
