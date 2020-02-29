### Julia OpenStreetMapXPlot Package ###
### MIT License                 ###

### Standard map display "layers." ###

const LAYER_STANDARD = Dict(
    1 => OpenStreetMapXPlot.Style("0xd97486", 4), # @motorway-fill
    2 => OpenStreetMapXPlot.Style("0xebb36a", 3), # @primary-fill
    3 => OpenStreetMapXPlot.Style("0xe8b995", 3), # @secondary-fill
    4 => OpenStreetMapXPlot.Style("0xecf27c", 3), # @tertiary-fill
    5 => OpenStreetMapXPlot.Style("0xb9b9b6", 2), # gray
    6 => OpenStreetMapXPlot.Style("0xc7c7c4", 2), # gray
    7 => OpenStreetMapXPlot.Style("0xd9d9d5", 2), # Light gray
    8 => OpenStreetMapXPlot.Style("0xd9d9d5", 1)) # Light gray



const LAYER_CYCLE = Dict(
    1 => OpenStreetMapXPlot.Style("0x006600", 3), # Green
    2 => OpenStreetMapXPlot.Style("0x5C85FF", 3), # Blue
    3 => OpenStreetMapXPlot.Style("0x5C85FF", 2), # Blue
    4 => OpenStreetMapXPlot.Style("0x999999", 2)) # Dark gray

const LAYER_PED = Dict(
    1 => OpenStreetMapXPlot.Style("0x999999", 3), # Dark gray
    2 => OpenStreetMapXPlot.Style("0x999999", 3), # Dark gray
    3 => OpenStreetMapXPlot.Style("0x999999", 2), # Dark gray
    4 => OpenStreetMapXPlot.Style("0xE0E0E0", 2)) # Light gray

const LAYER_FEATURES = Dict(
    1 => OpenStreetMapXPlot.Style("0x9966FF", 1.5, "."),  # Lavender
    2 => OpenStreetMapXPlot.Style("0xFF0000", 1.5, "."),  # Red
    3 => OpenStreetMapXPlot.Style("0x000000", 1.5, "."),  # Black
    4 => OpenStreetMapXPlot.Style("0xFF66FF", 1.5, "."),  # Pink
    5 => OpenStreetMapXPlot.Style("0x996633", 1.5, "."),  # Brown
    6 => OpenStreetMapXPlot.Style("0xFF9900", 2.0, "."),  # Orange
    7 => OpenStreetMapXPlot.Style("0xCC00CC", 1.5, "."),  # Brown
	8 => OpenStreetMapXPlot.Style("0xFFFF00", 1.5, "."),  # Yellow
    9 => OpenStreetMapXPlot.Style("0xF4CCCC", 1.5, "."),  # Vanilla Ice
    10 => OpenStreetMapXPlot.Style("0x351C75", 1.5, "."), # Persian Indigo
    11 => OpenStreetMapXPlot.Style("0x00FF00", 1.5, "."), # Lime
    12 => OpenStreetMapXPlot.Style("0x00FFFF", 1.5, "."), # Aqua
    13 => OpenStreetMapXPlot.Style("0x005353", 2.0, "."), # Sherpa Blue
    14 => OpenStreetMapXPlot.Style("0xBDAD7D", 1.5, "."), # Ecru
    15 => OpenStreetMapXPlot.Style("0xFF00FF", 1.5, "."), # Fuchsia
    16 => OpenStreetMapXPlot.Style("0xB9D1D6", 1.5, "."), # Light Blue
    17 => OpenStreetMapXPlot.Style("0x7A00CC", 1.5, "."), # Violet
    18 => OpenStreetMapXPlot.Style("0x004225", 1.5, "."), # British Racing Green
    19 => OpenStreetMapXPlot.Style("0x7E8386", 2.0, "."), # Silver
    20 => OpenStreetMapXPlot.Style("0xB87333", 1.5, "."), # Copper
    21 => OpenStreetMapXPlot.Style("0x800020", 1.5, "."), # Burgundy
    22 => OpenStreetMapXPlot.Style("0x5B718D", 1.5, "."), # Ultramarine
    23 => OpenStreetMapXPlot.Style("0x636F22", 1.5, "."), # Fiji Green
    24 => OpenStreetMapXPlot.Style("0xCAF4DF", 1.5, "."), # Mint
    25 => OpenStreetMapXPlot.Style("0x231F66", 2.0, "."), # Midnight Blue
    26 => OpenStreetMapXPlot.Style("0xE6DFE7", 1.5, ".")) # Selago

const LAYER_BUILDINGS = Dict(
    1 => OpenStreetMapXPlot.Style("0xE1E1EB", 1, "-"), # Lighter gray
    2 => OpenStreetMapXPlot.Style("0xB8DBFF", 1, "-"), # Light blue
    3 => OpenStreetMapXPlot.Style("0xB5B5CE", 1, "-"), # Light gray
    4 => OpenStreetMapXPlot.Style("0xFFFF99", 1, "-"), # Pale yellow
    5 => OpenStreetMapXPlot.Style("0x006600", 1, "-")) # Green
