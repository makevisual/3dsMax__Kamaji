/* KCamera.ms — module for camera settings and operations
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct KPreview
(
    version         = "0.1.0",
    class           = #kPreview,

    /* -------- properties -------- */
      cameraName              = undefined, --
      previewPath             = undefined, --
      previewFilename         = undefined, --
      previewFormat           = undefined, --

      -- TODO: integrate with tyPreview https://docs.tyflow.com/tyflow_utilities/tyPreview/
      tyPreviewPreset         = undefined,

    /* -------- methods -------- */
    
    /* -------- ender -------- */
    _ender = undefined 
)


-- Triggers Unit Test if running #direct
if Kamaji.execContext == #direct    then
(
   clearListener()
   print (" #### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####")

   newKpreview                   = KPreview()                                                               -- make a new KScene
   show newKpreview
)

-- Skips Unit Test if running #indirect
if Kamaji.execContext == #indirect  then
(
   append Kamaji.modules #(#kPreview, (KPreview))                                                         -- Add KScene to the modules dictionary
   print ("FILE LOADED: " + (getfilenamefile(getThisScriptFilename())))                               -- Report the file is loaded 
)