require.config
  paths:
    'jquery': '/library/jquery-2.0.3.min'
    'ICanHaz': '/library/ICanHaz-0.10.2.min'

require ['jquery', 'ICanHaz', 'eve'], ($, ihaz, Eve)->
  runPlugin = (plugin)->


  $(document).ready ->
    $('#main').css("height", $(document).height())

    ich.grabTemplates()

    #load plugins
    for plugin in Eve.plugins
      $('#apps').append ich.pluginTemplate {name: plugin.name}

    #
    $('#apps').on 'click', 'li', ->
      return if $(@).hasClass 'active'#skip

      $('#apps li.active').removeClass 'active'
      $(@).addClass 'active'

    $('#apps li:first').click()

