ONESHELL:

.PHONY: help
help: ## Show available targets
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@fgrep "##" Makefile | fgrep -v fgrep

.PHONY: lint
lint: ## Fast feedback checks (compile without running tests)
	mvn -q -DskipTests=true test

.PHONY: test
test: ## Run unit tests
	mvn -q test

