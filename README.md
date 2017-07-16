# Microbuntu Vagrant Box

This repository contains the scripts and configuration needed to create a minimalist [Ubuntu LTS](https://www.ubuntu.com/) box. Only mandatory packages are available by default in the VM.

This box will be updated as soon as possible when a new Ubuntu LTS is released.

## Usage

The box is available on [Hashicorp's Vagrant Cloud](https://app.vagrantup.com/jpbriquet/boxes/microbuntu)

To use it, just open a console and type :
```
$ vagrant init jpbriquet/ubuntu
$ vagrant up
```


## What's in the box ?

### VM
* 2 vCPUs
* 4 GB memory
* 1 GB swap enabled
* Default to NAT network
* Audio and USB off

### Guest OS
* Ubuntu LTS 16.04.2 (Xenial)
* Kernel 4.10.x (HWE virtual-edge) x86_64 Linux
* LVM root filesystem for any filesystem growing allocation
* Administrative user *ubuntu* (password is the same)
* OpenSSH server

## Building the Box

Box has been created with Packer tool and can be builded as follow.

### Requirements

* [Make for build orchestration](http://www.gnu.org/software/make/)
* [Packer as vagrant base box builder](http://www.packer.io) (at least version 0.12.2)
* [Vagrant](http://vagrantup.com) (at least version 1.9.1)
* [VirtualBox](http://www.virtualbox.org) (at least version 5.1.14)
* [bats for testing](https://github.com/sstephenson/bats)

### Building the box

The following make command launch the box build process and tests.

```
make all
```

It is also possible to call make targets independently:

* `make box`: Only run the packer build
* `make clean-box`: Remove any packer final or intermediate artifacts
* `make prepare-test`: Copy the latest built box to the test environment
* `make test`: Run the test suite using vagrant
* `make clean-test`: Clean any test artifacts or VM
* `make clean`: Clean everything

### Extension point

If you want to tune the behavior to fit your needs,
but want to reuse all the build process, here is the workflow
for VM customization:

* Add this repository as a
[git submodule](https://git-scm.com/docs/git-submodule)
of your repository
* Put in the `customize` folder the content you want to be uploaded to the VM
  - You can overwrite existing content: it is for demo purpose
  - The content will be uploaded inside /var/customize
  - If there is a script `run.sh`, it will be run during box build time
* Build the VM with the previous instructions


## User Feedback

### Issues

If you have any problems with or questions about this box, please contact us through a [GitHub issue](https://github.com/jpbriquet/microbuntu/issues).

### Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/jpbriquet/microbuntu/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
