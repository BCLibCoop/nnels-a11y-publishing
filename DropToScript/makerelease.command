export xojoHomeDir="/Applications/Xojo 2019 Release 1"
if [ ! -d "$xojoHomeDir" ]; then
  echo Please adjust this script with the correct Xojo home dirname
  exit
fi
export curDir=`dirname "$0"`
cd $curDir
export curDir=`pwd`
rm -rf ../../ReleaseVersions/DropToScript.*.zip
export version=`grep ShortVersion DropToScript.xojo_project | sed -e "s/ShortVersion=//"`
if [ -d "$xojoHomeDir" ]; then
	if [ -d "$curDir/Builds - DropToScript.xojo_project" ]; then
		cd "$curDir/Builds - DropToScript.xojo_project"
		cp -R "$curDir/distdocs/ReadMe.txt" .
		cp "$xojoHomeDir/Extras/Windows Runtime/Installers/vc_redist.x86.exe" ../../ReleaseVersions

		if [ ! -d "OS X 64 bit/DropToScript" ]; then
			mkdir "OS X 64 bit/DropToScript"
			mv "OS X 64 bit/DropToScript.app" "OS X 64 bit/DropToScript"
		fi

		find . -name ".DS_Store" | while read a; do rm "$a"; done
		find . -name "__MACOSX" | while read a; do rm -rf "$a"; done
		xattr -cr "OS X 64 bit/DropToScript/DropToScript.app"
		codesign --timestamp --verbose --deep --force --sign "Developer ID Application: Rorohiko Ltd. (UF54MCK725)" "OS X 64 bit/DropToScript/DropToScript.app"

		mv Windows/DropToScript/DropToScript.exe Windows/DropToScript/DropToScript.exe.unsigned
		osslsigncode sign -pkcs12 /Users/kris/Dropbox/RorohikoNotShared/Certificates/RorohikoSigningCert2023.p12 -askpass -n "DropToScript" -i "NNELS" -t http://timestamp.verisign.com/scripts/timstamp.dll -h sha2 -in Windows/DropToScript/DropToScript.exe.unsigned -out Windows/DropToScript/DropToScript.exe
		rm Windows/DropToScript/DropToScript.exe.unsigned

		zip -y -r ../../ReleaseVersions/DropToScript.$version.zip *
	
	fi
fi

cd $curDir

sleep 30

../DropScripts/makerelease.command