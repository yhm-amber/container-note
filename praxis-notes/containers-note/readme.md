
所有 `containers` 项目下的工具应该都适用。

## 映射

映射文件 `/etc/containers/registries.conf.d/000-shortnames.conf`

<details>

<summary>默认内容（取自 Fedora 36 ）</summary>

~~~~ toml
[aliases]
  # almalinux
  "almalinux" = "docker.io/library/almalinux"
  "almalinux-minimal" = "docker.io/library/almalinux-minimal"
  # Arch Linux
  "archlinux" = "docker.io/archlinux/archlinux"
  # centos
  "centos" = "quay.io/centos/centos"
  # containers
  "skopeo" = "quay.io/skopeo/stable"
  "buildah" = "quay.io/buildah/stable"
  "podman" = "quay.io/podman/stable"
  "hello" = "quay.io/podman/hello"
  "hello-world" = "quay.io/podman/hello"
  # docker
  "alpine" = "docker.io/library/alpine"
  "docker" = "docker.io/library/docker"
  "registry" = "docker.io/library/registry"
  "swarm" = "docker.io/library/swarm"
  # Fedora
  "fedora-minimal" = "registry.fedoraproject.org/fedora-minimal"
  "fedora" = "registry.fedoraproject.org/fedora"
  # openSUSE
  "opensuse/tumbleweed" = "registry.opensuse.org/opensuse/tumbleweed"
  "opensuse/tumbleweed-dnf" = "registry.opensuse.org/opensuse/tumbleweed-dnf"
  "opensuse/tumbleweed-microdnf" = "registry.opensuse.org/opensuse/tumbleweed-microdnf"
  "opensuse/leap" = "registry.opensuse.org/opensuse/leap"
  "opensuse/busybox" = "registry.opensuse.org/opensuse/busybox"
  "tumbleweed" = "registry.opensuse.org/opensuse/tumbleweed"
  "tumbleweed-dnf" = "registry.opensuse.org/opensuse/tumbleweed-dnf"
  "tumbleweed-microdnf" = "registry.opensuse.org/opensuse/tumbleweed-microdnf"
  "leap" = "registry.opensuse.org/opensuse/leap"
  "leap-dnf" = "registry.opensuse.org/opensuse/leap-dnf"
  "leap-microdnf" = "registry.opensuse.org/opensuse/leap-microdnf"
  "tw-busybox" = "registry.opensuse.org/opensuse/busybox"
  # SUSE
  "suse/sle15" = "registry.suse.com/suse/sle15"
  "suse/sles12sp5" = "registry.suse.com/suse/sles12sp5"
  "suse/sles12sp4" = "registry.suse.com/suse/sles12sp4"
  "suse/sles12sp3" = "registry.suse.com/suse/sles12sp3"
  "sle15" = "registry.suse.com/suse/sle15"
  "sles12sp5" = "registry.suse.com/suse/sles12sp5"
  "sles12sp4" = "registry.suse.com/suse/sles12sp4"
  "sles12sp3" = "registry.suse.com/suse/sles12sp3"
  # Red Hat Enterprise Linux
  "rhel" = "registry.access.redhat.com/rhel"
  "rhel6" = "registry.access.redhat.com/rhel6"
  "rhel7" = "registry.access.redhat.com/rhel7"
  "rhel7.9" = "registry.access.redhat.com/rhel7.9"
  "rhel-atomic" = "registry.access.redhat.com/rhel-atomic"
  "rhel-minimal" = "registry.access.redhat.com/rhel-minimum"
  "rhel-init" = "registry.access.redhat.com/rhel-init"
  "rhel7-atomic" = "registry.access.redhat.com/rhel7-atomic"
  "rhel7-minimal" = "registry.access.redhat.com/rhel7-minimum"
  "rhel7-init" = "registry.access.redhat.com/rhel7-init"
  "rhel7/rhel" = "registry.access.redhat.com/rhel7/rhel"
  "rhel7/rhel-atomic" = "registry.access.redhat.com/rhel7/rhel7/rhel-atomic"
  "ubi7/ubi" = "registry.access.redhat.com/ubi7/ubi"
  "ubi7/ubi-minimal" = "registry.access.redhat.com/ubi7-minimal"
  "ubi7/ubi-init" = "registry.access.redhat.com/ubi7-init"
  "ubi7" = "registry.access.redhat.com/ubi7"
  "ubi7-init" = "registry.access.redhat.com/ubi7-init"
  "ubi7-minimal" = "registry.access.redhat.com/ubi7-minimal"
  "rhel8" = "registry.access.redhat.com/ubi8"
  "rhel8-init" = "registry.access.redhat.com/ubi8-init"
  "rhel8-minimal" = "registry.access.redhat.com/ubi8-minimal"
  "rhel8-micro" = "registry.access.redhat.com/ubi8-micro"
  "ubi8" = "registry.access.redhat.com/ubi8"
  "ubi8-minimal" = "registry.access.redhat.com/ubi8-minimal"
  "ubi8-init" = "registry.access.redhat.com/ubi8-init"
  "ubi8-micro" = "registry.access.redhat.com/ubi8-micro"
  "ubi8/ubi" = "registry.access.redhat.com/ubi8/ubi"
  "ubi8/ubi-minimal" = "registry.access.redhat.com/ubi8-minimal"
  "ubi8/ubi-init" = "registry.access.redhat.com/ubi8-init"
  "ubi8/ubi-micro" = "registry.access.redhat.com/ubi8-micro"
  "rhel9" = "registry.access.redhat.com/ubi9"
  "rhel9-init" = "registry.access.redhat.com/ubi9-init"
  "rhel9-minimal" = "registry.access.redhat.com/ubi9-minimal"
  "rhel9-micro" = "registry.access.redhat.com/ubi9-micro"
  "ubi9" = "registry.access.redhat.com/ubi9"
  "ubi9-minimal" = "registry.access.redhat.com/ubi9-minimal"
  "ubi9-init" = "registry.access.redhat.com/ubi9-init"
  "ubi9-micro" = "registry.access.redhat.com/ubi9-micro"
  "ubi9/ubi" = "registry.access.redhat.com/ubi9/ubi"
  "ubi9/ubi-minimal" = "registry.access.redhat.com/ubi9-minimal"
  "ubi9/ubi-init" = "registry.access.redhat.com/ubi9-init"
  "ubi9/ubi-micro" = "registry.access.redhat.com/ubi9-micro"
  # Rocky Linux
  "rockylinux" = "docker.io/library/rockylinux"
  # Debian
  "debian" = "docker.io/library/debian"
  # Kali Linux
  "kali-bleeding-edge" = "docker.io/kalilinux/kali-bleeding-edge"
  "kali-dev" = "docker.io/kalilinux/kali-dev"
  "kali-experimental" = "docker.io/kalilinux/kali-experimental"
  "kali-last-release" = "docker.io/kalilinux/kali-last-release"
  "kali-rolling" = "docker.io/kalilinux/kali-rolling"
  # Ubuntu
  "ubuntu" = "docker.io/library/ubuntu"
  # Oracle Linux
  "oraclelinux" = "container-registry.oracle.com/os/oraclelinux"
  # busybox
  "busybox" = "docker.io/library/busybox"
  # php
  "php" = "docker.io/library/php"
  # python
  "python" = "docker.io/library/python"
  # node
  "node" = "docker.io/library/node"
~~~~

</details>