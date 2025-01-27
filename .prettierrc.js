// Learn Prettier: https://docs.google.com/document/d/1T-VclkyzwAxoJ519c5P9xRrn0ZjRtQF-Ueu1GviMJYo/edit?tab=t.0
// FILE: prettier.config.js or .prettierrc.js
// IGNORE FILE: .prettierignore
// NPM SCRIPT for `package.json` => "pretty": "prettier --write ."
module.exports = {
	// set max characters on a line
	printWidth: 120, // default is 80
	// https://prettier.io/docs/en/options.html#insert-pragma
	requirePragma: false, // default false
	trailingComma: 'es5',
	tabWidth: 2,
	// disable semicolon (false)
	semi: false,
	// use single quote. FYI: It does not work for jsx props key-value pairs
	singleQuote: true,
	// Use single quote for jsx
	jsxSingleQuote: true,
	bracketSpacing: false,
	useTabs: true,
	//  PHP FORMATTING: Read more about php formatting @ https://github.com/prettier/plugin-php
	braceStyle: '1tbs', // sets the brace style for php files to put on same line
}
