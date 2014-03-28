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
    connect:
      server:
        base: '_chrome'
    coffee:
      glob_to_multiple:
        expand: true
        flatten: false
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: '_chrome/scripts/'
        ext: '.js'
    watch:
      coffee_files:
        files: ['src/**/*.coffee']
        tasks: ['coffee']
      eve_js:
        files: ['src/scripts/eve.js.tpl']
        tasks: ['preprocess']
      other_files:
        files: ['src/**/*.json', 'src/**/*.html', 'src/**/*.css', 'library/*']
        tasks: ['copy']
    jasmine:
      src: 'src/**/*.coffee',
      options:
        specs : 'test/**/*.coffee'

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-qunit'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-available-tasks'

  grunt.registerTask 'default', ['availabletasks']
  grunt.registerTask 'test', 'Run unit&spec test', ['coffeelint']
  grunt.registerTask 'dev', ['chrome', 'watch']
  grunt.registerTask 'websrv', 'connect:server:keepalive'

  grunt.registerTask 'preprocess', 'Generate eve.js for register plugins', ()->
    tpl = grunt.file.read('src/scripts/eve.js.tpl')
    files = grunt.file.expand('**/config.json')
    plugins = files.map (file)-> grunt.file.read file
    content = grunt.template.process(tpl, {data: {plugins: plugins}})
    grunt.file.write '_chrome/scripts/eve.js', content

  grunt.registerTask 'chrome','Make chrome extension bundle', ()->
    grunt.task.run ['preprocess','coffee','copy:chrome']

