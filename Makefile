# Flutter Boilerplate Makefile

# Detect if FVM is initialized (fvm directory exists)
FVM_DIR := .fvm
ifeq (,$(wildcard $(FVM_DIR)))
	FLUTTER := flutter
	DART := dart
else
	FLUTTER := fvm flutter
	DART := fvm dart
endif

# Extract app_name from package_rename_config.yaml if it exists
ifneq (,$(wildcard package_rename_config.yaml))
	APP_NAME := $(shell grep 'app_name:' package_rename_config.yaml | head -n 1 | sed 's/.*app_name:[[:space:]]*"\(.*\)".*/\1/')
	CURRENT_APP_NAME := $(shell grep '^name:' pubspec.yaml | sed 's/^name:[[:space:]]*//')
endif

.PHONY: help bootstrap clean deps gen analyze test format run build rename setup-git-hooks

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}\' $(MAKEFILE_LIST)

bootstrap: ## Bootstrap the project (deps, gen, git hooks)
	@echo "🚀 Bootstrapping Flutter project..."
	$(MAKE) deps
	$(MAKE) gen
	$(MAKE) setup-git-hooks
	@echo "✅ Bootstrap complete!"

clean: ## Clean the project
	@echo "🧹 Cleaning project..."
	$(FLUTTER) clean
	$(DART) pub cache clean
	rm -rf .dart_tool/
	rm -rf build/

deps: ## Get dependencies
	@echo "📦 Getting dependencies..."
	$(FLUTTER) pub get

gen: ## Generate code (build_runner)
	@echo "🔧 Generating code..."
	$(DART) run build_runner build --delete-conflicting-outputs

analyze: ## Analyze code
	@echo "🔍 Analyzing code..."
	$(FLUTTER) analyze

test: ## Run tests
	@echo "🧪 Running tests..."
	$(FLUTTER) test --coverage

format: ## Format code
	@echo "💅 Formatting code..."
	$(DART) format lib/ test/ --set-exit-if-changed

run: ## Run the app
	$(FLUTTER) run --dart-define-from-file=api-keys.json

build: ## Build APK
	$(FLUTTER) build apk --dart-define-from-file=api-keys.json

# Git hooks setup
setup-git-hooks: ## Setup git pre-commit and pre-push hooks
	@echo "🪝 Setting up git hooks..."
	@mkdir -p .git/hooks
	@if [ -f hooks/pre-commit ]; then \
		cp hooks/pre-commit .git/hooks/pre-commit; \
		chmod +x .git/hooks/pre-commit; \
		echo "✅ Pre-commit hook installed"; \
	fi
	@echo "🪝 Git hooks setup complete!"

# App renaming (enhanced version)
rename: ## Rename app (usage: make rename APP_NAME="My App\" BUNDLE_ID="com.example.myapp")
ifndef APP_NAME
	$(error APP_NAME is required. Usage: make rename APP_NAME="My App\" BUNDLE_ID="com.example.myapp")
endif
ifndef BUNDLE_ID
	$(error BUNDLE_ID is required. Usage: make rename APP_NAME="My App\" BUNDLE_ID="com.example.myapp")
endif
	@echo "📦 Renaming app to '${APP_NAME}' with bundle ID '${BUNDLE_ID}'"
	@echo "app_name: \"${APP_NAME}\"" > package_rename_config.yaml
	@echo "package_name: \"${BUNDLE_ID}\"" >> package_rename_config.yaml
	@echo "android_package_name: \"${BUNDLE_ID}\"" >> package_rename_config.yaml
	@echo "ios_bundle_id: \"${BUNDLE_ID}\"" >> package_rename_config.yaml
	@echo "macos_bundle_id: \"${BUNDLE_ID}\"" >> package_rename_config.yaml
	@echo "linux_package_name: \"${BUNDLE_ID}\"" >> package_rename_config.yaml
	@echo "windows_package_name: \"${BUNDLE_ID}\"" >> package_rename_config.yaml
	$(MAKE) change-app-name
	@rm -f package_rename_config.yaml
	@echo "✅ App renamed successfully!"

# Coverage report
coverage: test ## Generate coverage report
	@echo "📊 Generating coverage report..."
	genhtml coverage/lcov.info -o coverage/html
	@echo "📊 Coverage report generated in coverage/html/"
	$(FLUTTER) pub run covadge ./coverage/lcov.info ./

# Development helpers
dev-reset: clean bootstrap ## Reset development environment
	@echo "🔄 Development environment reset complete!"

check: format analyze test ## Run all checks (format, analyze, test)
	@echo "✅ All checks passed!"

# CI helpers
ci-check: deps gen check ## CI check pipeline
	@echo "🤖 CI checks complete!"

# Change app name + package rename + fix pubspec + imports (existing functionality)
change-app-name:
	@echo "📦 Renaming app to '${APP_NAME}'"; \
	EFFECTIVE_NAME_CLEAN=$$(echo "${APP_NAME}" | tr '[:upper:]' '[:lower:]' | tr ' ' '_'); \
	echo "📦 Effective name: $$EFFECTIVE_NAME_CLEAN"; \
	$(DART) run package_rename --path="package_rename_config.yaml"; \
	sed -i.bak "s/^name: .*/name: $$EFFECTIVE_NAME_CLEAN/" pubspec.yaml && rm pubspec.yaml.bak; \
	grep -rl "package:${CURRENT_APP_NAME}/" lib test | xargs sed -i.bak "s/package:${CURRENT_APP_NAME}\//package:$$EFFECTIVE_NAME_CLEAN\//g"; \
	find lib test -name "*.bak" -delete; \
	if [ -f catalog-info.yaml ]; then \
		echo "📝 Updating catalog-info.yaml"; \
		sed -i.bak "s/^  description: .*/  description: Flutter application - ${APP_NAME}/" catalog-info.yaml; \
		sed -i.bak "s/^  package_name: .*/  package_name: $$EFFECTIVE_NAME_CLEAN/" catalog-info.yaml; \
		rm catalog-info.yaml.bak; \
		echo "✅ catalog-info.yaml updated"; \
	else \
		echo "⚠️  catalog-info.yaml not found, skipping"; \
	fi