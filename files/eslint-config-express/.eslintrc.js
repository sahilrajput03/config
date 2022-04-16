module.exports = {
	env: {
		node: true,
		commonjs: true,
		es2021: true,
		jest: true,
		// ^ This fixes 🤑︎ `test not defined` and `expect not defined` eslint warnings.
	},
	extends: 'eslint:recommended',
	parserOptions: {
		ecmaVersion: 12,
	},
	rules: {
		'no-unused-vars': 'off',
		'default-case': 'warn',
		semi: 'off',
		quotes: ['error', 'single', {avoidEscape: true}],
		//  ^ Thanks to this guy 🤺︎ => : https://github.com/prettier/prettier/issues/973#issuecomment-285768569
	},
	// Above rules by ~sahil
	// A rule can be {off, warn or error} (0, 1 or 2 respectively).

	// # Complete list and the best practise rules in eslint:
	//  https://eslint.org/docs/rules/)
	//
	// # Must install eslint vscode extension: https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint
	// src: https://github.com/amand33p/reddish/blob/master/server/.eslintrc.json
}
