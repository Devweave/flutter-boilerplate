# Makefile for Flutter project with FVM support

# Detect if FVM is initialized (fvm directory exists)
FVM_DIR := .fvm
ifeq (,$(wildcard $(FVM_DIR)))
	FLUTTER := flutter
	DART := dart
else
	FLUTTER := fvm flutter
	DART := fvm dart
endif
# Extract app_name from package_rename_config.yaml
APP_NAME := $(shell grep 'app_name:' package_rename_config.yaml | sed 's/.*app_name:[[:space:]]*"\(.*\)".*/\1/')
CURRENT_APP_NAME := $(shell grep '^name:' pubspec.yaml | sed 's/^name:[[:space:]]*//')

.PHONY: run build generate coverage

run:
	$(FLUTTER) run --dart-define-from-file="api-keys.json"

build:
	$(FLUTTER) build apk --dart-define-from-file="api-keys.json"

# Generate code (e.g., build_runner)
generate:
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs

# Change app name + package rename + fix pubspec + imports
change-app-name:
	@echo "📦 Renaming app to '${APP_NAME}'"; \
	EFFECTIVE_NAME_CLEAN=$$(echo "${APP_NAME}" | tr '[:upper:]' '[:lower:]' | tr ' ' '_'); \
	echo "📦 Effective name: $$EFFECTIVE_NAME_CLEAN"; \
	$(DART) run package_rename --path="package_rename_config.yaml"; \
	sed -i.bak "s/^name: .*/name: $$EFFECTIVE_NAME_CLEAN/" pubspec.yaml && rm pubspec.yaml.bak; \
	grep -rl "package:${CURRENT_APP_NAME}/" lib test | xargs sed -i.bak "s/package:${CURRENT_APP_NAME}\//package:$$EFFECTIVE_NAME_CLEAN\//g"; \
	find lib test -name "*.bak" -delete

# Run tests with coverage and generate HTML report
coverage:
	$(FLUTTER) test --coverage
	$(FLUTTER) pub global activate coverage
	$(FLUTTER) pub global run coverage:format_coverage --lcov --in=coverage/lcov.info --out=coverage/lcov.info --packages=.packages --report-on=lib
	genhtml coverage/lcov.info -o coverage/html
