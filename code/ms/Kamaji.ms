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
    data            = undefined,    -- Kamaj_iData instance     - Holds all prepared and actionable initialized data
    modules         = #(),          -- Dictionary of all of the defined modules in #(name, struct) dictionary format
    ui              = #(),          -- Holds all UI items, for collect and management 

    -- Global flags
    logLevel        = #debug,       -- #debug/#info/#warn/#error
    isReady         = false,        -- overall initCheck
    execContext     = #indirect,    -- Bool to identify if files are executed directly ( #direct ) or through filein ( #indirect )
    controlMode     = #inference,   -- TODO: implement different source information modes, like parsing folders ( #inference ) or from hIero ( #hiero )

    -- function to return properties and values from an ojbect
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
        filein ( Kamaji.execDir + @"\ms\core\Kamaji_Data.ms" )              -- Import Data Structure

        -- import individual modules - they assign themselves to Kamaji.modules for retrieval
        -- TODO: Dynamically load these from a directory later
        filein ( Kamaji.execDir + @"\ms\modules\kShot.ms" )
        filein ( Kamaji.execDir + @"\ms\modules\kScene.ms" )
        filein ( Kamaji.execDir + @"\ms\modules\kCamera.ms" )
        filein ( Kamaji.execDir + @"\ms\modules\kPreview.ms" )
    )
)

/* ------- bootstrap global -------- */

clearlistener()         

Kamaji = KamajiCore()           -- Instantiate the core
Kamaji._init()                  -- Initalize the core
Kamaji.execContext = #direct    -- Flips exececution context once everything is fully loaded


/* ------- Unit Test -------- */
if Kamaji.execContext == #direct    then
(
    format ("\n\n#### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####\n")
    -- Kamaji._inspect Kamaji

    -- Add test shot(s) to the inputShotList
    append Kamaji.data.inputShotList ((trimright Kamaji.execDir @"\code") + @"\data\HESS_Sc010_Sh010" ) 
    --append Kamaji.data.inputShotList ((trimright Kamaji.execDir @"\code") + @"\data\HESS_Sc010_Sh020" )

    -- Build each of the shots, and add them to .data
    for shot in Kamaji.data.inputShotList do 
    (
        newKShot                   = (Kamaji.utilities._moduleBuild #kShot )    -- make a new kShot
        newKShot.srcShotFolder     = shot                                       -- set the source folder for the kShot
        newKShot._init newKShot                                                 -- initalize the new kShot         

        append Kamaji.data.kShotList newKShot
    )

    -- Inspect each of the created shots
    for shot in Kamaji.data.kShotList do
    (
        print ( "Inspecting: " + shot.srcShotName )
        Kamaji._inspect shot                                                    -- Inspect kShot ( self )
    )

    -- Restore a template file
    loadMaxFile ((trimright Kamaji.execDir @"\code") + @"\data\TemplateScenes\GenericScene.max" )  quiet:true

    -- Apply settings for each shot
    for shot in Kamaji.data.kShotList do
    (
        print ( "Running: " + shot.srcShotName )
        shot._processKShot shot 
    )
)