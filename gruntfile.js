/*global module*/
module.exports = function (grunt) {
	"use strict";

	// Worflow
	// grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks("grunt-contrib-watch");
	// Sass
	grunt.loadNpmTasks("grunt-contrib-compass");
	// CSS
	grunt.loadNpmTasks("grunt-contrib-concat");
	grunt.loadNpmTasks("grunt-autoprefixer");
	grunt.loadNpmTasks("grunt-csso");
	// JavaScript
	grunt.loadNpmTasks("grunt-contrib-jshint");
	// grunt.loadNpmTasks("grunt-contrib-jscs");
	grunt.loadNpmTasks("grunt-contrib-cjsc");


	var flashCssSource = "./assets/src/css/flash.css";
	var flashCssTarget = { "./assets/css/flash.css": flashCssSource };

	// grunt.file.setBase('.');

	grunt.initConfig({

		pkg: grunt.file.readJSON("package.json"),

		/*
		 * Sass:
		 *
		 * Using Compass compiler (requires gem)
		 */
		compass: {
			dist: {
				options: {
					sassDir: "./assets/src/sass",
					cssDir: "./assets/css",
					outputStyle: "compressed"
				}
			},
			debug: {
				options: {
					sassDir: "./assets/src/sass",
					cssDir: "./assets/css"
				}
			}
		},

		/*
		 * CSS:
		 *
		 * Concatenate, add prefixes (-moz-, -webkit-, etc.)
		 * and optimize/minimize
		 */
		concat: {
			css: {
				files: {
					"./assets/css/folio.css": [
						"./assets/src/css/folio.elements.css",
						"./assets/src/css/folio.typography.css",
						"./assets/src/css/folio.layout.css",
						"./assets/src/css/folio.buttons.css",
					]
				}
			},
			flash: {
				files: { "./assets/css/flash.css": "./assets/src/css/flash.css" }
			}
		},
		autoprefixer: {
			css: {
				files: { "./assets/css/folio.css": "./assets/css/folio.css" }
			},
			flash: {
				files: { "./assets/css/flash.css": "./assets/css/flash.css" }
			}
		},
		csso: {
			css: {
				files: { "./assets/css/folio.min.css": "./assets/css/folio.css" }
			},
			flash: {
				files: { "./assets/css/flash.min.css": "./assets/css/flash.css" }
			}
		},

		/*
		 * JavaScript:
		 *
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
						"jquery": { "globalProperty": "$" },
						"hammerjs": { "globalProperty": "Hammer" },
						"underscore": { "globalProperty": "_" },
						"backbone": { "globalProperty": "Backbone" }
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
						"jquery": { "globalProperty": "$" },
						"hammerjs": { "globalProperty": "Hammer" },
						"underscore": { "globalProperty": "_" },
						"backbone": { "globalProperty": "Backbone" }
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
				files: [ "./assets/src/js/**/*.js", "./assets/src/js/**/*.tpl" ],
				tasks: [ "jshint", "cjsc:debug" ]
			},
			styles: {
				files: [ "./assets/src/sass/**/*.scss" ],
				tasks: [ "compass:debug", "autoprefixer:css" ]
			}
		},
	});

	grunt.registerTask("css-flash", [
		"concat:flash",
		"autoprefixer:flash",
		"csso:flash"
	]);

	grunt.registerTask("debug", [
		"compass:debug",
		"autoprefixer:css",
		"jshint",
		"cjsc:debug"
	]);

	grunt.registerTask("dist", [
		"compass:dist",
		"autoprefixer:css",
		"csso:css",
		"jshint",
		"cjsc:dist"
	]);

	grunt.registerTask("test", [
		"jshint",
//		"jscs:test",
	]);

	grunt.registerTask("default", ["debug"]);
};
