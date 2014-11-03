/*global module*/
module.exports = function (grunt) {
	"use strict";

	grunt.loadNpmTasks("grunt-contrib-watch");			// Workflow
	grunt.loadNpmTasks("grunt-contrib-concat");
	// grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks("grunt-bower-install-simple");	// Dependencies
	grunt.loadNpmTasks("grunt-bowercopy");
	grunt.loadNpmTasks("grunt-contrib-compass");		// Sass
	grunt.loadNpmTasks("grunt-autoprefixer");			// CSS
	grunt.loadNpmTasks("grunt-csso");
	grunt.loadNpmTasks("grunt-contrib-jshint");			// JavaScript
	grunt.loadNpmTasks("grunt-contrib-cjsc");
	// grunt.loadNpmTasks('grunt-browserify');
	// grunt.loadNpmTasks("grunt-contrib-jscs");

	grunt.initConfig({
		pkg: grunt.file.readJSON("package.json"),

		/*
		 * Bower dependencies
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

		bowercopy: {
			options: {
				srcPrefix: ".bower_components"
			},
			libs: {
				options: {
					destPrefix: "assets/lib"
				},
				files: {
					"jquery.js"			: "jquery/dist/jquery.js",
					"hammer.js"			: "hammerjs/hammer.js",
					"underscore.js"		: "underscore/underscore.js",
					"backbone.js"		: "backbone/backbone.js",
					"backbone.babysitter.js"		: "backbone.babysitter/lib/backbone.babysitter.js",
				}
			}
		},

		/*
		 * Sass:
		 * Using Compass compiler (requires gem)
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
		 * CSS:
		 * Concatenate, add prefixes (-moz-, -webkit-, etc.)
		 * and optimize/minimize
		 */
		concat: {
			flash: {
				files: { "assets/css/flash.css": [
						"assets/src/css/reset.css",
						"assets/src/css/flash.css"
					]
				}
			}
		},
		autoprefixer: {
			styles: {
				files: { "assets/css/folio.css": "assets/css/folio.css" }
			},
			flash: {
				files: { "assets/css/flash.css": "assets/css/flash.css" }
			}
		},
		csso: {
			styles: {
				files: { "assets/css/folio.min.css": "assets/css/folio.css" }
			},
			flash: {
				files: { "assets/css/flash.min.css": "assets/css/flash.css" }
			}
		},

		/*
		 * JavaScript:
		 * jshint: code quality check
		 * jscs: code style check
		 * cjsc: CommonJS compile
		 */
		jshint: {
			options: {
				jshintrc: ".jshintrc"
			},
			files: [
				"assets/src/js/**/**/*.js"
			]
		},
		jscs: {
			dist: {
				options: {
					standard: "Jquery",
					reportFull: true
				},
				files: {
					src: [ "assets/src/js" ]
				}
			}
		},
		cjsc: {
			debug: {
				options: {
					sourceMap: "assets/js/*.map",
					sourceMapRoot: "../src/js/app",
					minify: false,
					config: {
						"jquery"      : { "globalProperty": "$" },
						"hammerjs"    : { "globalProperty": "Hammer" },
						"underscore"  : { "globalProperty": "_" },
						"backbone"    : { "globalProperty": "Backbone" }
					}
				 },
				 files: {
						"assets/js/folio.js": "assets/src/js/app/App.js"
				 }
			 },
			 dist: {
				options: {
					debug: false,
					minify: true,
					banner: "/*! <%= pkg.name %> - v<%= pkg.version %> - " +
								"<%= grunt.template.today(\"yyyy-mm-dd\") %> */",
					config: {
						"jquery"      : { "path": "assets/lib/jquery" },
						"hammerjs"    : { "path": "assets/lib/hammer.js" },
						"underscore"  : { "path": "assets/lib/underscore.js" },
						"backbone"    : { "path": "assets/lib/backbone.js" },
						// "backbone.babysitter"    : { "path": "assets/lib/backbone.babysitter.js" },
					}
				 },
				 files: {
					"assets/js/folio.min.js": "assets/src/js/app/App.js"
				 }
			 }
		},

		// browserify: {
		// 	// vendor: {
		// 	// 	src: [],
		// 	// 	dest: 'assets/js/bsrfy.vendor.js',
		// 	// 	options: {
		// 	// 		require: ['jquery'],
		// 	// 		alias: [
		// 	// 			'./lib/moments.js:momentWrapper', //can alias file names
		// 	// 			'events:evt' //can alias modules
		// 	// 		]
		// 	// 	}
		// 	// },
		// 	client: {
		// 		src: ['assets/src/js/**/*.js'],
		// 		dest: 'assets/js/folio.js',
		// 		options: {
		// 			external: ['jquery', 'hammerjs', 'underscore', 'backbone'],
		// 		}
		// 	}
		// },
		/*
		 * Watch tasks
		 */
		watch: {
			options: {
				livereload: false
			},
			js: {
				files: [ "assets/src/js/**/*.js", "assets/src/js/**/**/**/*.tpl" ],
				tasks: [ "jshint", "cjsc:debug" ]
			},
			styles: {
				files: [ "assets/src/sass/**/*.scss" ],
				tasks: [ "compass:debug", "autoprefixer:styles" ]
			}
		},
	});

	grunt.registerTask("install", [
		"bower-install-simple",
		"bowercopy"
	]);

	grunt.registerTask("css-flash", [
		"concat:flash",
		"autoprefixer:flash",
		"csso:flash"
	]);

	grunt.registerTask("debug", [
		"compass:debug",
		"autoprefixer:styles",
		"jshint",
		"cjsc:debug"
	]);

	grunt.registerTask("dist", [
		"compass:dist",
		"autoprefixer:styles",
		"csso:styles",
		"jshint",
//		"jscs:dist",
		"cjsc:dist"
	]);

	grunt.registerTask("default", ["debug"]);
};
