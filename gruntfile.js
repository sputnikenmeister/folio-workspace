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
				sassDir: "assets/src/sass",
				cssDir: "assets/css"
			}
		},
		dist: {
			options: {
				sassDir: "assets/src/sass",
				cssDir: "assets/css",
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
				"assets/css/folio.css": "assets/css/folio.css"
			}
		},
		flash: {
			files: {
				"assets/css/flash.css": "assets/css/flash.css"
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

	/*
	 * jshint: code quality check
	 */
	grunt.loadNpmTasks("grunt-contrib-jshint"); // JavaScript
	config.jshint = {
		options: {
			jshintrc: ".jshintrc"
		},
		files: [
			"assets/src/js/app/**/*.js"
		]
	};

	/**
	 * browserify
	 */
	grunt.loadNpmTasks("grunt-browserify");
	config.browserify = {
		vendor: {
			src: [],
			dest: "assets/js/vendor.js",
			options: {
				browserifyOptions: {
					debug: false,
				}
			}
		},
		client: {
			dest: "./assets/js/folio.js",
			src: [
				"./assets/src/js/app/App.js", //, "assets/src/js/app/**/*.js", "assets/src/js/app/**/*.tpl"
			],
			options: {
				watch: true,
				browserifyOptions: {
					// baseDir: "./assets/src/js",
					fullPaths: false,
					debug: true,
				},
				transform: [
					"node-underscorify"
				],
			}
		}
	};

	var vendor = config.browserify.vendor.options.require = [
		"jquery", "hammerjs", "jquery-hammerjs", "velocity-animate",
		"underscore", "backbone", "backbone.babysitter",
		"backbone.select", "backbone.cycle", "backbone-view-options"
	];
	config.browserify.vendor.options.alias = [
		"./bower_components/backbone.picky/lib/amd/backbone.picky.js:backbone.picky"
	];
	config.browserify.client.options.external = vendor.concat([
		"backbone.picky"
	]);

	/*
	 * Watch tasks
	 */
	grunt.loadNpmTasks("grunt-contrib-watch"); // Workflow
	config.watch = {
		options: {
			livereload: false
		},
		js: {
			files: ["assets/js/folio.js", "assets/src/js/**/*.js", "assets/src/js/**/*.tpl"],
			tasks: ["jshint"]
		},
		styles: {
			files: ["assets/src/sass/**/*.scss"],
			tasks: ["compass:debug", "autoprefixer:styles"]
		}
	};

	grunt.initConfig(config);

	grunt.registerTask("install", ["bower-install-simple", "bowercopy", "browserify:vendor"]);
	grunt.registerTask("buildWatch", ["browserify:vendor", "browserify:client", "watch"]);
	grunt.registerTask("buildScripts", ["browserify:vendor", "jshint", "browserify:client"]);
	grunt.registerTask("buildStyles", ["compass:debug", "autoprefixer:styles"]);
	// grunt.registerTask("debug", 		[ "compass:debug", "autoprefixer:styles", "jshint", "cjsc:debug" ]);
	// grunt.registerTask("dist", 		[ "compass:dist", "autoprefixer:styles", "jshint", "cjsc:dist"]);

	grunt.registerTask("buildAll", ["buildStyles", "buildScripts"]);
	grunt.registerTask("default", ["buildWatch"]);
};
