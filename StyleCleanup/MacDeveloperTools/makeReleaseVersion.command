#
# Use the C preprocessor to generate a release version of the StyleCleanup script
#

export cmdScriptDir=`dirname "$0"`
cd "$cmdScriptDir"
export cmdScriptDir=`pwd`

cd ..
export estkScriptDir=`pwd`

export releaseVersionDir="$estkScriptDir/../ReleaseVersions"
if [ ! -e "$releaseVersionDir" ]; then
  mkdir "$releaseVersionDir"
fi

cat > "$releaseVersionDir/StyleCleanup.jsx" << EOF
// **** WARNING ****
//
// This is a release version of the StyleCleanup.jsx script
// It has been automatically collated from multiple source code files
//
// Apart from simple configuration changes, you should not edit
// this script. 
//
// Instead you should edit the original source code, then re-generate 
// this release version of the script from the updated source code
//
// *****************
EOF

sed -E "s/CONFIG_debug\.jsx/CONFIG\.jsx/" < Source/StyleCleanup.jsx > Source/StyleCleanup_makeReleaseVersion.tmp
cpp -w -C -E -P Source/StyleCleanup_makeReleaseVersion.tmp >> "$releaseVersionDir/StyleCleanup.jsx" 2>/dev/null
rm Source/StyleCleanup_makeReleaseVersion.tmp
