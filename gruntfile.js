/*global module*/
module.exports = function (grunt) {
	"use strict";

	grunt.loadNpmTasks("grunt-contrib-watch");			// Workflow
	grunt.loadNpmTasks("grunt-bower-install-simple");	// Dependencies
	grunt.loadNpmTasks("grunt-contrib-compass");		// Sass
	grunt.loadNpmTasks("grunt-autoprefixer");			// CSS
	grunt.loadNpmTasks("grunt-contrib-jshint");			// JavaScript
	grunt.loadNpmTasks("grunt-browserify");

	grunt.initConfig({
		pkg: grunt.file.readJSON("package.json"),

		/*
		 * Sass: Using Compass compiler (requires gem)
		 */
		compass: {
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
		},

		/*
		 * CSS prefixes (-moz-, -webkit-, etc.)
		 */
		autoprefixer: {
			styles: {
				files: { "assets/css/folio.css": "assets/css/folio.css" }
			},
			flash: {
				files: { "assets/css/flash.css": "assets/css/flash.css" }
			}
		},

		/*
		 * jshint: code quality check
		 */
		jshint: {
			options: {
				jshintrc: ".jshintrc"
			},
			files: [
				"assets/src/js/app/**/*.js"
			]
		},

		/*
		 * bower dependencies
		 */
		"bower-install-simple": {
			options: {
				color: true,
				directory: ".bower_components"
			},
			dev: {
				options: {
					production: false,
					clean: false
				}
			}
		},

		browserify: {
			vendor: {
				src: [],
				dest: "assets/js/vendor.js",
				options: {
					 browserifyOptions: {
					 	debug: false,
					 },
					require: [
						"jquery", "hammerjs", "velocity-animate",
						"underscore", "backbone", "backbone.babysitter", "backbone.select", "backbone.cycle",
					],
					alias: [
						"./.bower_components/backbone.picky/lib/amd/backbone.picky.js:backbone.picky",
					]
				}
			},
			client: {
				dest: "./assets/js/folio.js",
				src: [
					"./assets/src/js/app/App.js",
					// "assets/src/js/app/**/*.js",
					// "assets/src/js/app/**/*.tpl"
				],
				options: {
					watch: true,
					browserifyOptions: {
						baseDir: "./assets/src/js",
						fullPaths: false,
						debug: true,
					},
					ignore: [
						"./assets/src/js/app/control/AppModel.js"
					],
					transform: [
						"node-underscorify",
						// "uglifyify"
					],
					external: [
						"jquery", "hammerjs", "velocity-animate",
						"underscore", "backbone", "backbone.babysitter", "backbone.select", "backbone.cycle",
						"backbone.picky",
					]
				}
			}
		},

		/*
		 * Watch tasks
		 */
		watch: {
			options: {
				livereload: false
			},
			js: {
				files: [ "assets/js/folio.js", "assets/src/js/**/*.js", "assets/src/js/**/*.tpl" ],
				tasks: [ "jshint" ]
			},
			styles: {
				files: [ "assets/src/sass/**/*.scss" ],
				tasks: [ "compass:debug", "autoprefixer:styles" ]
			}
		},
	});

	grunt.registerTask("install", 		[ "bower-install-simple", "bowercopy" ]);
	grunt.registerTask("debugWatch",	[ "browserify:vendor", "browserify:client", "watch"]);
	// grunt.registerTask("debug", 		[ "compass:debug", "autoprefixer:styles", "jshint", "cjsc:debug"]);
	// grunt.registerTask("dist", 		[ "compass:dist", "autoprefixer:styles", "jshint", "cjsc:dist"]);

	grunt.registerTask("default", ["debugWatch"]);
};
