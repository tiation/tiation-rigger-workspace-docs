// 🎯 Tiation Rigger Workspace Documentation - ESLint Configuration
// Enterprise-grade linting for documentation projects

module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: ['eslint:recommended', 'prettier'],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  ignorePatterns: [
    '.eslintrc.js',
    'dist/**/*',
    'node_modules/**/*',
    'assets/css/**/*',
    '*.min.js',
    '*.min.css',
  ],
  rules: {
    // Code Quality
    'no-console': 'warn',
    'no-debugger': 'error',
    'no-duplicate-imports': 'error',
    'no-unused-vars': 'error',
    'no-unused-expressions': 'error',
    'prefer-const': 'error',
    'no-var': 'error',
    'object-shorthand': 'error',
    'prefer-arrow-callback': 'error',
    'prefer-template': 'error',

    // Best Practices
    'consistent-return': 'error',
    curly: 'error',
    eqeqeq: 'error',
    'no-eval': 'error',
    'no-implied-eval': 'error',
    'no-new-func': 'error',
    'no-script-url': 'error',
    'no-sequences': 'error',
    'no-throw-literal': 'error',
    'no-unmodified-loop-condition': 'error',
    'no-unused-labels': 'error',
    'no-useless-call': 'error',
    'no-useless-concat': 'error',
    'no-useless-escape': 'error',
    'no-useless-return': 'error',
    'no-void': 'error',
    'prefer-promise-reject-errors': 'error',
    radix: 'error',
  },
  // TypeScript support available when needed
  // overrides: [
  //   {
  //     files: ['**/*.ts', '**/*.tsx'],
  //     parser: '@typescript-eslint/parser',
  //     plugins: ['@typescript-eslint'],
  //     extends: [
  //       'eslint:recommended',
  //       '@typescript-eslint/recommended',
  //       'prettier',
  //     ],
  //     rules: {
  //       '@typescript-eslint/no-explicit-any': 'warn',
  //       '@typescript-eslint/no-unused-vars': 'error',
  //     },
  //   },
  // ],
};
