/* kShot.ms — module for holding all the shot information, reads source data and prepares for application
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct Kamaji_Preferences
(
   version                 = "0.1.0",
   colorManagment 	      = #ACES,
   headsAndTails 	         = 12,
   framerate 		         = 24,
   resolution              = [1920,1080],
   safeFrameEnabled        = true,
   cameraStandard          = true,
   cameraPhysical          = true,
   cameraFocalLength       = 35.0,
   cameraOverscan          = 1.1,
   cameraMaster            = #Standard,            -- #Physical - Toggle for which camera is the parent
   cameraMoblurEnabled     = true,                 -- #Physical - Toggle for which camera is the parent
   cameraMoblurDuration    = .25,
   dirShotScenesLayout     = @"Scenes\Layout",     -- Default location to put the layout scene
   dirShotScenesAnimation  = @"Scenes\Animation",  -- Default location to put the layout scene
   dirShotPreviews         = @"Previews",          -- Default location to put the layout scene
   previewFormat           = ".jpg",

   fn _init self =
   (
   )
)

Kamaji.preferences = Kamaji_Preferences()

-- Triggers Unit Test if running #direct
if Kamaji.execContext == #direct    then
(
   clearListener()
   print (" #### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####")

   Kamaji._inspect Kamaji.preferences
)

-- Skips Unit Test if running #indirect
if Kamaji.execContext == #indirect  then ( print ("FILE LOADED: " + (getfilenamefile(getThisScriptFilename() ))))