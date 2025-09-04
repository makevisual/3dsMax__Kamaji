/* KCamera.ms — module for camera settings and operations
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct KCamera
(
    version         = "0.1.0",

    /* -------- properties -------- */
    camName             = undefined, 
    camFocalLength      = undefined, 
    camOverscan         = undefined, 
    moblurEnabled       = undefined, 
    moblurDuration      = undefined, 
    clipNear            = undefined, 
    clipFar             = undefined, 
    safeFrame           = undefined, 
    makeStandard        = undefined, 
    makePhysical        = undefined, 

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