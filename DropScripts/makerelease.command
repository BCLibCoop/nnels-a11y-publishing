export curDir=`dirname "$0"`
cd $curDir
export curDir=`pwd`
export scriptsDir="$curDir"
export scriptsVersion=`cat version.txt`

cd ../ReleaseVersions

export oldAppZipFolder=`ls DropToScript*zip | sed -e "s/\.zip$//"`
export appZipPrefix=`ls DropToScript*zip | sed -E "s/(_[0-9\.]*)?\.zip$//"`
export newAppZipFolder="${appZipPrefix}_${scriptsVersion}"

rm -rf $oldAppZipFolder

mkdir $newAppZipFolder
cd $newAppZipFolder

unzip ../$oldAppZipFolder.zip 

cd ..

rm $oldAppZipFolder.zip

export linuxScripts="$newAppZipFolder/Linux 64 bit/DropToScript/DropScripts"
export macScripts="$newAppZipFolder/OS X 64 bit/DropToScript/DropScripts"
export winScripts="$newAppZipFolder/Windows/DropToScript/DropScripts"

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
xattr -cr "$newAppZipFolder/OS X 64 bit/DropToScript/DropToScript.app"

cd $newAppZipFolder
zip -9 -r -y ../$newAppZipFolder.zip *
cd ..

rm -rf $newAppZipFolder
