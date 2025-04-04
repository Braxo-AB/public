# EMG Plugins

This directory contains various plugins for EMG.

## Usage

For most plugins, the configuration is simple.
Let's say the plugin *some_plugin* is in the file `some_file.pl`.
You will then create a section in your `server.cfg` file, like this:

	PLUGIN some_plugin <
	LIBRARY=some_file.pl
	>

For the connectors that should use it, reference it like this:

	CONNECTOR some_connector <
	PLUGIN=some_plugin
	...
	>

