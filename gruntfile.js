/*global module*/
module.exports = function (grunt) {
	"use strict";

	// grunt.initConfig({});
	grunt.config("pkg", grunt.file.readJSON("package.json"));


	/*
	 * Install
	 */
	// grunt.loadNpmTasks("grunt-fontello");
	// grunt.config("fontello",
	// {
	// 	install: {
	// 		options: {
	// 			config  : "./fontello.json",
	// 			zip		: "./build/fontello-grunt",
	// 			fonts   : "./assets/fonts/fontello-grunt/fonts",
	// 			styles  : "./assets/fonts/fontello-grunt/sass",
	// 			scss    : true,
	// 			force   : true,
	// 		}
	// 	}
	// });
	// grunt.loadNpmTasks("grunt-bower-install-simple");
	// grunt.config("bower-install-simple",
	// {
	// 	install: {
	// 		options: {
	// 			production: false,
	// 			clean: false
	// 		}
	// 	}
	// });
	// grunt.loadNpmTasks("grunt-browserify-bower");
	// grunt.config("browserifyBower",
	// {
	// 	vendor: {
	// 		options: {
	// 			forceResolve: {
	// 				"backbone.picky": "lib/backbone.picky.js"
	// 			}
	// 		}
	// 	}
	// });

	/*
	 * Sass: Using Compass compiler (requires gem)
	 */
	grunt.loadNpmTasks("grunt-contrib-compass");
	grunt.config("compass",
	{
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
	});

	/*
	 * CSS prefixes (-moz-, -webkit-, etc.)
	 */
	grunt.loadNpmTasks("grunt-autoprefixer");
	grunt.config("autoprefixer",
	{
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
	});

	/*
	 * jshint: code quality check
	 */
	grunt.loadNpmTasks("grunt-contrib-jshint");
	grunt.config("jshint",
	{
		options: {
			jshintrc: ".jshintrc"
		},
		files: [
			"./assets/src/js/app/**/*.js"
		]
	});

	/**
	 * browserify
	 */
	// var scriptBaseDir = "./assets/src/js";
	grunt.loadNpmTasks("grunt-browserify");
	grunt.config("browserify",
	{
		vendor: {
			dest: "./assets/js/vendor.js", src: [],
			options: {
				browserifyOptions: { debug: false },
			}
		},
		client: {
			dest: "./assets/js/folio.js",
			src: [
				"./assets/src/js/app/App.js",
				// "./assets/src/js/app/**/*.js",
				// "./assets/src/js/app/**/*.tpl"
			],
			options: {
				browserifyOptions: { fullPaths: false, debug: true },
				transform: [ "node-underscorify" ],
			}
		}
	});

	var vendorRequires = [
		"jquery", "hammerjs", "jquery-hammerjs", "velocity-animate",
		"underscore", "backbone", "backbone.babysitter",
		"backbone.select", "backbone.cycle",
		"backbone-view-options"
	];
	// Vendor requires
	grunt.config("browserify.vendor.options.require", vendorRequires);

	// In clase we need backbone.picky
	// grunt.config("browserify.vendor.options.alias", ["./bower_components/backbone.picky/lib/amd/backbone.picky.js:backbone.picky"]);
	// var clientExternals = vendorRequires.concat(["backbone.picky"]);
	var clientExternals = vendorRequires.concat();
	// Client externals
	grunt.config("browserify.client.options.external", clientExternals);
	// Duplicate browserify.client task for watch
	grunt.config("browserify.watchable", grunt.config("browserify.client"));
	grunt.config("browserify.watchable.options.watch", true);

	// DEBUG: check config result
	// grunt.file.write("./build/grunt-browserify-config.json", JSON.stringify(grunt.config.get()));

	/*
	 * Extract source maps
	 */
	grunt.loadNpmTasks("grunt-exorcise");
	grunt.config("exorcise", {
		client: {
			files: {
				"./assets/js/folio.map": ["./assets/js/folio.js"],
			}
		}
	});

	/*
	 * Watch tasks
	 */
	grunt.loadNpmTasks("grunt-contrib-watch"); // Workflow
	grunt.config("watch", {
		options: {
			livereload: false,
			spawn: false,
			forever: true
		},
		config: {
			files: ["./gruntfile.js"],
		},
		jshint: {
			files: ["./gruntfile.js", "./assets/src/js/**/*.js"],
			tasks: ["jshint"]
		},
		scripts: {
			tasks: ["exorcise:client"],
			files: ["./assets/js/folio.js"],
			options: {
				livereload: false
			}
		},
		styles: {
			files: ["./assets/src/sass/**/*.scss"],
			tasks: ["compass:debug", "autoprefixer:styles"]
		}
	});

	// Install
	// grunt.registerTask("install", 		["bower-install-simple", "browserify:vendor"]);
	// Watch build
	grunt.registerTask("buildWatch", 	["browserify:vendor", "browserify:watchable", "exorcise:client", "watch"]);
	grunt.registerTask("sublimeWatch", 	["buildWatch"]);
	// Simple build
	grunt.registerTask("buildScripts", 	["jshint", "browserify:vendor", "browserify:client", "exorcise:client"]);
	grunt.registerTask("buildStyles", 	["compass:debug", "autoprefixer:styles"]);
	grunt.registerTask("build", 		["buildStyles", "buildScripts"]);
	// Default task
	grunt.registerTask("default", 		["build"]);
};
