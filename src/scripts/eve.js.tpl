define(['jquery'], function($) {
  var plugins = [<%= plugins %>];

  var instance = { plugins: [] };  
  $.each(plugins, function(index, plugin){
    instance.plugins.push(plugin);
  });

  return instance;
});
