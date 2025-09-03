/* KCamera.ms — module for camera settings and operations
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct KScene
(
    version         = "0.1.0",
    class           = #kScene,

    /* -------- properties -------- */
    fileName               = undefined, --
    filePath               = undefined, --
    colorManagment         = undefined, --
    framerate              = undefined, --
    safeFrameEnabled       = undefined, --     
    resolution             = undefined, --
    refPlate               = undefined, --
    duration               = undefined, --

    /* -------- methods -------- */
    
    /* -------- ender -------- */
    _ender = undefined 
)


-- Triggers Unit Test if running #direct
if Kamaji.execContext == #direct    then
(
   clearListener()
   print (" #### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####")

   newKScene                   = KScene()                                                               -- make a new KScene
   show newKScene
)

-- Skips Unit Test if running #indirect
if Kamaji.execContext == #indirect  then
(
   append Kamaji.modules #(#kScene, (KScene))                                                         -- Add KScene to the modules dictionary
   print ("FILE LOADED: " + (getfilenamefile(getThisScriptFilename())))                               -- Report the file is loaded 
)