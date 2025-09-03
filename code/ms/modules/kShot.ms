/* kShot.ms — module for holding all the shot information, reads source data and prepares for application
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct KShot
(
   version         = "0.1.0",

   /* -------- Source -------- */
   srcShotFolder     = undefined,
   srcShotName       = undefined, 
   srcRefPlate       = undefined, 
   srcRefRange       = undefined,
   srcRenderOutput   = undefined,
   srcRenderRange    = undefined,

   /* -------- Internals -------- */

   /* -------- Modules -------- */
   kScene         = undefined, -- units, fps, resolution, ranges, color mode, project root
   kCamera        = undefined, -- filmback, focal, overscan, DOF, distortion
   kPreview       = undefined, -- Playblast (TyPreview/H.264 settings, burn-ins, overlays, watermark
--   kRender        = undefined, -- renderer, AOV pack, output paths, compression, Deadline defaults

   /* -------- Future Modules -------- */
--   kColor         = undefined, -- Viewing (ACES/legacy toggle, LUT/viewing pipeline
--   kLighting,     -- default dome, HDRI ref, light rigs
--   kFX,           -- Caches (Alembic, VRMesh, tyCache, sim settings
--   kGeometry,     -- Assets (XRefs, proxy links, asset libraries
--   kAudio,        -- reference audio sync, scratch track path
--   kAnnotations,  -- Metadata (notes, editorial timecode, shot status
--   kVersioning,   -- seq/shot/version IDs, UID, timestamps, author
--   kOutput,       -- Delivery (slates, naming tokens, publish folder
--   kValidation,   -- Preflight (issues list, pass/fail flags
--   kLogging,      -- per-shot log entries for actions taken
--   kDependencies, -- links to upstream Hiero comp, downstream Nuke script
--   kTasks,        -- Ownership (assigned artist, department tags, due dates
--   kProfiles,     -- Templates (which preset config this shot was built from

    /* -------- methods -------- */

   fn _init self =
   (

      -- Infer details from shot folder contents
      self._parseShotName        self
      self._parseRefPlate        self
      self._parseRefRange        self
      self._parseRenderOutput    self
      self._parseRenderRange     self

      -- shorthand for preferences
      pref = Kamaji.preferences

      -- kScene Constructor
      newSc = self.kScene = (Kamaji.utilities._moduleBuild #kScene) -- Instantiate new kScene 
      newSc.fileName             = (self.srcShotName + "__Layout_v001.max")
      newSc.filePath             = (self.srcShotFolder + @"\" + pref.dirShotScenesLayout + @"\" + self.kScene.fileName)
      newSc.refPlate             = self.srcRefPlate
      newSc.duration             = self.srcRenderRange
      newSc.colorManagment       = pref.colorManagment
      newSc.framerate            = pref.framerate
      newSc.safeFrameEnabled     = pref.safeFrameEnabled
      newSc.resolution           = pref.resolution

      -- kCamera Constructor
      newCam = self.kCamera = (Kamaji.utilities._moduleBuild #kCamera)
      newCam.camName             = ("CAM_" + self.srcShotName)
      newCam.camFocalLength      = pref.cameraFocalLength
      newCam.camOverscan         = pref.cameraOverscan
      newCam.moblurEnabled       = pref.cameraMoblurEnabled
      newCam.moblurDuration      = pref.cameraMoblurDuration
      newCam.makeStandard        = pref.cameraStandard
      newCam.makePhysical        = pref.cameraPhysical

      -- kPreview Constructor
      newPre = self.kPreview = (Kamaji.utilities._moduleBuild #kPreview)
      newPre.cameraName          = newCam.camName
      newPre.previewPath         = (self.srcShotFolder + @"\" + pref.dirShotPreviews + @"\" ) -- TODO: Probably rework this to work with TyPreview Token String
      newPre.previewFilename     = (self.srcShotName + "__Preview")
      newPre.previewFormat       = pref.previewFormat

      -- Build the viewport callback
      -- Kamaji.commands._constructKamajiViewportFramerangeUpdate self
   ),

   -- Get the shot name from the srcShotFolder
   fn _parseShotName self = 
   (
      parts = filterString self.srcShotFolder "\\"
      self.srcShotName = parts[parts.count]
   ),

   fn _parseRefPlate self =
   (
      -- Locate the highest iterated shot reference folder
      self.srcRefPlate = (Kamaji.utilities._getHighestVersionFolder (self.srcShotFolder + @"\Reference\" ) )
   ),

   fn _parseRefRange self =
   (
      self.srcRefRange = Kamaji.utilities._getSequenceRange self.srcRefPlate
   ),

   fn _parseRenderOutput self =
   (
      -- Locate the highest iterated shot render folder
      self.srcRenderOutput = (Kamaji.utilities._getHighestVersionFolder (self.srcShotFolder + @"\Renders\" ) )
   ),

   fn _parseRenderRange self =
   (
      -- Read the first and last frames from the render folders
      self.srcRenderRange = Kamaji.utilities._getSequenceRange self.srcRenderOutput

      -- if the ref and render are the same, add padding to the render range
      if self.srcRenderRange == self.srcRefRange then
      (
         self.srcRenderRange[1] = (self.srcRenderRange[1] - kamaji.preferences.headsAndTails )
         self.srcRenderRange[2] = (self.srcRenderRange[2] + kamaji.preferences.headsAndTails )
      )
   ),

   fn _name self = 
   (
   
   ),

   fn _unitTest self = 
   (

   )

)

-- Triggers Unit Test if running #direct
if Kamaji.execContext == #direct    then
(
   clearListener()
   print (" #### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####")

   newKShot                   = KShot()                                                               -- make a new kShot
   newKShot.srcShotFolder     = ((trimright Kamaji.execDir @"\code") + @"\data\HESS_Sc010_Sh010" )    -- Point to the test shot directory on disk
   newKShot._init newKShot                                                                            -- initalize the new kShot         
   Kamaji._inspect newKShot                                                                           -- Inspect kShot ( self )
)

-- Skips Unit Test if running #indirect
if Kamaji.execContext == #indirect  then
(
   append Kamaji.modules #(#kShot, (kShot))                                                           -- Add kShot to the modules dictionary
   print ("FILE LOADED: " + (getfilenamefile(getThisScriptFilename())))                               -- Report the file is loaded 
)