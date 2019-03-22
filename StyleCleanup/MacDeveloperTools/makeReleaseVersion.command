#
# Use the C preprocessor to generate a release version of the StyleCleanup script
#

export cmdScriptDir=`dirname "$0"`
cd "$cmdScriptDir"
export cmdScriptDir=`pwd`
cd ..
export estkScriptDir=`pwd`

cat > StyleCleanup.jsx << EOF
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

cpp -w -C -E -P Source/StyleCleanup.jsx >> StyleCleanup.jsx 2>/dev/null
