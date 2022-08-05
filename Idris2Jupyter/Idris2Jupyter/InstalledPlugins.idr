module Idris2Jupyter.InstalledPlugins

import Jupyter
import Jupyter.Plugins
import Idris2JupyterVega.VegaLite

-- Plugin imports

%default total

export
0
InstalledPlugins : List Type
InstalledPlugins = [RawVegaLite]

-- Separating %search and %hint declarations to prevent it from finding itself, causing a runtime infinite loop
installedPluginIdris2Responses' : All Idris2Response InstalledPlugins
installedPluginIdris2Responses' = %search

installedPluginJupyterResponses' : All JupyterResponse InstalledPlugins
installedPluginJupyterResponses' = %search

%hint
export
installedPluginIdris2Responses : All Idris2Response InstalledPlugins
installedPluginIdris2Responses = installedPluginIdris2Responses'

%hint
export
installedPluginJupyterResponses : All JupyterResponse InstalledPlugins
installedPluginJupyterResponses = installedPluginJupyterResponses'
