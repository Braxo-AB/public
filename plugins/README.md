# EMG Plugins

This directory contains various plugins for EMG.

## Usage

For most plugins, the configuration is simple.
Let's say the plugin *something* is in the file `something.pl`.
You will then create a section in your `server.cfg` file, like this:

	PLUGIN something <
	LIBRARY=something.pl
	>

For the connectors that should use it, reference it like this:

	CONNECTOR some_connector <
	PLUGIN=something
	...
	>

