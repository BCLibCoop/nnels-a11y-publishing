// **** CONFIGURATION - BEGIN

// Set DEBUG to true to enable debugging facilities embedded in this script

var DEBUG            = true;

// Set LOG_TO_CONSOLE to true to enable logging to ExtendScript Toolkit 
// JavaScript Console window.

var LOG_TO_CONSOLE   = true;

// Set LOG_LEVEL to a value 0 to 4. The higher the value, the more extensive
// the log output will be
//
// 0 = LOG_NONE
// 1 = LOG_ERROR
// 2 = LOG_WARNING
// 3 = LOG_NOTE
// 4 = LOG_TRACE

var LOG_LEVEL        = 3; 

// Set FILE_PATH_LOG to either double-quoted file path or undefined. Examples:
//
// var FILE_PATH_LOG    = undefined;
// var FILE_PATH_LOG    = "/Users/kris/Desktop/t.log";
// var FILE_PATH_LOG    = "C:\\Users\\Kris Coppieters\\Desktop\\t.log";

var FILE_PATH_LOG    = undefined;

// Set LOG_ENTRY_EXIT to true to enable extensive logging on a per-function 
// call basis

var LOG_ENTRY_EXIT   = false;

// Flags all attributes to consider when comparing styles or style components
//
// If two styles are identical for these attributes, they will be 
// considered to be synonymous, and one of them could be considered for
// elimination.
//
// Set to 0 to ignore, and 1 to consider when comparing 
//
var ATTRIBUTES_FOR_STYLE_COMPARISONS = {
    ParagraphStyle: {
        alignToBaseline:             0,
        allowArbitraryHyphenation:   0,
        appliedFont:                 1,
        appliedLanguage:             0,
        appliedNumberingList:        0,
        autoLeading:                 0,
        autoTcy:                     0,
        autoTcyIncludeRoman:         0,
        balanceRaggedLines:          0,
        baselineShift:               0,
        bulletChar:                  0,
        bulletsAlignment:            0,
        bulletsAndNumberingListType: 0,
        bulletsCharacterStyle:       0,
        bulletsTextAfter:            0,
        bunriKinshi:                 0,
        capitalization:              1,
        characterAlignment:          1,
        characterDirection:          0,
        characterRotation:           0,
        cjkGridTracking:             0,
        composer:                    0,
        desiredGlyphScaling:         0,
        desiredLetterSpacing:        0
    },
    CharacterStyle: {

    }
};

// **** CONFIGURATION - END