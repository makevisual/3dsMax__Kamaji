/* KCamera.ms — module for camera settings and operations
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct KCamera
(
    version         = "0.1.0",

    /* -------- properties -------- */
    name            = undefined, --"cam_main",
    focalLength     = undefined, --35.0,
    filmWidth       = undefined, --36.0,     -- mm
    filmHeight      = undefined, --24.0,     -- mm
    overscan        = undefined, --1.0,      -- 1.0 = no overscan
    dofEnabled      = undefined, --false,
    clipNear        = undefined, --1.0,
    clipFar         = undefined, --10000.0,
    safeFrame       = undefined, --true,
    makeStandard    = true,
    makePhysical    = true,

    /* -------- methods -------- */

    fn _init =
    (

    ),

    fn _name self = 
    (

    )

)


