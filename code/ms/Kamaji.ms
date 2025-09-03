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
    data            = undefined,    -- TODO: KamajiData instance - Holds all prepared and actionable initialized data
    modules         = #(),          -- dictionary of all of the defined modules in #(name, struct) dictionary format
    ui              = #(),          -- TODO: Holds all UI, for collect and management 

    -- Global flags
    logLevel        = #debug,       -- #debug/#info/#warn/#error
    isReady         = false,        -- overall initCheck
    execContext     = #indirect,    -- Bool to identify if files are executed directly ( #direct ) or through filein ( #indirect )
    controlMode     = #inference,   -- TODO: implement different source information modes, like parsing folders ( #inference ) or from hIero ( #hiero )

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
        -- Set the exec directory
        Kamaji.execDir = ( trimright (getThisScriptFilename()) @"ms\Kamaji.ms" )
        
        -- Import core libraries 
        filein ( Kamaji.execDir + @"\ms\core\Kamaji_Utilities.ms" )         -- Import Utilites
        filein ( Kamaji.execDir + @"\ms\core\Kamaji_Preferences.ms" )       -- Import Preferences
        filein ( Kamaji.execDir + @"\ms\core\Kamaji_Commands.ms" )          -- Import Commands

        -- Load the individual modules - these map and assign themselves to Kamaji.modules for retrieval and construction
        -- TODO: Dynamically load these
        filein ( Kamaji.execDir + @"\ms\modules\kShot.ms" )
        filein ( Kamaji.execDir + @"\ms\modules\kScene.ms" )
        filein ( Kamaji.execDir + @"\ms\modules\kCamera.ms" )
        filein ( Kamaji.execDir + @"\ms\modules\kPreview.ms" )

        -- Test build the kShot module
        print (Kamaji.utilities._moduleBuild #kShot )
        print (Kamaji.utilities._moduleBuild #kScene )
        print (Kamaji.utilities._moduleBuild #kCamera )
        print (Kamaji.utilities._moduleBuild #kPreview )

        print Kamaji.preferences
    )
)

/* ------- bootstrap global -------- */
clearlistener()
Kamaji = KamajiCore()
Kamaji._init()
--Kamaji._inspect Kamaji

Kamaji.execContext = #direct -- Flips context once everything is fully loaded, do once all files are loaded