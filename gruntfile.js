/*global module*/
module.exports = function (grunt) {
	"use strict";

	// Worflow
	grunt.loadNpmTasks("grunt-contrib-watch");
	// grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks("grunt-bower-install-simple");
	grunt.loadNpmTasks("grunt-bowercopy");
	// Sass
	grunt.loadNpmTasks("grunt-contrib-compass");
	// CSS
	grunt.loadNpmTasks("grunt-contrib-concat");
	grunt.loadNpmTasks("grunt-autoprefixer");
	grunt.loadNpmTasks("grunt-csso");
	// JavaScript
	grunt.loadNpmTasks("grunt-contrib-jshint");
	grunt.loadNpmTasks("grunt-contrib-cjsc");
	// grunt.loadNpmTasks("grunt-contrib-jscs");

	grunt.initConfig({
		pkg: grunt.file.readJSON("package.json"),

		/*
		 * Sass:
		 * Using Compass compiler (requires gem)
		 */
		compass: {
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
		},

		/*
		 * CSS:
		 * Concatenate, add prefixes (-moz-, -webkit-, etc.)
		 * and optimize/minimize
		 */
		concat: {
			flash: {
				files: { "./assets/css/flash.css": [
						"./assets/src/css/reset.css",
						"./assets/src/css/flash.css"
					]
				}
			}
		},
		autoprefixer: {
			styles: {
				files: { "./assets/css/folio.css": "./assets/css/folio.css" }
			},
			flash: {
				files: { "./assets/css/flash.css": "./assets/css/flash.css" }
			}
		},
		csso: {
			styles: {
				files: { "./assets/css/folio.min.css": "./assets/css/folio.css" }
			},
			flash: {
				files: { "./assets/css/flash.min.css": "./assets/css/flash.css" }
			}
		},

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
				}
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
				"./assets/src/js/**/**/*.js"
			]
		},
		// jscs: {
		// 	dist: {
		// 		options: {
		// 			standard: "Jquery"
		// 		},
		// 		files: {
		// 			src: [ "./assets/src/js" ]
		// 		}
		// 	},
		// 	test: {
		// 		options: {
		// 			standard: "Jquery",
		// 			reportFull: true
		// 		},
		// 		files: {
		// 			src: [ "./assets/src/js" ]
		// 		}
		// 	}
		// },
		cjsc: {
			debug: {
				options: {
					sourceMap: "./assets/js/*.map",
					sourceMapRoot: "../src/js/app/",
					minify: false,
					config: {
						"jquery"      : { "globalProperty": "$" },
						"hammerjs"    : { "globalProperty": "Hammer" },
						"underscore"  : { "globalProperty": "_" },
						"backbone"    : { "globalProperty": "Backbone" }
					}
				 },
				 files: {
						"./assets/js/folio.js": "./assets/src/js/app/App.js"
				 }
			 },
			 dist: {
				options: {
					debug: false,
					minify: true,
					banner: "/*! <%= pkg.name %> - v<%= pkg.version %> - " +
								"<%= grunt.template.today(\"yyyy-mm-dd\") %> */",
					config: {
						"jquery"      : { "globalProperty": "$" },
						"hammerjs"    : { "globalProperty": "Hammer" },
						"underscore"  : { "globalProperty": "_" },
						"backbone"    : { "globalProperty": "Backbone" }
					}
				 },
				 files: {
					"./assets/js/folio.min.js": "./assets/src/js/app/App.js"
				 }
			 }
		},

		watch: {
			options: {
				livereload: false
			},
			js: {
				files: [ "./assets/src/js/**/*.js", "./assets/src/js/**/**/**/*.tpl" ],
				tasks: [ "jshint", "cjsc:debug" ]
			},
			styles: {
				files: [ "./assets/src/sass/**/*.scss" ],
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
		"cjsc:dist"
	]);

	grunt.registerTask("test", [
		"jshint",
//		"jscs:test",
	]);

	grunt.registerTask("default", ["debug"]);
};
