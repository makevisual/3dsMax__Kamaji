/* KCamera.ms — module for camera settings and operations
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct KShot
(
   version         = "0.1.0",

   /* -------- Source -------- */
   srcShotFolder = undefined,
   srcShotName   = undefined, 
   srcRefplate   = undefined, 
   srcRefRange   = undefined,

   /* -------- Internals -------- */

   /* -------- Modules -------- */
   kScene         = undefined, -- units, fps, resolution, ranges, color mode, project root
   kCamera        = undefined, -- filmback, focal, overscan, DOF, distortion
   kPlate         = undefined, -- Reference (plate path, proxy, retime, colorspace, mattes
   kRender        = undefined, -- renderer, AOV pack, output paths, compression, Deadline defaults
   kPreview       = undefined, -- Playblast (TyPreview/H.264 settings, burn-ins, overlays, watermark
   kColor         = undefined, -- Viewing (ACES/legacy toggle, LUT/viewing pipeline
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
      print "init"   
      self._parseShotName self



      -- TODO: Inspect Self
      -- Once all done, inspect self
      self._inspect self

   ),

    function _inspect self =
    (
        props = getPropNames self

        for p in props do
        (
            local v = getProperty self p
            format "%\n    %\n" p v
        )
    ),
   
   fn _parseShotName self = 
   (
      print "_parseShotName"

      parts = filterString self.srcShotFolder "\\"
      self.srcShotName = parts[parts.count]  -- last element

   ),

   fn _name self = 
   (
   
   )

)

newKShot                = KShot()
newKShot.srcShotFolder   = @"Y:\Projects\Hess - Animated Shorts\SPOT_Intro_90secTEST\HESS_Sc010_Sh010"
newKShot._init newKShot

