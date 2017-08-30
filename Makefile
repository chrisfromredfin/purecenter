build:
	@mkdir -p css
	@echo "\033[0;35mLinting sass...\033[0m";
	@node_modules/sass-lint/bin/sass-lint.js -v sass/*;
	@echo "\033[0;35mCompiling sass...\033[0m";
	@node_modules/dart-sass/sass.js sass/additional.scss > styles/_intermediate.css
	@echo "\033[0;35mPost-processing css...\033[0m"
	@node_modules/postcss-cli/bin/postcss styles/_intermediate.css -u autoprefixer -o styles/additional.css
	@echo "Done."

bs:
	browser-sync start -c bs-config.js

sassquatch: build
	@echo "Watching for changes..."
	@fswatch -0 -m poll_monitor -o -r -Ie ".*\.scss" sass | xargs -n1 -0 -I{} sh -c 'make -s build'
