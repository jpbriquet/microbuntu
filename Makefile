
BOX_VERSION := 1.0.0
BOX_NAME := microbuntu
BOX_FILE := $(BOX_NAME)-$(BOX_VERSION).box
BOX_TEST := $(BOX_NAME)-test
TEST_DIR := ./tests
BUILD_DIR := ./builds

all: clean box prepare-test test hashes

clean: clean-test clean-box

box: $(BOX_FILE)

$(BOX_FILE):
	packer build -var 'BOX_NAME=$(BOX_NAME)' -var 'BOX_VERSION=$(BOX_VERSION)' $(BOX_NAME).json

prepare-test:
	vagrant box add --force $(BOX_TEST) $(BUILD_DIR)/$(BOX_FILE)
	cd $(TEST_DIR) && vagrant init -f -m $(BOX_TEST)

test:
	cd $(TEST_DIR) && bats ./*.bats

clean-test:
	cd $(TEST_DIR) && vagrant destroy -f || true
	cd $(TEST_DIR) && rm -rf Vagrantfile .vagrant
	vagrant box remove $(BOX_TEST) || true
	vagrant global-status --prune

clean-box:
	rm -rf output* $(BUILD_DIR)/$(BOX_FILE)
	rm -rf "$(HOME)/VirtualBox VMs/$(BOX_NAME)"

hashes:
	shasum -a 256 $(BUILD_DIR)/$(BOX_NAME)-$(BOX_VERSION).box
	shasum $(BUILD_DIR)/$(BOX_NAME)-$(BOX_VERSION).box

.PHONY: box prepare-test test all clean clean-test clean-box
