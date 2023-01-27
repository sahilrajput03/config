// Example in action: https://github.com/sahilrajput03/learning_sql/blob/main/fso-part13/example/.eslintrc.js
// TODO: Add usage of airbnb's config used in slasher-new project like.
// Complete list of rules: https://eslint.org/docs/latest/rules/
// Eslint Vscode Extension: https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint
// A rule can be <off, warn or error> OR <0, 1 or 2> respectively

module.exports = {
	env: {
		node: true,
		commonjs: true,
		es2021: true,
		// Fix  warnings e.g., `test not defined`, `expect not defined`, etc in test files
		jest: true,
	},
	extends: 'eslint:recommended',
	parserOptions: {
		ecmaVersion: 12,
	},
	rules: {
		'no-unused-vars': 'off',
		'default-case': 'warn',
		semi: 'off',
		// https://eslint.org/docs/latest/rules/quotes#avoidescape
		quotes: ['warn', 'single', {avoidEscape: true}],
	},
}
