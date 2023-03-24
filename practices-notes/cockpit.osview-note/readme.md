[site]: https://cockpit-project.org/ "Cockpit Project — a web-based graphical interface for servers, intended for everyone."
[mastodon]: https://fosstodon.org/@Cockpit "@Cockpit@fosstodon.org -- The easy-to-use graphical interface for servers that gives you a desktop-like experience in your browser and on your phone. It's #FreeSoftware / #OpenSource / #FOSS, of course! And it's included in all the major #Linux distros."
[src/gh]: https://github.com/cockpit-project/cockpit.git "(LGPL-2.1) (Languages: C 38.0%, JavaScript 34.9%, Python 21.9%, SCSS 1.7%, Shell 1.3%, HTML 1.0%, Other 1.2%) Cockpit is a web-based graphical interface for servers."
[guide]: https://cockpit-project.org/guide

[site:faq.html]: https://cockpit-project.org/faq.html

[🦔 website][site] | [👾 guide][guide] | [👻 src][src/gh] | [🥗 mastodon][mastodon] | [🦀 faq][site:faq.html]

## Install

ref: 

- [Running Cockpit | Cockpit Project][site:running.html]
- [Cockpit documentation | Cockpit Project][site:documentation.html]
- [Applications | Cockpit Project][site:applications.html]

[site:documentation.html]: https://cockpit-project.org/documentation.html
[site:running.html]: https://cockpit-project.org/running.html
[site:applications.html]: https://cockpit-project.org/applications.html

~~~ sh
: Fedora ::

: Fedora : Install cockpit :
sudo dnf install -- cockpit

: Fedora : Enable cockpit :
sudo systemctl enable --now -- cockpit.socket

: Fedora : Open the firewall if necessary :
sudo firewall-cmd --add-service=cockpit
sudo firewall-cmd --add-service=cockpit --permanent

: PureOS/Debian ::
sudo apt install -- cockpit

: Arch Linux ::
sudo pacman -S cockpit
sudo systemctl enable --now -- cockpit.socket

: openSUSE Tumbleweed ::
zypper in -- cockpit
systemctl enable --now -- cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit && firewall-cmd --reload

: SUSE Micro ::
transactional-update pkg install -t pattern microos-cockpit
systemctl enable --now -- cockpit.socket
firewall-cmd --permanent --zone=public --add-service=cockpit && firewall-cmd --reload

: Clear Linux ::
sudo swupd bundle-add -- sysadmin-remote
sudo systemctl enable --now -- cockpit.socket

: CoreOS ::

: CoreOS : Install Cockpit packages as overlay RPMs :
rpm-ostree install -- cockpit-system cockpit-ostree cockpit-podman

: : Depending on your configuration,
: :  you may want to use other `cockpit-*` extensions as well,
: :  such as `cockpit-kdump` or `cockpit-networkmanager`.

: CoreOS : on boot :

: CoreOS : on boot : Enable password based SSH logins, unless you only use SSO logins :
echo 'PasswordAuthentication yes' |
    sudo tee /etc/ssh/sshd_config.d/02-enable-passwords.conf &&
sudo systemctl try-restart sshd

: CoreOS : on boot : Run the Cockpit web service with a privileged container (as root) :
podman container runlabel --name cockpit-ws -- RUN quay.io/cockpit/ws

: CoreOS : on boot : Make Cockpit start on boot :
podman container runlabel -- INSTALL quay.io/cockpit/ws
systemctl enable cockpit.service
~~~
