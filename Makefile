# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help



# Development Commands
argo-portforward:
	kubectl port-forward -n argocd service/argocd-server 8080:443

argo-get-password:
	@echo "Password: $(shell kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)"


version: ## Output the current version
	@echo "${BBlack}Version: $(VERSION)${NC}"

print:
	@echo "${BCyan}...Launching Dev Server... ${NC}"

