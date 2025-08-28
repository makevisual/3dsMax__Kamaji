/* Kamaji_Modules.ms — super simple data container
   Loads everything in /modules and instantiates if possible
*/

struct KamajiModules
(
    modules = #(),   -- array of #( "Name", <instance> )

    fn _init =
    (
        --local loaded = #()
        --local files = ( getFiles (Kamaji.execDir + @"\ms\modules\" + "*.ms") )
        --print "FILES"
        --print files
        
        Kamaji.execDir + @"\ms\modules\"        

    )
)

/* Factory function (bootstrapper calls this) */
--fn Kamaji_Data = (KamajiData())
Kamaji.data = KamajiModules()
Kamaji.data._init()