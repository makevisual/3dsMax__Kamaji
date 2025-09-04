/* kShot.ms — module for holding all the shot information, reads source data and prepares for application
   Location: 3dsMax__Kamaji/code/ms/modules/KCamera.ms
*/

struct Kamaji_Utilities
(
   version         = "0.1.0",

   fn _init self =
   (
   ),

   fn _createIFL fileList =
   (
      sort fileList
      iflPath = ( ( getFilenamePath fileList[1] ) + @"\refPlate.ifl" )
      
      f = createFile iflPath
      for curFile in fileList do format "%\r\n" (filenameFromPath curFile) to:f  -- write one per line
      close f
      
      if ( doesFileExist iflPath )
      then ( return iflPath )
      else ( return  undefined )
   ),

   /* Returns instance the module struct of the passed moduleTag
   */
   fn _moduleBuild moduleTag =
   (
      for module in Kamaji.modules do
      (
         if module[1] == moduleTag then
         (
            newInstance = (module[2])()   -- instantiate the retrieved module
            return newInstance            -- return the instance
         )
      )

      return #None
   ),

   /* Returns the highest version folder in a given base path.
      Works for folders named "v001", "v002" or "something_v001", etc.
   */
   fn _getHighestVersionFolder basePath =
   (
       -- Collect all subdirectories that contain "v" in their name
       -- Example matches: "v001", "shotA_v002", "render_v010"
       -- order them alphanumerically (v001 < v002 < v010)
       local dirs = sort (getDirectories (pathConfig.appendPath basePath "*v*"))

       -- If only one directory matched, just return it
       if dirs.count == 1 then return dirs[1]

       -- Otherwise return the last (highest-sorted) directory
       return dirs[dirs.count]
   ),

   /* Get image-sequence frame range in a folder.
      Looks for filenames like: name.1001.exr  or  name.extra.1012.jpg
      Returns #(firstFrame, lastFrame), or undefined if none found.
   */
   fn _getSequenceRange folderPath =
   (
       -- Get all files in the folder and sort them alphanumerically
--       local files = sort (getFiles (pathConfig.appendPath folderPath "*.*"))

      local files = for file in (getFiles (pathConfig.appendPath folderPath "*.*")) 
          where (matchPattern file pattern:"*.jpg" ignoreCase:true ) or (matchPattern file pattern:"*.jpeg" ignoreCase:true) collect file
      files = sort files

--      print " #### FILES #### "
--      print files

       
       -- Helper function to extract the frame number from a filename
       fn _getFrameFromFile file =
       (

--         print ( "-----" + file )

           -- Strip folder + extension, leaving just the base name
           -- Split base name by both "." and "_" characters
           local parts = filterString (getFilenameFile file) "._"
           
           -- Return the last token (assumed to be the frame number) as an integer
           (parts[parts.count]) as integer
       )
       
       -- Return the first and last frame numbers in the sequence
       [_getFrameFromFile files[1], _getFrameFromFile files[files.count]]
   )
)

Kamaji.utilities = Kamaji_Utilities()

-- Triggers Unit Test if running #direct
if Kamaji.execContext == #direct    then
(
   clearListener()
   print (" #### UNIT TEST: " + (getfilenamefile(getThisScriptFilename() )) + " ####")

   --print (Kamaji.utilities._getHighestVersionFolder @"C:\Users\theon\OneDrive\Documents\GitHub\3dsMax__Kamaji\data\HESS_Sc010_Sh010\Reference")
   --print (Kamaji.utilities._getHighestVersionFolder @"C:\Users\theon\OneDrive\Documents\GitHub\3dsMax__Kamaji\data\HESS_Sc010_Sh010\Renders")
   print (Kamaji.utilities._getSequenceRange @"C:\Users\AaronDabelow\Documents\GitHub\3dsMax__Kamaji\data\HESS_Sc010_Sh010\Reference\v002")

   Kamaji._inspect Kamaji.utilities
)

-- Skips Unit Test if running #indirect
if Kamaji.execContext == #indirect  then ( print ("FILE LOADED: " + (getfilenamefile(getThisScriptFilename() ))))