module.exports = (grunt) ->
  
  grunt.initConfig
    coffeelint:
      app: ['*.coffee']
    availabletasks:
      tasks:
        options:
          filter: 'exclude',
          tasks: ['availabletasks', 'default', 'copy', 'coffeelint']
    clean:
      build: ['_chrome']
    copy:
      chrome:
        files: [
          {src: ['library/*', 'resources/*'], dest: '_chrome/'}
          {src: 'src/chrome.json', dest: '_chrome/manifest.json'}
          {src: 'src/index.html', dest: '_chrome/index.html'}
          {src: 'src/css/style.css', dest: '_chrome/css/style.css'}
        ]
    coffee:
      compile:
        files:
          '_chrome/scripts/jscore.js': ['src/scripts/jscore.coffee']
          '_chrome/scripts/config.js': ['src/scripts/config.coffee']
          '_chrome/scripts/fatcat.js': ['src/scripts/fatcat.coffee']
          '_chrome/scripts/index.js': ['src/scripts/index.coffee']
    watch:
      coffee_files:
        files: ['src/scripts/*.coffee']
        tasks: ['coffee']
      other_files:
        files: ['src/**/*.json', 'src/**/*.html', 'src/**/*.css']
        tasks: ['copy']
    jasmine:
      src: 'src/**/*.coffee',
      options:
        specs : 'test/**/*.coffee'


  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-available-tasks'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-qunit'

  grunt.registerTask 'default', ['availabletasks']
  grunt.registerTask 'test', 'Run unit&spec test', ['coffeelint']
  grunt.registerTask 'dev', ['chrome', 'watch']

  grunt.registerTask 'chrome','Make chrome extension bundle', ()->
    grunt.task.run ['test','coffee','copy:chrome']



