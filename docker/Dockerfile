# ============================================================================
# This image provides what's needed to build .NET projects with Buildvana SDK
# in GitLab CI, including Windows setup program generation via InnoSetup:
#
#   - .NET SDK
#   - Wine (to run command-line InnoSetup)
#   - XVFB (for running Wine without a display)
#   - GitLab's release-cli
#
# TODO: Try to make the image smaller (not trivial: Wine requires X11
#       or Wayland, even for running conaole programs!)
#       Things we may try:
#         - Switch from Ubuntu to Alpine Linux (X11?? Wine??)
#         - Remove some unused packages (which ones?)
#         - Take inspiration from other projects, namely:
#             * https://github.com/suchja/x11client
#             * https://github.com/amake/wine
#             * https://github.com/amake/innosetup-docker
#           (.NET SDK will have to be added via Dockerfile, though)
# ============================================================================

# ----------------------------------------------------------------------------
#                        BASE IMAGE / INITIAL SETUP
# ----------------------------------------------------------------------------

# Use the official .NET SDK image as a parent image
FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy

# Set the working directory
WORKDIR /app

# ----------------------------------------------------------------------------
#                    DEPENDENCY SETUP / SYSTEM CONFIGURATION
# ----------------------------------------------------------------------------

USER root

# Update .NET workloads (avoids warning when running dotnet CLI in container)
RUN dotnet workload update

# Install dependencies:
#   - Git and SSH are needed to work with Git repositories
#   - Wine is needed to run Inno Setup when requested by projects
#   - i386 architecture is needed because we need to run Inno Setup under 32-bit Wine
#   - osslsigncode is needed to sign setup executables (work in progress, not verified)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    openssh-client \
    osslsigncode

# Install Wine from WineHQ
# https://wiki.winehq.org/Ubuntu
# xvfb is needed to run wine (which is an X11 client, even when running console apps) without a display
RUN dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
    && apt-get update \
    && apt-get install -y --install-recommends winehq-stable xvfb

# Get rid of APT package lists
RUN rm -rf /var/lib/apt/lists/*

# Download and install GitLab's release-cli
RUN curl --location --output /usr/local/bin/release-cli "https://gitlab.com/api/v4/projects/gitlab-org%2Frelease-cli/packages/generic/release-cli/latest/release-cli-linux-amd64" \
    && chmod +x /usr/local/bin/release-cli

# Copy utility scripts and add them to PATH
COPY --chmod=755 opt /opt/
ENV PATH $PATH:/opt/bin

# ----------------------------------------------------------------------------
#                         USER-LEVEL CONFIGURATION
# ----------------------------------------------------------------------------

USER app

# We want to use 32-bit Wine for InnoSetup
ENV WINEARCH win32

# Only show error messages from Wine
ENV WINEDEBUG -all,err+all

# Suppress prompts to install wine-gecko and wine-mono
ENV WINEDLLOVERRIDES mscoree,mshtml=

# Create Wine prefix and configure registry values
COPY --chown=app --chmod=755 configure-wine /tmp/
RUN x11-headless wine-session /tmp/configure-wine \
    && rm /tmp/configure-wine
