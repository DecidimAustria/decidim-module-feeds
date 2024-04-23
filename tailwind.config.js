const mainConfig = require('./workspace/digigraetzl/tailwind.config.js');

module.exports = {
	...mainConfig,
	theme: {
		extend: {
			// Your customizations go here
		},
	},
	variants: {
		extend: {
			// Your custom variants go here
		},
	},
	plugins: [
		// Your custom plugins go here
		...mainConfig.plugins,
	],
};
