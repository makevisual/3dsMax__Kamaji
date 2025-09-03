/* KCamera.ms — module for camera settings and operations
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct KCamera
(
    version         = "0.1.0",

    /* -------- properties -------- */
    camName             = undefined, --"cam_main",
    camFocalLength      = undefined, --35.0,
--    camFilmWidth        = undefined, --36.0,     -- mm
--    camFilmHeight       = undefined, --24.0,     -- mm
    camOverscan         = undefined, --1.0,      -- 1.0 = no overscan
    moblurEnabled       = undefined, --false,
    moblurDuration      = undefined, --false,
    clipNear            = undefined, --1.0,
    clipFar             = undefined, --10000.0,
    safeFrame           = undefined, --true,
    makeStandard        = undefined, --true,
    makePhysical        = undefined, --true,

    /* -------- methods -------- */
    
    /* -------- ender -------- */
    _ender = undefined 

)

-- Triggers Unit Test if running #direct
if Kamaji.execContext == #direct    then
(
   clearListener()
   print (" #### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####")

   newKCamera                   = KCamera()                                                               -- make a new KCamera
   show newKCamera
)

-- Skips Unit Test if running #indirect
if Kamaji.execContext == #indirect  then
(
   append Kamaji.modules #(#KCamera, (KCamera))                                                         -- Add KCamera to the modules dictionary
   print ("FILE LOADED: " + (getfilenamefile(getThisScriptFilename())))                               -- Report the file is loaded 
)