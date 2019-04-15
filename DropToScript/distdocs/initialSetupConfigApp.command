#
# De-quarantine the DropToScript app
#

export scriptDir=`dirname "$0"`
cd "$scriptDir"

export scriptDir=`pwd`
export projectHomeDir=`dirname "$scriptDir"`

xattr -dr com.apple.quarantine DropToScript.app

echo "DropToScript.app is now de-quarantined."