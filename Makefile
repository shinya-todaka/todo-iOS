# Variables

PRODUCT_NAME := todo-iOS
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
SCHEME_NAME := ${PRODUCT_NAME}
UI_TESTS_TARGET_NAME := ${PRODUCT_NAME}UITests

# Targets

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'

.PHONY: setup
setup: # Install dependencies and prepared development configuration
	$(MAKE) install-mint
	$(MAKE) generate-xcodeproj

.PHONY: install-mint
install-mint: # Install Mint dependencies
	mint bootstrap --overwrite y

.PHONY: generate-xcodeproj
generate-xcodeproj: # Generate project with XcodeGen
	mint run xcodegen xcodegen generate
	$(MAKE) open

.PHONY: open
open: # Open project in Xcode
	open ./${PROJECT_NAME}

.PHONY: show-devices
show-devices: # Show devices
	xcrun xctrace list devices
