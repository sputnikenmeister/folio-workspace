/*global module*/
module.exports = function (grunt) {
	"use strict";
	
	grunt.loadNpmTasks("grunt-contrib-jshint");
	grunt.loadNpmTasks("grunt-contrib-jscs");
	grunt.loadNpmTasks("grunt-contrib-watch");
	grunt.loadNpmTasks("grunt-contrib-compass");
	grunt.loadNpmTasks("grunt-contrib-cjsc");
	grunt.loadNpmTasks("grunt-contrib-concat");
	grunt.loadNpmTasks("grunt-autoprefixer");
	grunt.loadNpmTasks("grunt-csso");
	
	var cssFiles = {
		"./assets/css/folio.min.css": [
			"./assets/css/src/folio.css",
			"./assets/css/src/folio.xhtml.css"
		]
	};
	var flashCssFiles = {
		"./assets/css/flash.min.css": [
			"./assets/css/flash.css"
		]
	};

	grunt.initConfig({
	
		pkg: grunt.file.readJSON("package.json"),
		
		// Concatenate CSS files
		concat: {
			dist: {
				files: cssFiles,
			},
		},
		
		// Add CSS property prefixes (-moz-prop, -webkit-prop, etc.)
		autoprefixer: {
			styles: {
				files: cssFiles,
			}
		},

		// Optimize (minimize) CSS
		csso: {
			styles: {
				files: cssFiles,
			}
		},

		// JavaScript code quality check
		jshint: {
			options: {
				jshintrc: ".jshintrc"
			},
			files: [ 
				"./assets/js/src/**/**/*.js"
			]
		},
		
		// JSCS: JavaScript Code Style check
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

		// CommonJS Compiler
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
				files: [ "./assets/js/src/**/**/**/**/*.js" ],
				tasks: [ "cjsc:debug" ]
			},
			styles: {
				files: "./assets/css/src/*.css",
				tasks: ["watch-css"]
			}
		},
	});

	grunt.registerTask("watch-css",[
		"concat",
		"autoprefixer"
	]);
	grunt.registerTask("debug",[
		"concat",
		"autoprefixer",
		"cjsc:debug"
	]);
	grunt.registerTask( "build", [ 

		"concat",
		"autoprefixer",
		"csso",
//		"jshint",
//		"jscs:test",
		"cjsc:dist" 
	]);
	
	grunt.registerTask("default", ["debug"]);
//	grunt.registerTask("default", ["build"]);
};



