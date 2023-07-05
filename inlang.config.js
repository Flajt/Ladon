export async function defineConfig(env) {
	const { default: pluginJson } = await env.$import(
		"https://cdn.jsdelivr.net/npm/@inlang/plugin-json@3/dist/index.js",
	)

	// recommended to enable linting feature
	const { default: standardLintRules } = await env.$import(
		"https://cdn.jsdelivr.net/gh/inlang/standard-lint-rules@2/dist/index.js",
	)

	return {
		referenceLanguage: "en",
		plugins: [
			pluginJson({
				pathPattern: "./assets/translations/{language}.json",
			}),
			standardLintRules(),
		],
	}
}
