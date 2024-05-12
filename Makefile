BOARDNAME = ZC706
KERNEL_VERSION = 2020.1

TOP       := $(CURDIR)
BOARD_DIR := $(TOP)/$(BOARDNAME)
HW_DIR    := $(BOARD_DIR)/base
HW_SRC    := $(HW_DIR)/base

#BSP_NAME  := xilinx-$(shell echo $(BOARDNAME) | tr A-Z a-z | tr -cd '[:alnum:]')-$(KERNEL_VERSION)
BSP_NAME  := $(BOARDNAME)
BSP_DIR   := $(TOP)/bsp
BSP_PROJ  := $(BSP_DIR)/$(BSP_NAME)

all: bit bsp

bit:
	$(MAKE) -C $(HW_DIR) all

bsp:
	mkdir -p $(BSP_DIR)
	cd $(BSP_DIR) && petalinux-create -t project -n $(BSP_NAME) --template zynq
	cd $(BSP_PROJ) && petalinux-config --get-hw-description=$(HW_DIR) --silentconfig
	cd $(BSP_DIR) && petalinux-package --bsp --force -p $(BSP_NAME) --hwsource $(HW_SRC) --output $(BOARD_DIR)/$(BSP_NAME).bsp

clean:
	rm -rf $(BOARD_DIR)/$(BSP_NAME).bsp
	rm -rf $(BSP_DIR)
	$(MAKE) -C $(HW_DIR) clean
