// 🎨 Tiation Rigger Workspace Documentation - Prettier Configuration
// Enterprise-grade formatting for documentation projects

module.exports = {
  // Basic formatting
  semi: true,
  trailingComma: 'es5',
  singleQuote: true,

  // Indentation
  tabWidth: 2,
  useTabs: false,

  // Line length
  printWidth: 100,

  // Object formatting
  bracketSpacing: true,

  // Array formatting
  bracketSameLine: false,

  // Arrow functions
  arrowParens: 'avoid',

  // JSX formatting
  jsxSingleQuote: true,

  // HTML formatting
  htmlWhitespaceSensitivity: 'css',

  // End of line
  endOfLine: 'lf',

  // Embedded language formatting
  embeddedLanguageFormatting: 'auto',

  // Quote props
  quoteProps: 'as-needed',

  // Vue formatting
  vueIndentScriptAndStyle: false,

  // File overrides
  overrides: [
    {
      files: '*.json',
      options: {
        printWidth: 80,
        tabWidth: 2,
      },
    },
    {
      files: '*.md',
      options: {
        printWidth: 80,
        proseWrap: 'always',
        tabWidth: 2,
      },
    },
    {
      files: ['*.yml', '*.yaml'],
      options: {
        tabWidth: 2,
        singleQuote: false,
      },
    },
  ],
};
