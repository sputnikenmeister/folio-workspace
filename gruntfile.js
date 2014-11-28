/*global module*/
module.exports = function (grunt) {
	"use strict";

	// grunt.initConfig({});
	grunt.config("pkg", grunt.file.readJSON("package.json"));

	/*
	 * Sass: Using Compass compiler (requires gem)
	 */
	grunt.loadNpmTasks("grunt-contrib-compass");
	grunt.config("compass.options", {
		sourcemap		: true,
		outputStyle		: "compressed",
		sassDir			: "assets/src/sass",
		cssDir			: "assets/css",
		imagesDir		: "assets/images",
		fontsDir		: "assets/fonts",
		javascriptsDir	: "assets/js",
		httpPath		: "/workspace",
	});
	grunt.config("compass.client.options.specify", "assets/src/sass/folio.scss");

	/*
	 * CSS prefixes (-moz-, -webkit-, etc.)
	 */
	grunt.loadNpmTasks("grunt-autoprefixer");
	grunt.config("autoprefixer.options", { map: true });// { inline: false } });
	grunt.config("autoprefixer.client.files", { "assets/css/folio.css": "assets/css/folio.css" });
	// grunt.config("autoprefixer.flash.files", { "assets/css/flash.css": "assets/css/flash.css"});

	/* --------------------------------
	 * Javascript
	 * -------------------------------- */

	/*
	 * jshint: code quality check
	 */
	grunt.loadNpmTasks("grunt-contrib-jshint");
	grunt.config("jshint", {
		options: {
			jshintrc: ".jshintrc"
		},
		files: [
			"./assets/src/js/app/**/*.js"
		]
	});

	/*
	 * browserify
	 */
	grunt.loadNpmTasks("grunt-browserify");
	grunt.config("browserify", {
		"vendor": {
			dest: "assets/js/vendor.js",
			src: [],
			options: {
				browserifyOptions: {
					debug: true
				},
			}
		},
		"client": {
			dest: "./assets/js/folio.js",
			src: [
				"./assets/src/js/app/App.js"
			],
			options: {
				browserifyOptions: {
					// baseDir: "./assets",
					fullPaths: false,
					debug: true,
				},
				transform: [
					"node-underscorify"
				]
			}
		}
	});

	var vendorRequires = [
		"jquery",
		"underscore",
		"backbone",
		"hammerjs",
		"jquery-hammerjs",
		"jquery.transit",
		"backbone.babysitter",
		"backbone.select",
		"backbone.cycle",
	];
	// Vendor requires as externals
	grunt.config("browserify.vendor.options.require", vendorRequires);
	grunt.config("browserify.client.options.external", vendorRequires.concat(["jquery-color", "backbone.picky"]));
	// Duplicate browserify.client task for watch
	grunt.config("browserify.watchable", grunt.config("browserify.client"));
	grunt.config("browserify.watchable.options.watch", true);
	// DEBUG: check config result
	// grunt.file.write("./build/grunt-browserify.config.json", JSON.stringify(grunt.config.get()));

	/*
	 * browserify bower
	 */
	grunt.loadNpmTasks("grunt-browserify-bower");
	grunt.config("browserifyBower.vendor", {
		options: {
			file: "./assets/js/vendor-bower.js",
			forceResolve: {
				"backbone.picky": "lib/backbone.picky.js",
				"jquery-color": "jquery.color.js"
			}
		}
	});

	/*
	 * Extract source maps
	 */
	grunt.loadNpmTasks("grunt-exorcise");
	grunt.config("exorcise", {
		options: {
			root: "/workspace/"
		},
		"vendor": {
			files: {
				"assets/js/vendor.js.map": ["assets/js/vendor.js"]
			}
		},
		"client": {
			files: {
				"assets/js/folio.js.map": ["assets/js/folio.js"]
			}
		},
	});

	/*
	 * Uglyfy
	 */
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.config("uglify", {
		"vendor": {
			options: {
				mangle: false,
				sourceMap: true,
				sourceMapIn: "assets/js/vendor.js.map"
			},
			files: {
				"assets/js/vendor.min.js": ["assets/js/vendor.js"]
			}
		},
		"client": {
			options: {
				mangle: true,
				sourceMap: true,
				sourceMapIn: "assets/js/folio.js.map"
			},
			files: {
				"assets/js/folio.min.js": ["assets/js/folio.js"]
			}
		},
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
		"reload-config": {
			files: ["gruntfile.js"],
		},
		"process-sources": {
			files: ["assets/src/js/**/*.js"],
			tasks: ["jshint"]
		},
		"process-build": {
			tasks: ["exorcise:client"],
			files: ["assets/js/folio.js"],
			// options: { livereload: false }
		},
		"styles": {
			files: ["assets/src/sass/**/*.scss"],
			tasks: ["compass:client", "autoprefixer:client"]
		},
	});

	// Other
	grunt.registerTask("buildBower", 	["browserifyBower:vendor", "buildVendor"]);
	// Watch build
	grunt.registerTask("buildWatch", 	["browserify:watchable", "watch"]);
	grunt.registerTask("sublimeWatch", 	["buildWatch"]);
	// Simple build
	grunt.registerTask("buildVendor", 	["browserifyBower:vendor", "browserify:vendor", "exorcise:vendor", "uglify:vendor"]);
	grunt.registerTask("buildClient", 	["jshint", "browserify:client", "exorcise:client", "uglify:client"]);
	grunt.registerTask("buildScripts", 	["buildVendor","buildClient"]);

	grunt.registerTask("buildStyles", 	["compass:client", "autoprefixer:client"]);
	grunt.registerTask("build", 		["buildStyles", "buildScripts"]);
	// Default task
	grunt.registerTask("default", 		["build"]);

};
