export curDir=`dirname "$0"`
cd $curDir
export curDir=`pwd`
export scriptsDir="$curDir"

cd ../ReleaseVersions

export appZip=`ls DropToScript*zip | sed -e "s/\.zip$//"`

rm -rf $appZip

mkdir $appZip
cd $appZip

unzip ../$appZip.zip 

cd ..

rm $appZip.zip

export linuxScripts="$appZip/Linux 64 bit/DropToScript/DropScripts"
export macScripts="$appZip/OS X 64 bit/DropToScript/DropScripts"
export winScripts="$appZip/Windows/DropToScript/DropScripts"

rm -rf "$linuxScripts"
rm -rf "$macScripts"
rm -rf "$winScripts"

mkdir "$linuxScripts"
mkdir "$macScripts"
mkdir "$winScripts"

ls "$scriptsDir" | while read dropScriptDir
do 
	export fullDropScriptDir="$scriptsDir/$dropScriptDir"
	if [ -d "$fullDropScriptDir" ]
	then
	    cp -R "$fullDropScriptDir"/* "$linuxScripts"
	    cp -R "$fullDropScriptDir"/* "$macScripts"
	    cp -R "$fullDropScriptDir"/* "$winScripts"
    fi
done

find . -name ".DS_Store" | while read a; do rm "$a"; done
find . -name "__MACOSX" | while read a; do rm -rf "$a"; done
xattr -cr "$appZip/OS X 64 bit/DropToScript.app"

cd $appZip
zip -r ../$appZip.zip *
cd ..

rm -rf $appZip
