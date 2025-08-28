-- Kamaji_Commands.ms
struct KamajiCommands
(
    core, -- KamajiCore (for access to .data/.utils/etc.)
    fn log msg level:#info = (format "[Kamaji:%] %\n" level msg),

    applyAll = function shot:(core.data.activeShot) do
    (
        if shot == undefined do return false
        applyScene shot.scene
        applyPlate shot.plate
        applyCamera shot.camera
        applyRender shot.render
        applyPreviewDefaults shot.preview
        true
    ),

    applyScene = function sceneData do
    (
        -- units, fps, range, resolution, gamma/OCIO toggles…
        -- ex: frameRate = sceneData.fps; animationRange = interval sceneData.frameStart sceneData.frameEnd
    ),

    applyPlate = function plateData do
    (
        -- create VRayBitmap/Bitmap, set frame range, viewport background
    ),

    applyCamera = function camData do
    (
        -- create or update camera; set filmback, focal, overscan
        -- import FBX/Alembic if camData.sourcePath != ""
    ),

    applyRender = function renderData do
    (
        -- set renderer, AOVs via LPM, output paths, EXR attrs, Deadline defaults
    ),

    applyPreviewDefaults = function previewData do
    (
        -- configure TyPreview template (fps, resolution, overlays)
    ),

    preflight = function shot:(core.data.activeShot) do
    (
        local issues = #()
        -- check paths exist, frame range matches plate, OCIO mode consistency, output write perms, etc.
        issues
    )
)
