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
    commands        = undefined,    -- KamajiCommands()
    logLevel        = #debug,       -- #debug/#info/#warn/#error
    isReady         = false,        -- overall initCheck

    function _inspect =
    (
        props = getPropNames Kamaji

        for p in props do
        (
            local v = getProperty Kamaji p
            format "%\n    %\n" p v
        )
    ),

    function _init =
    (
        Kamaji.execDir = ( trimright (getThisScriptFilename()) @"ms\Kamaji.ms" )

        filein ( Kamaji.execDir + @"\ms\modules\kCamera.ms" )
    ),

    ender = undefined -- added to avoid eof delimiter error
)

/* ------- bootstrap global -------- */
clearlistener()
Kamaji = KamajiCore()
Kamaji._init()
Kamaji._inspect()