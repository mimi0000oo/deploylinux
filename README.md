# DeployLinux
Deploy a linux machine with minimal effort and quick setup.
Used for deploying a Gentoo or Arch linux enviorment.

# Deployment script
```bash
curl https://raw.githubusercontent.com/mimi0000oo/deploylinux/testing/deploy.sh -o deploy.sh && chmod +x deploy.sh && ./deploy.sh
```

# Manuals
I recommend reading the [Arch manual](https://wiki.archlinux.org/title/Installation_guide) or/and the [Gentoo manual](https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation). They are some of the best distro wiki/manuals for your system and if you don't have experience with any of them before they can be handy for certain Arch/Gentoo specific commands/features.

# Disclamer
I am trying to be as consistent as possible with the latest Arch/Gentoo installation methods, but if anything changes I would be glad to modify in the project. So, if you see that something is not right with your installation procces, an issue would be greatly appreciated.

*I also recommend tying the script in an* `virtual enviorment` *before running it on a real system*.

# VM recommandations
Gentoo recomendation for a virtual machine:
  - CPU - as much as possible
  - RAM - 1.5x the cpu threads allocated (if possible)

Arch recomendation for virtual machine:
  - CPU - 2 cores, 2 threads
  - RAM - 4096 MiB
