/*global module*/
module.exports = function (grunt) {
	'use strict';
	
	var cssFiles = {
		'assets/css/folio.min.css': [
			'assets/css/src/folio.css',
			'assets/css/src/folio.xhtml.css',
		],
//		'assets/css/flash.min.css': [
//			'assets/css/flash.css'
//		],
	};

	grunt.initConfig({

		concat: {
			dist: {
				files: cssFiles,
			},
		},

		autoprefixer: {
			styles: {
				files: cssFiles,
			}
		},

		csso: {
			styles: {
				files: cssFiles,
			}
		},

//		jshint: {
//			scripts: [
//				'assets/src/js/folio.js',
//				'assets/src/js/folio.something.else.js',
//			]
//		},

//		uglify: {
//			scripts: {
//				options: {
//					preserveComments: 'some'
//				},
//				files: {
//					'assets/js/backbone.folio.min.js': [
//						'assets/lib/jquery.js',
//						'assets/lib/underscore.js',
//						'assets/lib/backbone.js',
//						'assets/src/js/backbone.folio.js',
//					]
//				}
//			}
//		},

		watch: {
			styles: {
				files: 'assets/css/src/*.css',
				tasks: ['watch-css']
			},
//			scripts: {
//				files: 'assets/src/js/*.js',
//				tasks: ['js']
//			}
		}

	});

	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-autoprefixer');
	grunt.loadNpmTasks('grunt-csso');
//	grunt.loadNpmTasks('grunt-contrib-jshint');
//	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-watch');

	grunt.registerTask('default', ['concat', 'autoprefixer', 'csso']);
	grunt.registerTask('watch-css', ['concat', 'autoprefixer']);
//	grunt.registerTask('js', ['uglify']);
};
