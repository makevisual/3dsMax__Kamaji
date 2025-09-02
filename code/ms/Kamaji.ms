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
    -- Identifiers
    version         = "0.1.0",      -- Version number
    execDir         = undefined,    -- folder containing this Kamaji.ms (…/code/ms/)

    -- Classes and libraries
    commands        = undefined,    -- Kamaji_Commands.ms       - things that talk to the 3dsMax Scene
    utilities       = undefined,    -- Kamaji_Utilities.ms      - things that Kamaji uses, like file parsing functions
    preferences     = undefined,    -- Kamaji_preferences.ms    - holds default preferences, if inference fails

    -- Dynamic memory objects
    data            = undefined,    -- TODO: KamajiData instance
    modules         = undefined,    -- TODO: all of the defined modules loaded from 
    ui              = #(),          -- TODO: Holds all UI

    -- Global flags
    logLevel        = #debug,       -- #debug/#info/#warn/#error
    isReady         = false,        -- overall initCheck
    execContext     = #indirect,    -- Bool to identify if files are executed directly ( #direct ) or through filein ( #indirect )
    knowledgeMode   = #inference,   -- TODO: implement different source information modes, like parsing folders ( #inference ) or from hIero ( #hiero )

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