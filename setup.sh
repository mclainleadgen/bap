#!/bin/bash

echo "Setting up..."

echo "Installing node..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install node

echo "Installing jest, typescript, ts-jest, @types/jest..."
npm install --save-dev jest typescript ts-jest @types/jest

echo "Installing react testing library..."
npm install --save-dev @testing-library/react @testing-library/user-event @testing-library/dom @testing-library/jest-dom jest-environment-jsdom

echo "Deleting existing tsconfig.jest.json if it exists..."
rm -f tsconfig.jest.json

echo "Creating tsconfig.jest.json file..."
cat <<EOL > tsconfig.jest.json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "jsx": "react-jsx"
  }
}
EOL

echo "Deleting existing jest.setup.ts if it exists..."
rm -f jest.setup.ts

echo "Creating jest.setup.ts file..."
cat <<EOL > jest.setup.ts
import '@testing-library/jest-dom';
EOL

echo "Deleting existing jest.config.js if it exists..."
rm -f jest.config.js

echo "Creating new jest.config.js file..."
cat <<EOL > jest.config.js
/** @type {import('ts-jest').JestConfigWithTsJest} **/
module.exports = {
  testEnvironment: 'jsdom',
  transform: {
    '^.+\\.tsx?$': ['ts-jest', { tsconfig: './tsconfig.jest.json' }],
  },
  setupFilesAfterEnv: ['./jest.setup.ts'],
};
EOL
