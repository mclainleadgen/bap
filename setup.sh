#!/bin/bash
echo "Setting up..."
echo "Installing pnpm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install node
npm install -g pnpm
pnpm setup
source /home/codespace/.bashrc
pnpm add -g pnpm
echo "Installing jest, typescript, ts-jest, @types/jest..."
pnpm add --save-dev jest typescript ts-jest @types/jest
if [ -f jest.config.js ]; then
    echo "jest.config.js already exists. Skipping ts-jest configuration."
else
    echo "jest.config.js not found. Running ts-jest configuration..."
    pnpm dlx ts-jest config:init
fi