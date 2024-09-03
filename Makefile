###############################################################################
#
# BSD 2-Clause License
#
# Copyright (c) 2024, Danil Borchevkin
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
###############################################################################

# *****************************************************************************
# * TARGETS - MANDATORY
# *****************************************************************************

# Init repository / project
.PHONY: init
init:
	$(info No action needed. PASS.)


# Build image
.PHONY: build
build:
	docker build -t docker-build .


# Check image and embedded scripts
.PHONY: check
check:
	hadolint Dockerfile


# Run in interactive mode
.PHONY: run
run: remove
	docker run -it --name docker-build_container docker-build


# Run in detached mode 
.PHONY: run_with_env
run_with_env: remove
	docker run -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.ssh/known_hosts:/root/.ssh/known_hosts -v "$PWD":/host -w /host -d -i -t --name docker-build_container docker-build


# Attach to running container
.PHONY: attach
attach:
	docker attach docker-build_container


# Remove running contaner
.PHONY: remove
remove:
	-docker container rm -f docker-build_container


# Clean all docker images and containers
.PHONY: clean
clean:
	-docker system prune -af && docker image prune -af && docker system prune -af --volumes && docker system df


# *****************************************************************************
# * TARGETS - PROJECT-SPECIFIC
# *****************************************************************************

# Fix issues in RHEL-based distros
.PHONY: fix_selinux
fix_selinux:
	sudo su -c "setenforce 0"

# *****************************************************************************
# * END OF MAKEFILE
# *****************************************************************************
