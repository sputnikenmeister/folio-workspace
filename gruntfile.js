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
		options: {
			sourcemap: true,
			sassDir: "assets/src/sass",
			cssDir: "assets/css",
			imagesDir: "assets/images",
			fontsDir: "assets/fonts",
			javascriptsDir: "assets/js",
			httpPath: "/workspace",
		},
		build: {
			options: {
				outputStyle: "compressed",
			}
		},
		client: {
			options: {
				specify: "assets/src/sass/folio.scss",
				outputStyle: "compressed",
				force: true
			}
		},
		backend: {
			options: {
				specify: "assets/src/sass/symphony.scss",
				outputStyle: "compressed",
				force: true
			}
		}
	});

	/*
	 * CSS prefixes (-moz-, -webkit-, etc.)
	 */
	grunt.loadNpmTasks("grunt-autoprefixer");
	grunt.config("autoprefixer",
	{
		options: {
			map: true// { inline: false }
		},
		client: {
			files: {
				"assets/css/folio.css": "assets/css/folio.css"
			}
		},
		backend: {
			files: {
				"assets/css/symphony.css": "assets/css/symphony.css"
			}
		},
		flash: {
			files: {
				"assets/css/flash.css": "assets/css/flash.css"
			}
		}
	});

	/* --------------------------------
	 * Javascript
	 * -------------------------------- */

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
			"./grunfile.js",
			"./assets/src/js/app/**/*.js"
		]
	});

	/*
	 * browserify
	 */
	grunt.loadNpmTasks("grunt-browserify");
	grunt.config("browserify", {
		vendor: {
			dest: "assets/js/vendor.js",
			src: [],
			options: {
				browserifyOptions: {
					debug: true
				},
			}
		},
		client: {
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
		"jquery", "underscore", "backbone",
		"hammerjs", "jquery-hammerjs",
		"velocity-animate",
		"jquery.transit",
		"backbone.babysitter",
		"backbone.select", "backbone.cycle",
		// "backbone-view-options",
		// "backbone.picky",
	];
	// Vendor requires
	grunt.config("browserify.vendor.options.require", vendorRequires);

	var clientExternals = vendorRequires.concat();
	// In case we need backbone.picky
	if (vendorRequires.indexOf("backbone.picky") >= 0) {
		clientExternals.push("backbone.picky");
		grunt.config("browserify.vendor.options.alias",
			["./bower_components/backbone.picky/lib/amd/backbone.picky.js:backbone.picky"]);
	}
	// Client externals
	grunt.config("browserify.client.options.external", clientExternals);
	// Duplicate browserify.client task for watch
	grunt.config("browserify.watchable", grunt.config("browserify.client"));
	grunt.config("browserify.watchable.options.watch", true);

	// DEBUG: check config result
	// grunt.file.write("./build/grunt-browserify.config.json", JSON.stringify(grunt.config.get()));

	/*
	 * Extract source maps
	 */
	grunt.loadNpmTasks("grunt-exorcise");
	grunt.config("exorcise", {
		options: {
			root: "/workspace/"
		},
		vendor: {
			files: {
				"assets/js/vendor.js.map": ["assets/js/vendor.js"]
			}
		},
		client: {
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
		vendor: {
			options: {
				mangle: false,
				sourceMap: true,
				sourceMapIn: "assets/js/vendor.js.map"
			},
			files: {
				"assets/js/vendor.min.js": ["assets/js/vendor.js"]
			}
		},
		client: {
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
			files: ["./assets/src/sass/**/*.scss"], tasks: ["compass:build"]
		},
		clientStyles: {
			files: ["./assets/css/folio.css"], tasks: ["autoprefixer:client"]
		},
		backendStyles: {
			files: ["./assets/css/symphony.css"], tasks: ["autoprefixer:backend"]
		}
	});

	// Install
	// grunt.registerTask("install", 	["bower-install-simple", "browserify:vendor"]);
	// Watch build
	grunt.registerTask("buildWatch", 	["browserify:watchable", "watch"]);
	grunt.registerTask("sublimeWatch", 	["buildWatch"]);
	// Simple build
	grunt.registerTask("buildStyles", 	["compass:build", "autoprefixer:client", "autoprefixer:backend"]);
	grunt.registerTask("buildVendor", 	["browserify:vendor", "exorcise:vendor", "uglify:vendor"]);
	grunt.registerTask("buildClient", 	["jshint", "browserify:client", "exorcise:client", "uglify:client"]);
	grunt.registerTask("buildScripts", 	["buildVendor","buildClient"]);
	grunt.registerTask("build", 		["buildStyles", "buildScripts"]);
	// Default task
	grunt.registerTask("default", 		["build"]);
};
