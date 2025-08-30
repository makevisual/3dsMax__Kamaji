/* Kamaji.ms  — bootstrapper
   Location: 3dsMax__Kamaji/code/ms/Kamaji.ms
   Responsibility:
     - Detect its run directory and derive repo paths
     - Create the single global `Kamaji` object
     - Load Core data builder (Kamaji_Data.ms)
     - Initialize base data with default props and auto-load modules
*/

global Kamaji

struct KamajiCore
(
    version         = "0.1.0",
    execDir         = undefined,    -- folder containing this Kamaji.ms (…/code/ms/)
    data            = undefined,    -- KamajiData instance
    modules         = undefined,    -- all of the defined modules loaded from 
    ui              = #(),          -- Holds all UI
    commands        = undefined,    -- Kamaji_Commands()
    utilities       = undefined,    -- Kamaji_Utilities()
    logLevel        = #debug,       -- #debug/#info/#warn/#error
    isReady         = false,        -- overall initCheck
    execContext     = #indirect,    -- Bool to identify if files are executed directly ( #direct ) or through filein ( #indirect )
    preferences     = undefined,    -- Bool to identify if files are executed directly ( #direct ) or through filein ( #indirect )

    function _inspect self =
    (
        props = (sort(getPropNames self))                         -- Collect all proerties and alphebetize them
        props = for i = props.count to 1 by -1 collect props[i]   -- Invert the order ( send functions to the end )

        for prop in props do
        (
            local value = getProperty self prop
            format "%\n    %\n" prop value
        )
    ),

    function _init =
    (
        -- Set the directory that things are running in
        Kamaji.execDir = ( trimright (getThisScriptFilename()) @"ms\Kamaji.ms" )

        
        filein ( Kamaji.execDir + @"\ms\core\Kamaji_Utilities.ms" )     -- Import Utilites
        filein ( Kamaji.execDir + @"\ms\core\Kamaji_Preferences.ms" )     -- Import Utilites
        filein ( Kamaji.execDir + @"\ms\core\Kamaji_Commands.ms" )     -- Import Utilites
        filein ( Kamaji.execDir + @"\ms\modules\kShot.ms" )             -- build a new kShot
    )
)

/* ------- bootstrap global -------- */
clearlistener()
Kamaji = KamajiCore()
Kamaji._init()
Kamaji._inspect Kamaji



Kamaji.execContext = #direct -- Flips context once everything is fully loaded, do once all files are loaded