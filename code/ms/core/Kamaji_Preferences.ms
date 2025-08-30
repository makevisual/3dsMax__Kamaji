/* kShot.ms — module for holding all the shot information, reads source data and prepares for application
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct Kamaji_Preferences
(
   version         = "0.1.0",
   colorManagment 	= #ACES,
   headsAndTails 	= 12,
   framerate 		= 24,

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