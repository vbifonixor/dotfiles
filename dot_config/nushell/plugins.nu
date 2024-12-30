# Run this file once on new machines to install all the plugins

[
  nu_plugin_gstat
  nu_plugin_query
] | each { cargo install $in --locked } | ignore
