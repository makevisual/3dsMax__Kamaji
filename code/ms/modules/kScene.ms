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

   fn _run self =
   (
      print "### KScene _run ###"
      Kamaji._inspect self

      -----------   Save the new file -----------
      print "## Save 3dsMax File ##"
      print self.filepath

      makedir (getFilenamePath self.filepath)
      print (saveMaxFile self.filepath useNewFile:true quiet:true)

      -----------   Set Color Management  -----------
      print "## Color Management ##"
      print self.colorManagment

      if self.colorManagment == #ACES then 
      (
         cpm = colorPipelineMgr
         try(cpm.Locked = false)catch()                 -- allow changes if locked
         cpm.Mode = #OCIO_Default           -- "OCIO - 3dsMax Default"
         cpm.RenderingColorSpace = "ACEScg" -- working/rendering space
         print ( "Mode: " + ( cpm.Mode as string ) + "\nRenderSpace: " + ( cpm.RenderingColorSpace as string ) )
      )

      -----------   Set frame rate  -----------
      print "## Frame Rate ##"
      print self.framerate

      frameRate = self.framerate

      -----------   Set safe frames  -----------
      print "## Set Safe Frames ##"
      print self.safeFrameEnabled

      if (print self.safeFrameEnabled) then 
      (
         viewport.SetLayout #layout_4
         viewport.activeViewport = 4   -- make sure we're on viewport 4
         displaySafeFrames    = true   -- master toggle
      )

      -----------   Set resolution  -----------
      print "## Set Safe Frames ##"
      print self.resolution

      renderWidth  = self.resolution[1]
      renderHeight = self.resolution[2]
      pixelAspect  = 1.0   -- 1.0 for square pixels

      -- TODO: Connect to LPM

      -----------   Set ref plate  -----------
      print "## Set Ref Plate ##"
      print self.refPlate

      -- Get files in the ref plate folder
      exts   = #("*.jpg","*.jpeg") --#("*.exr","*.png","*.jpg","*.jpeg","*.tif","*.tiff","*.bmp")
      files  = #(); for ext in exts do files += getFiles (pathConfig.appendPath self.refPlate ext)
      sort files

      newIFL = Kamaji.utilities._createIFL files
      print newIFL


-- TODO
--      startFrm = 1012   -- timeline frame where the sequence should start

      backgroundImageFileName = newIFL  -- point BG to the .IFL
      --viewport.setUseBitmap true         -- "Use Files"
      viewport.DispBkgImage = true       -- show background
      setBkgImageAnimate true            -- animate background (sequence)
--      setBkgStartTime (startFrm)  -- "Start At"
-- TODO
--      setBkgFrameRange [0,98,1]



      -----------   Set duration / timeline  -----------
      print "## Set Duration / Timeline ##"
      print self.refPlate

      animationRange = interval (self.duration[1]) (self.duration[2])
      sliderTime     = self.duration[1]

      -- TODO: Connect to LPM

   ),
    
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