/** @type {import('ts-jest').JestConfigWithTsJest} **/
module.exports = {
  testEnvironment: 'jsdom',
  transform: {
    '^.+\.tsx?$': ['ts-jest', { tsconfig: './tsconfig.jest.json' }],
  },
  setupFilesAfterEnv: ['./jest.setup.ts'],
};
