# Makefile for Flutter project with FVM support

# Detect if FVM is initialized (fvm directory exists)
FVM_DIR := .fvm
ifeq (,$(wildcard $(FVM_DIR)))
	FLUTTER := flutter
else
	FLUTTER := fvm flutter
endif

.PHONY: run build generate coverage

run:
	$(FLUTTER) run --dart-define-from-file="api-keys.json"

build:
	$(FLUTTER) build apk --dart-define-from-file="api-keys.json"

# Generate code (e.g., build_runner)
generate:
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs

# Run tests with coverage and generate HTML report
coverage:
	$(FLUTTER) test --coverage
	$(FLUTTER) pub global activate coverage
	$(FLUTTER) pub global run coverage:format_coverage --lcov --in=coverage/lcov.info --out=coverage/lcov.info --packages=.packages --report-on=lib
	genhtml coverage/lcov.info -o coverage/html
