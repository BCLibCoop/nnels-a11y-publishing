export curDir=`dirname "$0"`
cd $curDir
export curDir=`pwd`
export scriptsDir="$curDir"

export dropScriptTemplateName=DropScriptTemplate
export dropScriptTemplateFile=$scriptsDir/$dropScriptTemplateName/$dropScriptTemplateName.php

ls "$scriptsDir" | while read dropScriptDir
do 
    export fullDropScriptDir="$scriptsDir/$dropScriptDir"
    if [ -d "$fullDropScriptDir" -a "$dropScriptDir" != "$dropScriptTemplateName" ]
    then
        #
        # Merge shared code in scripts with DropScriptTemplate.php
        #
        export phpScript=$fullDropScriptDir/$dropScriptDir.php    
        if [ -f "$phpScript" ]
        then
            sed -e "/AUTO-GENERATED/,\$d"  "$phpScript" > "$phpScript.update"
            sed -ne '/AUTO-GENERATED/,$ p' $dropScriptTemplateFile >> "$phpScript.update"
            rm -f "$phpScript"
            mv "$phpScript.update" "$phpScript"
            chmod +x "$phpScript"
        fi
    fi
done