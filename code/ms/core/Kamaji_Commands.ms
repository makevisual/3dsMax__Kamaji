/* kShot.ms — module for holding all the shot information, reads source data and prepares for application
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct Kamaji_Commands
(
   version         = "0.1.0",

   fn _constructKamajiViewportFramerangeUpdate kShot =
   (

      -- TODO: need to make this exposed to the callback, probably through a scene object

      fn kamajiViewportFramerangeUpdate =
      (

         -- TODO: need to make this exposed to the callback, probably through a scene object

         -- srcRefRange       = kShot.srcRefRange    -- = [1012,1050]
         -- srcRenderRange    = kShot.srcRenderRange -- = [1000,1062]

         srcRefRange       = [1012,1050]
         srcRenderRange    = [1000,1062]

         frameType = #outOfRange -- #heads #tails #inShot

         if ( slidertime >= srcRenderRange[1] )    and ( sliderTime < srcRefRange[1] )       then ( frameType = #heads )
         if ( slidertime >= srcRefRange[1] )       and ( sliderTime <= srcRefRange[2] )      then ( frameType = #inShot)
         if ( slidertime <= srcRenderRange[2] )    and ( sliderTime > srcRefRange[2] )       then ( frameType = #tails )
         if ( slidertime < srcRenderRange[1] )     and ( sliderTime > srcRenderRange[2] )    then ( frameType = #outOfRange )

         gw.setTransform (matrix3 1) -- Resets the coordinate system to screen space
         local myText   = ""
         local textColor = color 50 50 50

         if frameType == #heads then
         (
            textColor   = color 90 90 220
            myText      = "Frame: in heads"
         )
         if frameType == #inShot then
         (
            textColor   = color 0 170 0
            myText      = "Frame: in shot"
         )
         if frameType == #tails then
         (
            textColor   = color 90 90 220
            myText      = "Frame: in tails"
         )
         if frameType == #outOfRange then
         (
            textColor   = color 100 100 100
            myText      = "Frame: out of shot range"
         )

         local textPosition = [10, 40, 0]             -- X, Y, Z coordinates in screen space
         gw.wtext textPosition myText color:textColor
         gw.updateScreen()                         -- Updates the viewport to show the drawn text
      )
         
      unregisterRedrawViewsCallback kamajiViewportFramerangeUpdate -- Unregister previous callbacks to avoid duplicates
      registerRedrawViewsCallback kamajiViewportFramerangeUpdate 

      
   ),


   fn _init self =
   (
   )
)

Kamaji.commands = Kamaji_Commands()

-- Triggers Unit Test if running #direct
if Kamaji.execContext == #direct    then
(
   clearListener()
   print (" #### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####")

   Kamaji._inspect Kamaji.commands
)

-- Skips Unit Test if running #indirect
if Kamaji.execContext == #indirect  then ( print ("FILE LOADED: " + (getfilenamefile(getThisScriptFilename() ))))