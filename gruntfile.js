/*global module*/
module.exports = function (grunt) {
	"use strict";
	
	// CSS
	grunt.loadNpmTasks("grunt-contrib-concat");
	grunt.loadNpmTasks("grunt-autoprefixer");
	grunt.loadNpmTasks("grunt-csso");
	
	// Sass
	grunt.loadNpmTasks("grunt-contrib-compass");
	
	// JavaScript
	grunt.loadNpmTasks("grunt-contrib-jshint");
	grunt.loadNpmTasks("grunt-contrib-jscs");
	grunt.loadNpmTasks("grunt-contrib-cjsc");
	
	// Worflow
	grunt.loadNpmTasks("grunt-contrib-watch");
	
	
	var cssSrcFiles = [
			"./assets/css/src/folio.elements.css",
			"./assets/css/src/folio.typography.css",
			"./assets/css/src/folio.layout.css",
			"./assets/css/src/folio.buttons.css",
	];
//	var flashCssTarget = {
//		"./assets/css/flash.css": "./assets/css/src/flash.css"
//	};

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
					sassDir: "./assets/css/sass",
					cssDir: "./assets/css",
					outputStyle: "compressed"
				}
			},
			debug: {
				options: {
					sassDir: "./assets/css/sass",
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
				files: { "./assets/css/folio.css": cssSrcFiles }
			}
		},
		autoprefixer: {
			css: {
				files: { "./assets/css/folio.css": "./assets/css/folio.css" }
			}
		},
		csso: {
			css: {
				files: { "./assets/css/folio.min.css": "./assets/css/folio.css" }
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
				"./assets/js/src/**/**/*.js"
			]
		},
		jscs: {
			dist: {
				options: {
					standard: "Jquery"
				},
				files: {
					src: [ "./assets/js/src" ]
				}
			},
			test: {
				options: {
					standard: "Jquery",
					reportFull: true
				},
				files: {
					src: [ "./assets/js/src" ]
				}
			}
		},
		cjsc: {
			debug: {
				options: {
					sourceMap: "./assets/js/*.map",
					sourceMapRoot: "./src/app/",
					minify: false,
					config: {
						"jquery": {
							"globalProperty": "$"
						},
						"underscore": {
							"globalProperty": "_"
						},
						"backbone": {
							"globalProperty": "Backbone"
						}
					}
				 },
				 files: {
				 		"./assets/js/app-cjsc.js": "./assets/js/src/app/App.js"
				 }
			 },
			 dist: {
				options: {
					debug: false,
					minify: true,
					banner: "/*! <%= pkg.name %> - v<%= pkg.version %> - " +
								"<%= grunt.template.today(\"yyyy-mm-dd\") %> */",
					config: {
						"jquery": {
							"globalProperty": "$"
						},
						"underscore": {
							"globalProperty": "_"
						},
						"backbone": {
							"globalProperty": "Backbone"
						}
					}
				 },
				 files: {
						"./assets/js/app-cjsc.min.js": "./assets/js/src/app/App.js"
				 }
			 }
		},

		watch: {
			options: {
				livereload: false
			},
			js: {
				files: [ "./assets/js/src/**/*.js" ],
				tasks: [ "cjsc:debug" ]
			},
			styles: {
				files: [ "./assets/css/sass/**/*.scss" ],
				tasks: [ "compass:debug", "autoprefixer" ]
			}
		},
	});
	
	grunt.registerTask("debug",[
//		"concat",
		"compass:debug",
		"autoprefixer",
		"cjsc:debug"
	]);
	
	grunt.registerTask("dist", [
//		"concat",
		"compass:dist",
		"autoprefixer",
		"csso",
		"jshint",
		"jscs:test",
		"cjsc:dist" 
	]);
	
	grunt.registerTask("default", ["debug"]);
//	grunt.registerTask("default", ["dist"]);
};



