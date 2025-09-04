/* kShot.ms — module for holding all the shot information, reads source data and prepares for application
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct Kamaji_Data
(
   version            = "0.1.0",

   inputShotList      = #(),
   kShotList          = #(),
   errors             = #(),
   eventlog           = #(),
   timeStart          = undefined,
   timeEnd            = undefined,

   fn _init self =
   (
   )
)

Kamaji.data = Kamaji_Data()

-- Triggers Unit Test if running #direct
if Kamaji.execContext == #direct    then
(
   clearListener()
   print (" #### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####")

   Kamaji._inspect Kamaji.data
)

-- Skips Unit Test if running #indirect
if Kamaji.execContext == #indirect  then ( print ("FILE LOADED: " + (getfilenamefile(getThisScriptFilename() ))))