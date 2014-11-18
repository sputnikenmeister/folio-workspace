/*global module*/
module.exports = function (grunt) {
	"use strict";

	var config = {};

	config.pkg = grunt.file.readJSON("package.json");

	/*
	 * Sass: Using Compass compiler (requires gem)
	 */
	grunt.loadNpmTasks("grunt-contrib-compass"); // Sass
	config.compass = {
		debug: {
			options: {
				sassDir: "./assets/src/sass",
				cssDir: "./assets/css"
			}
		},
		dist: {
			options: {
				sassDir: "./assets/src/sass",
				cssDir: "./assets/css",
				outputStyle: "compressed"
			}
		}
	};

	/*
	 * CSS prefixes (-moz-, -webkit-, etc.)
	 */
	grunt.loadNpmTasks("grunt-autoprefixer"); // CSS
	config.autoprefixer = {
		styles: {
			files: {
				"./assets/css/folio.css": "./assets/css/folio.css"
			}
		},
		flash: {
			files: {
				"./assets/css/flash.css": "./assets/css/flash.css"
			}
		}
	};

	/*
	 * bower dependencies
	 */
	grunt.loadNpmTasks("grunt-bower-install-simple"); // Dependencies
	config["bower-install-simple"] = {
		dev: {
			options: {
				production: false,
				clean: false
			}
		}
	};

	// grunt.loadNpmTasks('grunt-browserify-bower');
	// config.browserifyBower = {
	// 	vendor: {
	// 		options: {
	// 			forceResolve: {
 //  					"backbone.picky": "lib/backbone.picky.js"
	// 			}
	// 		}
	// 	}
	// };


	/*
	 * jshint: code quality check
	 */
	grunt.loadNpmTasks("grunt-contrib-jshint"); // JavaScript
	config.jshint = {
		options: {
			jshintrc: ".jshintrc"
		},
		files: [
			"./assets/src/js/app/**/*.js"
		]
	};

	// var scriptBaseDir = "./assets/src/js";
	var clientSources = [
		"./assets/src/js/app/App.js",
		// "./assets/src/js/app/**/*.js", "./assets/src/js/app/**/*.tpl"
	];
	var vendorRequire = [
		"jquery", "hammerjs", "jquery-hammerjs", "velocity-animate",
		"underscore", "backbone", "backbone.babysitter",
		"backbone.select", "backbone.cycle", "backbone-view-options"
	];
	var vendorAlias = [
		"./bower_components/backbone.picky/lib/amd/backbone.picky.js:backbone.picky"
	];
	var clientExternal = vendorRequire.concat([
		"backbone.picky"
	]);

	/**
	 * browserify
	 */
	grunt.loadNpmTasks("grunt-browserify");
	config.browserify = {
		vendor: {
			dest: "./assets/js/vendor.js", src: [],
			options: { browserifyOptions: { debug: false }, require: vendorRequire, alias: vendorAlias }
		},
		client: {
			dest: "./assets/js/folio.js", src: clientSources,
			options: {
				browserifyOptions: { fullPaths: false, debug: true },
				transform: [ "node-underscorify" ],
				external: clientExternal
			}
		},
		clientWatch: {
			dest: "./assets/js/folio.js", src: clientSources,
			options: {
				watch: true,
				browserifyOptions: { fullPaths: false, debug: true },
				transform: [ "node-underscorify" ],
				external: clientExternal
			}
		}
	};


	/*
	 * Watch tasks
	 */
	grunt.loadNpmTasks("grunt-contrib-watch"); // Workflow
	config.watch = {
		options: {
			livereload: false,
			spawn: false,
			forever: true
		},
		config: {
			files: ["./gruntfile.js"],
		},
		jshint: {
			files: ["./assets/src/js/**/*.js"],
			tasks: ["jshint"]
		},
		scripts: {
			files: ["./assets/js/folio.js"],
			options: {
				livereload: false
			}
		},
		styles: {
			files: ["./assets/src/sass/**/*.scss"],
			tasks: ["compass:debug", "autoprefixer:styles"]
		}
	};

	grunt.initConfig(config);

	// Install
	grunt.registerTask("install", ["bower-install-simple", "browserify:vendor"]);
	// Watch build
	grunt.registerTask("buildWatch", ["browserify:vendor", "browserify:clientWatch", "watch"]);
	grunt.registerTask("sublimeWatch", ["buildWatch"]);
	// Simple build
	grunt.registerTask("buildScripts", ["browserify:vendor", "jshint", "browserify:client"]);
	grunt.registerTask("buildStyles", ["compass:debug", "autoprefixer:styles"]);
	grunt.registerTask("buildAll", ["buildStyles", "buildScripts"]);
	// Default task
	grunt.registerTask("default", ["buildAll"]);
};
