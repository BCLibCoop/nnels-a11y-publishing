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
//
// StyleCleanup.jsx - a script for Adobe InDesign
//
// v 1.0.2, April 11, 2019
// written by Kris Coppieters, kris@rorohiko.com
// https://www.linkedin.com/in/kristiaan/
//
// Commissioned by NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
//
// See License information at end of script.
//
// Check for updated versions at
//
// https://github.com/BCLibCoop/nnels-a11y-publishing
//
// ---------------
//
// About this script:
//
// This script will scan an InDesign document and find any manual text style overriddes
// Manual text style overrides are not easy to spot or clean up. 
//
// This script will help removing or restructuring these manual overrides.
//
// For each manual style override, the script will create a new paragraph or character
// style. Once all manual overrides have been converted to styles, the user can 
// then delete, rename, remap,... all these styles and clean up the document.
//



// The makeReleaseVersion.command script will replace this to "CONFIG.jsx" instead of "CONFIG.jsx"

// **** CONFIGURATION - BEGIN

// Set DEBUG to 1 to enable debugging facilities embedded in this script
// Set to 0 to disable

var DEBUG              = 0;

// Set LOG_TO_CONSOLE to 1 to enable logging to ExtendScript Toolkit 
// JavaScript Console window. Set to 0 to disable

var LOG_TO_CONSOLE     = 0;

// Set LOG_LEVEL to a value: 0 to 4. The higher the value, the more extensive
// the log output will be
//
// 0 = LOG_NONE
// 1 = LOG_ERROR
// 2 = LOG_WARNING
// 3 = LOG_NOTE
// 4 = LOG_TRACE

var LOG_LEVEL          = 0; 

// Set FILE_PATH_LOG to either double-quoted file path or undefined. Examples:
//
// var FILE_PATH_LOG    = undefined;
// var FILE_PATH_LOG    = "/Users/kris/Desktop/t.log";
// var FILE_PATH_LOG    = "C:\\Users\\Kris Coppieters\\Desktop\\t.log";

var FILE_PATH_LOG      = undefined;

// Set LOG_ENTRY_EXIT to 1 to enable extensive logging on a per-function 
// call basis. Set to 0 to disable

var LOG_ENTRY_EXIT     = 0;

// Set WRITE_STYLE_REPORT to 1 to enable a report file.

var WRITE_STYLE_REPORT = 1;

var ARTIFICIAL_PARA_STYLE_NAME_PREFIX = "ArtificialParaStyle_";
var ARTIFICIAL_CHAR_STYLE_NAME_PREFIX = "ArtificialCharStyle_";

// Flags all attributes to consider when comparing styles or style components
//
// If two styles are identical for these attributes, they will be 
// considered to be synonymous, and one of them could be considered for
// elimination.
//
// Set to: 0 to ignore, and: 1 to consider when comparing 
//
var ATTRIBUTES_FOR_STYLE_COMPARISONS = {
    ParagraphStyle: {
        alignToBaseline:                                0,
        allowArbitraryHyphenation:                      0,
        appliedFont:                                    1,
        appliedLanguage:                                0,
        appliedNumberingList:                           0,
        autoLeading:                                    0,
        autoTcy:                                        0,
        autoTcyIncludeRoman:                            0,
        balanceRaggedLines:                             0,
        basedOn:                                        0,
        baselineShift:                                  0,
        bulletChar:                                     0,
        bulletsAlignment:                               0,
        bulletsAndNumberingListType:                    0,
        bulletsCharacterStyle:                          0,
        bulletsTextAfter:                               0,
        bunriKinshi:                                    0,
        capitalization:                                 1,
        characterAlignment:                             1,
        characterDirection:                             1,
        characterRotation:                              1,
        cjkGridTracking:                                0,
        composer:                                       0,
        desiredGlyphScaling:                            0,
        desiredLetterSpacing:                           0,
        desiredWordSpacing:                             0,
        diacriticPosition:                              0,
        digitsType:                                     0,
        dropCapCharacters:                              0,
        dropcapDetail:                                  0,
        dropCapLines:                                   0,
        dropCapStyle:                                   0,
        emitCss:                                        0,
        endJoin:                                        0,
        eventListeners:                                 0,
        events:                                         0,
        fillColor:                                      1,
        fillTint:                                       1,
        firstLineIndent:                                1,
        fontStyle:                                      1,
        glyphForm:                                      0,
        gradientFillAngle:                              0,
        gradientFillLength:                             0,
        gradientFillStart:                              0,
        gradientStrokeAngle:                            0,
        gradientStrokeLength:                           0,
        gradientStrokeStart:                            0,
        gridAlignFirstLineOnly:                         0,
        gridAlignment:                                  0,
        gridGyoudori:                                   0,
        horizontalScale:                                1,
        hyphenateAcrossColumns:                         0,
        hyphenateAfterFirst:                            0,
        hyphenateBeforeLast:                            0,
        hyphenateCapitalizedWords:                      0,
        hyphenateLadderLimit:                           0,
        hyphenateLastWord:                              0,
        hyphenateWordsLongerThan:                       0,
        hyphenation:                                    0,
        hyphenationZone:                                0,
        hyphenWeight:                                   0,
        id:                                             0,
        ignoreEdgeAlignment:                            0,
        imported:                                       0,
        includeClass:                                   0,
        index:                                          0,
        isValid:                                        0,
        jidori:                                         0,
        justification:                                  1,
        kashidas:                                       0,
        keepAllLinesTogether:                           0,
        keepFirstLines:                                 0,
        keepLastLines:                                  0,
        keepLinesTogether:                              0,
        keepRuleAboveInFrame:                           0,
        keepWithNext:                                   0,
        keepWithPrevious:                               0,
        kentenAlignment:                                0,
        kentenCharacterSet:                             0,
        kentenCustomCharacter:                          0,
        kentenFillColor:                                0,
        kentenFont:                                     0,
        kentenFontSize:                                 0,
        kentenFontStyle:                                0,
        kentenKind:                                     0,
        kentenOverprintFill:                            0,
        kentenOverprintStroke:                          0,
        kentenPlacement:                                0,
        kentenPosition:                                 0,
        kentenStrokeColor:                              0,
        kentenStrokeTint:                               0,
        kentenTint:                                     0,
        kentenWeight:                                   0,
        kentenXScale:                                   0,
        kentenYScale:                                   0,
        kerningMethod:                                  0,
        keyboardDirection:                              0,
        kinsokuHangType:                                0,
        kinsokuSet:                                     0,
        kinsokuType:                                    0,
        label:                                          0,
        lastLineIndent:                                 1,
        leading:                                        1,
        leadingAki:                                     0,
        leadingModel:                                   0,
        leftIndent:                                     1,
        ligatures:                                      0,
        maximumGlyphScaling:                            0,
        maximumLetterSpacing:                           0,
        maximumWordSpacing:                             0,
        mergeConsecutiveParaBorders:                    0,
        minimumGlyphScaling:                            0,
        minimumLetterSpacing:                           0,
        minimumWordSpacing:                             0,
        miterLimit:                                     0,
        mojikumi:                                       0,
        name:                                           0,
        nestedGrepStyles:                               0,
        nestedLineStyles:                               0,
        nestedStyles:                                   0,
        nextStyle:                                      0,
        noBreak:                                        0,
        numberingAlignment:                             0,
        numberingApplyRestartPolicy:                    0,
        numberingCharacterStyle:                        0,
        numberingContinue:                              0,
        numberingExpression:                            0,
        numberingFormat:                                0,
        numberingLevel:                                 0,
        numberingRestartPolicies:                       0,
        numberingStartAt:                               0,
        otfContextualAlternate:                         0,
        otfDiscretionaryLigature:                       0,
        otfFigureStyle:                                 0,
        otfFraction:                                    0,
        otfHistorical:                                  0,
        otfHVKana:                                      0,
        otfJustificationAlternate:                      0,
        otfLocale:                                      0,
        otfMark:                                        0,
        otfOrdinal:                                     0,
        otfOverlapSwash:                                0,
        otfProportionalMetrics:                         0,
        otfRomanItalics:                                0,
        otfSlashedZero:                                 0,
        otfStretchedAlternate:                          0,
        otfStylisticAlternate:                          0,
        otfStylisticSets:                               0,
        otfSwash:                                       0,
        otfTitling:                                     0,
        overprintFill:                                  0,
        overprintStroke:                                0,
        paragraphBorderBottomLeftCornerOption:          0,
        paragraphBorderBottomLeftCornerRadius:          0,
        paragraphBorderBottomLineWeight:                0,
        paragraphBorderBottomOffset:                    0,
        paragraphBorderBottomOrigin:                    0,
        paragraphBorderBottomRightCornerOption:         0,
        paragraphBorderBottomRightCornerRadius:         0,
        paragraphBorderColor:                           0,
        paragraphBorderDisplayIfSplits:                 0,
        paragraphBorderGapColor:                        0,
        paragraphBorderGapOverprint:                    0,
        paragraphBorderGapTint:                         0,
        paragraphBorderLeftLineWeight:                  0,
        paragraphBorderLeftOffset:                      0,
        paragraphBorderOn:                              0,
        paragraphBorderOverprint:                       0,
        paragraphBorderRightLineWeight:                 0,
        paragraphBorderRightOffset:                     0,
        paragraphBorderStrokeEndCap:                    0,
        paragraphBorderStrokeEndJoin:                   0,
        paragraphBorderTint:                            0,
        paragraphBorderTopLeftCornerOption:             0,
        paragraphBorderTopLeftCornerRadius:             0,
        paragraphBorderTopLineWeight:                   0,
        paragraphBorderTopOffset:                       0,
        paragraphBorderTopOrigin:                       0,
        paragraphBorderTopRightCornerOption:            0,
        paragraphBorderTopRightCornerRadius:            0,
        paragraphBorderType:                            0,
        paragraphBorderWidth:                           0,
        paragraphDirection:                             0,
        paragraphGyoudori:                              0,
        paragraphJustification:                         1,
        paragraphKashidaWidth:                          0,
        paragraphShadingBottomLeftCornerOption:         0,
        paragraphShadingBottomLeftCornerRadius:         0,
        paragraphShadingBottomOffset:                   0,
        paragraphShadingBottomOrigin:                   0,
        paragraphShadingBottomRightCornerOption:        0,
        paragraphShadingBottomRightCornerRadius:        0,
        paragraphShadingClipToFrame:                    0,
        paragraphShadingColor:                          0,
        paragraphShadingLeftOffset:                     0,
        paragraphShadingOn:                             0,
        paragraphShadingOverprint:                      0,
        paragraphShadingRightOffset:                    0,
        paragraphShadingSuppressPrinting:               0,
        paragraphShadingTint:                           0,
        paragraphShadingTopLeftCornerOption:            0,
        paragraphShadingTopLeftCornerRadius:            0,
        paragraphShadingTopOffset:                      0,
        paragraphShadingTopOrigin:                      0,
        paragraphShadingTopRightCornerOption:           0,
        paragraphShadingTopRightCornerRadius:           0,
        paragraphShadingWidth:                          0,
        parent:                                         0,
        pointSize:                                      1,
        position:                                       0,
        positionalForm:                                 0,
        preferences:                                    0,
        previewColor:                                   0,
        properties:                                     0,
        providerHyphenationStyle:                       0,
        rensuuji:                                       0,
        rightIndent:                                    1,
        rotateSingleByteCharacters:                     0,
        rubyAlignment:                                  0,
        rubyAutoAlign:                                  0,
        rubyAutoScaling:                                0,
        rubyAutoTcyAutoScale:                           0,
        rubyAutoTcyDigits:                              0,
        rubyAutoTcyIncludeRoman:                        0,
        rubyFill:                                       0,
        rubyFont:                                       0,
        rubyFontSize:                                   0,
        rubyFontStyle:                                  0,
        rubyOpenTypePro:                                0,
        rubyOverhang:                                   0,
        rubyOverprintFill:                              0,
        rubyOverprintStroke:                            0,
        rubyParentOverhangAmount:                       0,
        rubyParentScalingPercent:                       0,
        rubyParentSpacing:                              0,
        rubyPosition:                                   0,
        rubyStroke:                                     0,
        rubyStrokeTint:                                 0,
        rubyTint:                                       0,
        rubyType:                                       0,
        rubyWeight:                                     0,
        rubyXOffset:                                    0,
        rubyXScale:                                     0,
        rubyYOffset:                                    0,
        rubyYScale:                                     0,
        ruleAbove:                                      1,
        ruleAboveColor:                                 0,
        ruleAboveGapColor:                              0,
        ruleAboveGapOverprint:                          0,
        ruleAboveGapTint:                               0,
        ruleAboveLeftIndent:                            0,
        ruleAboveLineWeight:                            0,
        ruleAboveOffset:                                0,
        ruleAboveOverprint:                             0,
        ruleAboveRightIndent:                           0,
        ruleAboveTint:                                  0,
        ruleAboveType:                                  0,
        ruleAboveWidth:                                 0,
        ruleBelow:                                      1,
        ruleBelowColor:                                 0,
        ruleBelowGapColor:                              0,
        ruleBelowGapOverprint:                          0,
        ruleBelowGapTint:                               0,
        ruleBelowLeftIndent:                            0,
        ruleBelowLineWeight:                            0,
        ruleBelowOffset:                                0,
        ruleBelowOverprint:                             0,
        ruleBelowRightIndent:                           0,
        ruleBelowTint:                                  0,
        ruleBelowType:                                  0,
        ruleBelowWidth:                                 0,
        sameParaStyleSpacing:                           0,
        scaleAffectsLineHeight:                         0,
        shataiAdjustRotation:                           0,
        shataiAdjustTsume:                              0,
        shataiDegreeAngle:                              0,
        shataiMagnification:                            0,
        singleWordJustification:                        0,
        skew:                                           0,
        spaceAfter:                                     1,
        spaceBefore:                                    1,
        spanColumnMinSpaceAfter:                        0,
        spanColumnMinSpaceBefore:                       0,
        spanColumnType:                                 0,
        spanSplitColumnCount:                           0,
        splitColumnInsideGutter:                        0,
        splitColumnOutsideGutter:                       0,
        splitDocument:                                  0,
        startParagraph:                                 0,
        strikeThroughColor:                             0,
        strikeThroughGapColor:                          0,
        strikeThroughGapOverprint:                      0,
        strikeThroughGapTint:                           0,
        strikeThroughOffset:                            0,
        strikeThroughOverprint:                         0,
        strikeThroughTint:                              0,
        strikeThroughType:                              0,
        strikeThroughWeight:                            0,
        strikeThru:                                     0,
        strokeAlignment:                                0,
        strokeColor:                                    0,
        strokeTint:                                     0,
        strokeWeight:                                   0,
        styleExportTagMaps:                             0,
        styleUniqueId:                                  0,
        tabList:                                        0,
        tabStops:                                       0,
        tatechuyoko:                                    0,
        tatechuyokoXOffset:                             0,
        tatechuyokoYOffset:                             0,
        tracking:                                       0,
        trailingAki:                                    0,
        treatIdeographicSpaceAsSpace:                   0,
        tsume:                                          0,
        underline:                                      1,
        underlineColor:                                 0,
        underlineGapColor:                              0,
        underlineGapOverprint:                          0,
        underlineGapTint:                               0,
        underlineOffset:                                0,
        underlineOverprint:                             0,
        underlineTint:                                  0,
        underlineType:                                  0,
        underlineWeight:                                0,
        verticalScale:                                  1,
        warichu:                                        0,
        warichuAlignment:                               0,
        warichuCharsAfterBreak:                         0,
        warichuCharsBeforeBreak:                        0,
        warichuLines:                                   0,
        warichuLineSpacing:                             0,
        warichuSize:                                    0,
        xOffsetDiacritic:                               0,
        yOffsetDiacritic:                               0
    },
    CharacterStyle: {
        appliedFont:                                    1,
        appliedLanguage:                                0,
        basedOn:                                        0,
        baselineShift:                                  0,
        capitalization:                                 1,
        characterAlignment:                             1,
        characterDirection:                             1,
        characterRotation:                              1,
        cjkGridTracking:                                0,
        diacriticPosition:                              0,
        digitsType:                                     0,
        emitCss:                                        0,
        endJoin:                                        0,
        eventListeners:                                 0,
        events:                                         0,
        fillColor:                                      1,
        fillTint:                                       1,
        fontStyle:                                      1,
        glyphForm:                                      0,
        gradientFillAngle:                              0,
        gradientFillLength:                             0,
        gradientFillStart:                              0,
        gradientStrokeAngle:                            0,
        gradientStrokeLength:                           0,
        gradientStrokeStart:                            0,
        horizontalScale:                                1,
        id:                                             0,
        imported:                                       0,
        includeClass:                                   0,
        index:                                          0,
        isValid:                                        0,
        jidori:                                         0,
        kashidas:                                       0,
        kentenAlignment:                                0,
        kentenCharacterSet:                             0,
        kentenCustomCharacter:                          0,
        kentenFillColor:                                0,
        kentenFont:                                     0,
        kentenFontSize:                                 0,
        kentenFontStyle:                                0,
        kentenKind:                                     0,
        kentenOverprintFill:                            0,
        kentenOverprintStroke:                          0,
        kentenPlacement:                                0,
        kentenPosition:                                 0,
        kentenStrokeColor:                              0,
        kentenStrokeTint:                               0,
        kentenTint:                                     0,
        kentenWeight:                                   0,
        kentenXScale:                                   0,
        kentenYScale:                                   0,
        kerningMethod:                                  0,
        keyboardDirection:                              0,
        label:                                          0,
        leading:                                        1,
        leadingAki:                                     0,
        ligatures:                                      0,
        miterLimit:                                     0,
        name:                                           0,
        noBreak:                                        0,
        otfContextualAlternate:                         0,
        otfDiscretionaryLigature:                       0,
        otfFigureStyle:                                 0,
        otfFraction:                                    0,
        otfHistorical:                                  0,
        otfHVKana:                                      0,
        otfJustificationAlternate:                      0,
        otfLocale:                                      0,
        otfMark:                                        0,
        otfOrdinal:                                     0,
        otfOverlapSwash:                                0,
        otfProportionalMetrics:                         0,
        otfRomanItalics:                                0,
        otfSlashedZero:                                 0,
        otfStretchedAlternate:                          0,
        otfStylisticAlternate:                          0,
        otfStylisticSets:                               0,
        otfSwash:                                       0,
        otfTitling:                                     0,
        overprintFill:                                  0,
        overprintStroke:                                0,
        parent:                                         0,
        pointSize:                                      1,
        position:                                       0,
        positionalForm:                                 0,
        previewColor:                                   0,
        properties:                                     0,
        rubyAlignment:                                  0,
        rubyAutoAlign:                                  0,
        rubyAutoScaling:                                0,
        rubyAutoTcyAutoScale:                           0,
        rubyAutoTcyDigits:                              0,
        rubyAutoTcyIncludeRoman:                        0,
        rubyFill:                                       0,
        rubyFont:                                       0,
        rubyFontSize:                                   0,
        rubyFontStyle:                                  0,
        rubyOpenTypePro:                                0,
        rubyOverhang:                                   0,
        rubyOverprintFill:                              0,
        rubyOverprintStroke:                            0,
        rubyParentOverhangAmount:                       0,
        rubyParentScalingPercent:                       0,
        rubyParentSpacing:                              0,
        rubyPosition:                                   0,
        rubyStroke:                                     0,
        rubyStrokeTint:                                 0,
        rubyTint:                                       0,
        rubyType:                                       0,
        rubyWeight:                                     0,
        rubyXOffset:                                    0,
        rubyXScale:                                     0,
        rubyYOffset:                                    0,
        rubyYScale:                                     0,
        scaleAffectsLineHeight:                         0,
        shataiAdjustRotation:                           0,
        shataiAdjustTsume:                              0,
        shataiDegreeAngle:                              0,
        shataiMagnification:                            0,
        skew:                                           0,
        splitDocument:                                  0,
        strikeThroughColor:                             0,
        strikeThroughGapColor:                          0,
        strikeThroughGapOverprint:                      0,
        strikeThroughGapTint:                           0,
        strikeThroughOffset:                            0,
        strikeThroughOverprint:                         0,
        strikeThroughTint:                              0,
        strikeThroughType:                              0,
        strikeThroughWeight:                            0,
        strikeThru:                                     0,
        strokeAlignment:                                0,
        strokeColor:                                    0,
        strokeTint:                                     0,
        strokeWeight:                                   0,
        styleExportTagMaps:                             0,
        styleUniqueId:                                  0,
        tatechuyoko:                                    0,
        tatechuyokoXOffset:                             0,
        tatechuyokoYOffset:                             0,
        tracking:                                       0,
        trailingAki:                                    0,
        tsume:                                          0,
        underline:                                      1,
        underlineColor:                                 0,
        underlineGapColor:                              0,
        underlineGapOverprint:                          0,
        underlineGapTint:                               0,
        underlineOffset:                                0,
        underlineOverprint:                             0,
        underlineTint:                                  0,
        underlineType:                                  0,
        underlineWeight:                                0,
        verticalScale:                                  1,
        warichu:                                        0,
        warichuAlignment:                               0,
        warichuCharsAfterBreak:                         0,
        warichuCharsBeforeBreak:                        0,
        warichuLines:                                   0,
        warichuLineSpacing:                             0,
        warichuSize:                                    0,
        xOffsetDiacritic:                               0,
        yOffsetDiacritic:                               0
    }
};

// **** CONFIGURATION - END
//
// LOG.jsx - an ExtendScript shared module for Adobe InDesign
//
// v 1.0.0, March 23, 2019
// written by Kris Coppieters, kris@rorohiko.com
// https://www.linkedin.com/in/kristiaan/
//
// Commissioned by NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
//
// See License information at end of script.
//
// Check for source code at
//
// https://github.com/BCLibCoop/nnels-a11y-publishing
//
// ---------------
//
// About this module
//
// This module provides logging facilities for ExtendScript code
//

var LOG;
if (! LOG) {
(function() {

// --

LOG = {};	

LOG.LOG_NONE    = 0;
LOG.LOG_ERROR   = 1;
LOG.LOG_WARNING = 2;
LOG.LOG_NOTE    = 3;
LOG.LOG_TRACE   = 4;

LOG.LOG_TO_CONSOLE   = false;
LOG.LOG_LEVEL        = LOG.LOG_NONE;
LOG.LOG_ENTRY_EXIT   = false;
LOG.FILE_PATH_LOG    = undefined; // File path or undefined

LOG.logMessage = function(in_message) {

	if (! LOG.busyWriting) {
		LOG.busyWriting = true;
		try {
			if (LOG.LOG_TO_CONSOLE) {
				$.writeln(in_message);
			}
			if (LOG.FILE_PATH_LOG) {
				var f = File(LOG.FILE_PATH_LOG);
				f.open("a");
				f.writeln(in_message);
				f.close();
			}
		}
		catch (err) {		
		}
		LOG.busyWriting = false;
	}
	
};

LOG.logError = function(in_message) {
	if (LOG.LOG_LEVEL >= LOG.LOG_ERROR) {
		LOG.logMessage("ERROR: " + in_message);
	}
};

LOG.logWarning = function(in_message) {
	if (LOG.LOG_LEVEL >= LOG.LOG_WARNING) {
		LOG.logMessage("WARN : " + in_message);
	}
};

LOG.logNote = function(in_message) {
	if (LOG.LOG_LEVEL >= LOG.LOG_NOTE) {
		LOG.logMessage("NOTE : " + in_message);
	}
};

LOG.logTrace = function(in_message) {
	if (LOG.LOG_LEVEL >= LOG.LOG_TRACE) {
		LOG.logMessage("TRACE: " + in_message);
	}
};

LOG.logEntry = function(in_functionName) {
	if (LOG.LOG_ENTRY_EXIT) {
		LOG.logTrace("ENTRY: " + in_functionName);
	}
};

LOG.logExit = function(in_functionName) {
	if (LOG.LOG_ENTRY_EXIT) {
		LOG.logTrace("EXIT : " + in_functionName);
	}
};


// --

})();}

/*************************************************************

LOG.jsx

(c) 2019 NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
https://nnels.ca/

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of NNELS, nor the names of its contributors
  may be used to endorse or promote products derived from this software without
  specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.

==============================================
*/

   //
// UTILS.jsx - an ExtendScript shared module for Adobe InDesign
//
// v 1.0.0, March 23, 2019
// written by Kris Coppieters, kris@rorohiko.com
// https://www.linkedin.com/in/kristiaan/
//
// Commissioned by NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
//
// See License information at end of script.
//
// Check for source code at
//
// https://github.com/BCLibCoop/nnels-a11y-publishing
//
// ---------------
//
// About this module
//
// This module provides some additional utility functions for ExtendScript code
//

var UTILS;
if (DEBUG) {
    UTILS = undefined;
}
if (! UTILS) {
(function() {

// --

UTILS = {}; 

UTILS.REGEXP_EXTRACT_FUNCTION_NAME = /function (.{1,})\(/;
UTILS.REGEXP_SPACES = /\s/g;

UTILS.shortenedString = function(in_s, in_targetLength) {

    var retVal;

    LOG.logEntry("UTILS.shortenedString");

    try {
        if (in_s.length <= in_targetLength) {
            retVal = in_s;
        }
        else {
            var splitLen = Math.trunc((in_targetLen - 3) / 2);
            retVal = in_s.substr(0, splitLen) + "..." + in_s.substr(-splitLen);
        }
    }
    catch (err) {
        LOG.logError("UTILS.shortenedString: throws " + err);
    }

    LOG.logExit("UTILS.shortenedString");

    return retVal;
}

UTILS.baseName = function(in_filePath, in_separator) {
    
    var retVal = undefined;

    LOG.logEntry("UTILS.baseName");

    try {

        if (! in_separator) {
            in_separator = UTILS.SEPARATOR;
        }

        LOG.logNote("UTILS.baseName: using separator " + in_separator);

        // toString() handles cases where in_filePath is an ExtendScript File/Folder object
        var splitPath = in_filePath.toString().split(in_separator);
        do {
            var endSegment = splitPath.pop();   
        }
        while (splitPath.length > 0 && endSegment == "");

        retVal = endSegment;
    }
    catch (err) {
        LOG.logError("UTILS.baseName: throws " + err);
        retVal = undefined;
    }

    return retVal;
};

UTILS.checkMac = function() {
    var retVal = $.os.substr(0,3) == "Mac";
    return retVal;
};

UTILS.deepClone = function(in_obj) {

    var retVal = undefined;

    LOG.logEntry("UTILS.deepClone");

    try {
        if (in_obj instanceof Array) {
            retVal = [];
        }
        else {
            retVal = {};        
        }

        for (var x in in_obj) 
        {
            var val = in_obj[x];
            if (typeof val == "object")
            {
                retVal[x] = UTILS.deepClone(val);
            }
            else
            {
                retVal[x] = val;
            }
        }       
    }
    catch (err) {
        LOG.logError("UTILS.deepClone: throws " + err);
        retVal = undefined;
    }

    LOG.logExit("UTILS.deepClone");

    return retVal;
};

UTILS.despace = function(s) {
    var retVal = s.replace(UTILS.REGEXP_SPACES, "");
    return retVal;
};

UTILS.dirName = function(in_filePath, in_separator) {
    
    var retVal = undefined;

    LOG.logEntry("UTILS.dirName");

    try {

        if (! in_separator) {
            in_separator = UTILS.SEPARATOR;
        }

        LOG.logNote("UTILS.dirName: using in_separator " + in_separator);

        // toString() handles cases where in_filePath is an ExtendScript File/Folder object
        var splitPath = in_filePath.toString().split(in_separator);
        do {
            var endSegment = splitPath.pop();   
        }
        while (splitPath.length > 0 && endSegment == "");

        retVal = splitPath.join(in_separator) + in_separator;
    }
    catch (err) {
        LOG.logError("UTILS.dirName: throws " + err);            
    }
    
    LOG.logExit("UTILS.dirName");

    return retVal;
};

UTILS.dQ = function(in_s) {

    var retVal = '"' + in_s.replace(/\\/g,"\\\\").replace(/"/g,'\\"') + '"';
    return retVal;

};

UTILS.endsWith = function(in_s, in_end) {

    var retVal = in_s.substr(-in_end.length) == in_end;
    return retVal;

};

UTILS.exists = function(in_filePath) {
    var f = File(in_filePath);
    var retVal = f.exists;
    return retVal;
};

UTILS.fileNameExtension = function(in_filePath, in_separator) {

    var retVal = "";

    LOG.logEntry("UTILS.fileNameExtension");

    try {
        var splitName = UTILS.baseName(in_filePath, in_separator).split(".");
        if (splitName.length > 1) {
            retVal = splitName.pop();
            retVal = retVal.toLowerCase();
        }
    }
    catch (err) {
        LOG.logError("UTILS.fileNameExtension: throws " + err);            
    }
    
    LOG.logExit("UTILS.fileNameExtension");

    return retVal;
};

UTILS.getClassName = function(in_object) {

    var retVal;

    LOG.logEntry("UTILS.getClassName");

    do {
        try {
            if ("object" != typeof in_object) {
                LOG.logError("UTILS.getClassName: in_object is not an object");
                break;
            }

            if (! in_object) {
                LOG.logError("UTILS.getClassName: no in_object");
                break;
            }

            var match = UTILS.REGEXP_EXTRACT_FUNCTION_NAME.exec(in_object.constructor.toString());
            retVal = (match && match.length > 1) ? match[1] : "";
        }
        catch (err) {
            LOG.logError("UTILS.getClassName: throws " + err);            
        }
    }
    while (false);
    
    LOG.logExit("UTILS.getClassName");

    return retVal;
};

UTILS.hashCode = function(in_s) {

    LOG.logEntry("UTILS.hashCode");

    var hash = 0;

    do {

        try {

            if (! in_s.length) {
                break;
            }

            for (var i = 0; i < in_s.length; i++) {
                var chr = in_s.charCodeAt(i);
                hash = ((hash << 5) - hash) + chr;
                hash |= 0; // Convert to 32bit integer
            }            
        }
        catch (err) {
            LOG.logError("UTILS.hashCode: throws " + err);            
        }
    }
    while (false);

    LOG.logExit("UTILS.hashCode");

    return hash;
};

UTILS.isDir = function(in_folderPath) {
    
    // This casts to a File instead of a Folder if the
    // path references a file

    var folder = Folder(in_folderPath);
    var retVal = (folder instanceof Folder);

    return retVal;
};

UTILS.mkdir = function(in_folderPath, in_separator) {

    var success = false;

    do {
        try {
            if (! in_folderPath) {
                LOG.logError("UTILS.mkdir: no in_folderPath");
                break;
            }

            if (UTILS.exists(in_folderPath)) {
                success = true;
                break;
            }

            var parentFolderPath = UTILS.dirName(in_folderPath, in_separator);
            success = UTILS.mkdir(parentFolderPath, in_separator);
            if (! success) {
                LOG.logError("UTILS.mkdir: cannot create parent folder");
                break;
            }

            var folder = Folder(in_folderPath);
            folder.create();
            success = folder.exists;
        }
        catch (err) {
            LOG.logError("UTILS.mkdir throws" + err);       
        }
    }
    while (false);
    
    return success;
};

UTILS.shallowClone = function(in_obj) 
{
    var retVal = {};
    for (var x in in_obj) 
    {
        retVal[x] = in_obj[x];
    }

    return retVal;
}

UTILS.startsWith = function(in_s, in_start) {
    var retVal = in_s.substr(0, in_start.length) == in_start;
    return retVal;
};

UTILS.stripFileNameExtension = function(in_filePath, in_separator) {

    var retVal = in_filePath;
    
    do {
        try {

            var fileNameExtension = UTILS.fileNameExtension(in_filePath);
            if (! fileNameExtension) {
                break;
            }

            retVal = in_filePath.substr(0, in_filePath.length - fileNameExtension.length - 1);
        }
        catch (err) {
            LOG.logError("UTILS.stripFileNameExtension: throws " + err);
        }
    }
    while (false);

    return retVal;
}

if (UTILS.checkMac()) {
    UTILS.SEPARATOR = "/";
    UTILS.isMac = true;
    UTILS.isWindows = false;
}
else {
    UTILS.SEPARATOR = "\\";
    UTILS.isMac = false;
    UTILS.isWindows = true;
}

// --

})();}

/*************************************************************

UTILS.jsx

(c) 2019 NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
https://nnels.ca/

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

* Neither the name of NNELS, nor the names of its contributors
    may be used to endorse or promote products derived from this software without
    specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.

==============================================
*/

   var STYC;
if (DEBUG) {
    // Clear persistent code on each run when debugging
    STYC = undefined;
}

if (! STYC) {
STYC = {};
(function() {

// ----

STYC.addToCharacterStyleLookup = function(io_context, in_characterStyle, in_definingTextStyleRangeHash) {

    var success = false;
    
    LOG.logEntry("STYC.addToCharacterStyleLookup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.addToCharacterStyleLookup: no io_context");
                break;
            }

            if (! (in_characterStyle instanceof CharacterStyle)) {
                LOG.logError("STYC.addToCharacterStyleLookup: no in_characterStyle");
                break;
            }

            success = true;
            
            var characterStyleHash = STYC.inDesignElementHash(io_context, in_characterStyle);

            if (! characterStyleHash) {
                break;
            }

            if (! io_context.characterStylesByHash) {
                io_context.characterStylesByHash = {};
            }

            var characterStyleByHashString = io_context.characterStylesByHash[characterStyleHash.hash];
            if (! characterStyleByHashString) {
                characterStyleByHashString = {};
                io_context.characterStylesByHash[characterStyleHash.hash] = characterStyleByHashString;
            }

            var characterStylesByName = characterStyleByHashString[characterStyleHash.string];
            if (! characterStylesByName) {
                characterStylesByName = {};
                characterStyleByHashString[characterStyleHash.string] = characterStylesByName;
            }

            characterStylesByName[in_characterStyle.name] = in_characterStyle;

            if (! in_definingTextStyleRangeHash) {
                break;
            }

            if (! io_context.artificialCharacterStylesByDefiningTextStyleRangeHashString) {
                io_context.artificialCharacterStylesByDefiningTextStyleRangeHashString = {};
            }

            io_context.artificialCharacterStylesByDefiningTextStyleRangeHashString[in_definingTextStyleRangeHash.string] = in_characterStyle;

        }
        catch (err) {
            LOG.logError("STYC.addToCharacterStyleLookup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.addToCharacterStyleLookup");
    
    return success;
}

STYC.addToParagraphStyleLookup = function(io_context, in_paragraphStyle, in_isArtificial) {

    var success = false;
    
    LOG.logEntry("STYC.addToParagraphStyleLookup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.addToParagraphStyleLookup: no io_context");
                break;
            }

            if (! (in_paragraphStyle instanceof ParagraphStyle)) {
                LOG.logError("STYC.addToParagraphStyleLookup: no in_paragraphStyle");
                break;
            }

            success = true;
            
            var paragraphStyleHash = STYC.inDesignElementHash(io_context, in_paragraphStyle);
            if (! paragraphStyleHash) {
                break;
            }

            if (! io_context.paragraphStyleLookup) {
                io_context.paragraphStyleLookup = {};
            }

            var paragraphStyleByHashString = io_context.paragraphStyleLookup[paragraphStyleHash.hash];
            if (! paragraphStyleByHashString) {
                paragraphStyleByHashString = {};
                io_context.paragraphStyleLookup[paragraphStyleHash.hash] = paragraphStyleByHashString;
            }

            var paragraphStylesByName = paragraphStyleByHashString[paragraphStyleHash.string];
            if (! paragraphStylesByName) {
                paragraphStylesByName = {};
                paragraphStyleByHashString[paragraphStyleHash.string] = paragraphStylesByName;
            }

            paragraphStylesByName[in_paragraphStyle.name] = in_paragraphStyle;

            if (! in_isArtificial) {
                break;
            }
        
            if (! io_context.artificialParagraphStylesByHashString) {
                io_context.artificialParagraphStylesByHashString = {};
            }

            io_context.artificialParagraphStylesByHashString[paragraphStyleHash.string] = in_paragraphStyle;

        }
        catch (err) {
            LOG.logError("STYC.addToParagraphStyleLookup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.addToParagraphStyleLookup");
    
    return success;
}

STYC.appendLineToReport = function(io_context, in_line) {

    LOG.logEntry("STYC.appendLineToReport");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.appendLineToReport: no io_context");
                break;
            }

            if (! io_context.report) {
                io_context.report = "";
            }

            if (! in_line) {
                in_line = ""; 
            }

            io_context.report += in_line + "\n";
        }
        catch (err) {
            LOG.logError("STYC.appendLineToReport: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.appendLineToReport");
}

STYC.buildCharacterStyleLookup = function(io_context) {

    var success = false;
    
    LOG.logEntry("STYC.buildCharacterStyleLookup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.buildCharacterStyleLookup: no io_context");
                break;
            }

            var doc = io_context.doc;
            if (! (doc instanceof Document)) {
                LOG.logError("STYC.buildCharacterStyleLookup: no doc");
                break;
            }

            success = true;
            
            var characterStyles = doc.characterStyles;
            if (! characterStyles || characterStyles.length == 0) {
                LOG.logWarning("STYC.buildCharacterStyleLookup: doc contains no character styles");
                break;
            }

            for (var characterStyleIdx = 0; characterStyleIdx < characterStyles.length; characterStyleIdx++) {
                var characterStyle = characterStyles.item(characterStyleIdx);
                STYC.addToCharacterStyleLookup(io_context, characterStyle);
            }

        }
        catch (err) {
            LOG.logError("STYC.buildCharacterStyleLookup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.buildCharacterStyleLookup");
    
    return success;
}

STYC.buildParagraphStyleLookup = function(io_context) {

    var success = false;
    
    LOG.logEntry("STYC.buildParagraphStyleLookup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.buildParagraphStyleLookup: no io_context");
                break;
            }

            var doc = io_context.doc;
            if (! (doc instanceof Document)) {
                LOG.logError("STYC.buildParagraphStyleLookup: no doc");
                break;
            }

            success = true;
            
            var paragraphStyles = doc.paragraphStyles;
            if (! paragraphStyles || paragraphStyles.length == 0) {
                LOG.logWarning("STYC.buildParagraphStyleLookup: doc contains no paragraph styles");
                break;
            }

            for (var paragraphStyleIdx = 0; paragraphStyleIdx < paragraphStyles.length; paragraphStyleIdx++) {
                var paragraphStyle = paragraphStyles.item(paragraphStyleIdx);
                STYC.addToParagraphStyleLookup(io_context, paragraphStyle);
            }

        }
        catch (err) {
            LOG.logError("STYC.buildParagraphStyleLookup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.buildParagraphStyleLookup");
    
    return success;
}

STYC.equalHashes = function(in_hash1, in_hash2) {

    var retVal = false;

    LOG.logEntry("STYC.equalHashes");

    do {
        if (in_hash1 && ! in_hash2) {
            break;
        }

        if (in_hash2 && ! in_hash1) {
            break;
        }

        if (! in_hash1 && ! in_hash2) {
            retVal = true;
            break;
        }

        retVal = in_hash1.hash == in_hash2.hash && in_hash1.string == in_hash2.string;
    }
    while (false);

    LOG.logExit("STYC.equalHashes");

    return retVal;
}

STYC.generateCharacterStyleReport = function(io_context) {

    var success = false;
    
    LOG.logEntry("STYC.generateCharacterStyleReport");

    try {

        success = true;

        var styleReportState = 0;

        var styleGroupNumber = 0;
        for (var hashCode in io_context.characterStylesByHash) {
            var characterStyleByHashString = io_context.characterStylesByHash[hashCode];
            for (var hashString in characterStyleByHashString) {
                var characterStylesByName = characterStyleByHashString[hashString];
                var styleGroupState = 0;
                var styleGroupReportBuffer = "";
                // Do not write groups with just one style
                for (var styleName in characterStylesByName) {
                    if (styleGroupState == 0) {
                        styleGroupState = 1;
                        styleGroupNumber++;
                        styleGroupReportBuffer += "### Character Style Group " + styleGroupNumber + "\n";
                        styleGroupReportBuffer += " " + styleName;
                    }
                    else {
                        if (styleGroupState == 1) {
                            styleGroupState = 2;
                            if (styleReportState == 0) {
                                styleReportState = 1;
                                STYC.appendLineToReport(io_context, "## Character Style Report");
                            }
                            STYC.appendLineToReport(io_context, styleGroupReportBuffer);
                        }
                        STYC.appendLineToReport(io_context, " " + styleName);
                    }
                }
                if (styleGroupState == 2) {
                    STYC.appendLineToReport(io_context);                
                }
            }
        }

        if (styleReportState == 0) {
            STYC.appendLineToReport(io_context, "## Character Style Report: no synonyms found");
        }
    }
    catch (err) {
        LOG.logError("STYC.generateCharacterStyleReport: throws " + err);
    }

    LOG.logExit("STYC.generateCharacterStyleReport");
    
    return success;
}

STYC.generateParagraphStyleReport = function(io_context) {

    var success = false;
    
    LOG.logEntry("STYC.generateParagraphStyleReport");

    try {

        success = true;

        var styleReportState = 0;

        var styleGroupNumber = 0;
        for (var hashCode in io_context.paragraphStyleLookup) {
            var paragraphStyleByHashString = io_context.paragraphStyleLookup[hashCode];
            for (var hashString in paragraphStyleByHashString) {
                var paragraphStylesByName = paragraphStyleByHashString[hashString];
                var styleGroupState = 0;
                var styleGroupReportBuffer = "";
                // Do not write groups with just one style
                for (var styleName in paragraphStylesByName) {
                    if (styleGroupState == 0) {
                        styleGroupState = 1;
                        styleGroupNumber++;
                        styleGroupReportBuffer += "### Paragraph Style Group " + styleGroupNumber + "\n";
                        styleGroupReportBuffer += " " + styleName;
                    }
                    else {
                        if (styleGroupState == 1) {
                            styleGroupState = 2;
                            if (styleReportState == 0) {
                                styleReportState = 1;
                                STYC.appendLineToReport(io_context, "## Paragraph Style Report");
                            }
                            STYC.appendLineToReport(io_context, styleGroupReportBuffer);
                        }
                        STYC.appendLineToReport(io_context, " " + styleName);
                    }
                }
                if (styleGroupState == 2) {
                    STYC.appendLineToReport(io_context);                
                }
            }
        }

        if (styleReportState == 0) {
            STYC.appendLineToReport(io_context, "## Paragraph Style Report: no synonyms found");
        }

    }
    catch (err) {
        LOG.logError("STYC.generateParagraphStyleReport: throws " + err);
    }

    LOG.logExit("STYC.generateParagraphStyleReport");
    
    return success;
}

STYC.inDesignElementHash = function(io_context, in_element) {

    function wrapHash(hashString) {
        return {
            hash: UTILS.hashCode(hashString),
            string: hashString
        };
    }

    var retVal = undefined;

    LOG.logEntry("STYC.inDesignElementHash");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.inDesignElementHash: no io_context");
                break;
            }

            if (in_element === undefined) {
                LOG.logError("STYC.inDesignElementHash: no in_element");
                break;
            }

            if ("number" == typeof in_element) {
                retVal = wrapHash("N:" + in_element);
                break;
            }

            if ("string" == typeof in_element) {
                retVal = wrapHash('S:"' + in_element + '"');
                break;
            }

            if ("boolean" == typeof in_element) {
                retVal = wrapHash(in_element ? "T" : "F");
                break;
            }

            if (in_element === null) {
                retVal = wrapHash("n");
                break;
            }

            if (in_element === undefined) {
                retVal = wrapHash("U");
                break;
            }

            if (in_element instanceof Enumerator) {
                retVal = wrapHash("E:" + (in_element + 0).toString(16));
                break;
            }

            if ("id" in in_element) {
                if (! io_context.hashCache) {
                    io_context.hashCache = {};
                }
                if (in_element.id in io_context.hashCache) {
                    retVal = io_context.hashCache[in_element.id];
                    break;
                }
            }

            if ("isValid" in in_element && ! in_element.isValid) {
                break;
            }

            var className = UTILS.getClassName(in_element);
            var attributesForComparison = undefined;
            if (className in ATTRIBUTES_FOR_STYLE_COMPARISONS) {
                attributesForComparison = ATTRIBUTES_FOR_STYLE_COMPARISONS[className];
            }

            if ("id" in in_element && className != "ParagraphStyle" && className != "CharacterStyle" && className != "TextStyleRange") {
                retVal = wrapHash("ID:" + in_element.id);
                break;
            }            

            for (var attr in in_element) {

                do {

                    try {

                        if (attributesForComparison && ! attributesForComparison[attr]) {
                            break;
                        }

                        if (attr == "properties" || attr == "isValid" || attr == "index" || UTILS.startsWith(attr, "parent")) {
                            break;
                        }

                        var attrValue = in_element[attr];

                        var elementAttrHash = STYC.inDesignElementHash(io_context, attrValue);

                        if (elementAttrHash) {
                            if (! retVal) {
                                retVal = "";
                            }
                            retVal += "[" + attr + "]=" + elementAttrHash.string + ";";
                        }
                    }
                    catch (err) {
                        LOG.logNote("STYC.inDesignElementHash: cannot access " + attr);
                    }
                        
                }
                while (false);

            }
            
            if (! retVal) {
                break;
            }
        
            retVal = wrapHash(retVal);
            
            if ("id" in in_element) {
                io_context.hashCache[in_element.id] = retVal;
            }

        }
        catch (err) {
            LOG.logError("STYC.inDesignElementHash: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.inDesignElementHash");

    return retVal;
}

STYC.main = function() {

    LOG.logEntry("STYC.main");

    do {

        try {

            if (! app.documents.length || !(app.activeDocument instanceof Document)) {
                LOG.logWarning("STYC.main: no documents open");
                alert("Please make sure you have a document open.");
                break;
            }

            var context = {};
            context.doc = app.activeDocument;

            var success = STYC.styleCleanup(context);

            if (success) {
                alert("StyleCleanup completed.");
            }
            else {
                alert("StyleCleanup was attempted, but some problems occurred.");
            }

        }
        catch (err) {
            LOG.logError("STYC.main: throws " + err);
        }

    }
    while (false);

    LOG.logExit("STYC.main");

}

STYC.storyParagraphCleanup = function(io_context, in_paragraph) {

    var success = false;
    
    LOG.logEntry("STYC.storyParagraphCleanup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.storyParagraphCleanup: no io_context");
                break;
            }

            if (! (in_paragraph instanceof Paragraph)) {
                LOG.logError("STYC.storyParagraphCleanup: no in_story");
                break;
            }

            if (! in_paragraph.isValid) {
                LOG.logError("STYC.storyParagraphCleanup: invalid in_paragraph");
                break;
            }

            var doc = io_context.doc;
            if (! (doc instanceof Document)) {
                LOG.logError("STYC.storyParagraphCleanup: no doc");
                break;
            }

            success = true;

            if (! in_paragraph.textHasOverrides(StyleType.PARAGRAPH_STYLE_TYPE, false)) {
                break;
            }

            var hasRelevantDifferences = false;
            for (var attr in ATTRIBUTES_FOR_STYLE_COMPARISONS.ParagraphStyle) {
                if (ATTRIBUTES_FOR_STYLE_COMPARISONS.ParagraphStyle[attr]) {
                    if (in_paragraph[attr] != in_paragraph.appliedParagraphStyle[attr]) {
                        hasRelevantDifferences = true;
                        break; // exit for
                    }
                }
            }

            if (! hasRelevantDifferences) {
                // Paragraph has manual overrides, but they are irrelevant for our purposes
                LOG.logNote("STYC.storyParagraphCleanup: clearing in_paragraph overrides");
                STYC.appendLineToReport(io_context, 
                    "Cleared manual paragraph style overrides on paragraph with text:\n" +
                        '"' + UTILS.shortenedString(in_paragraph.contents, 100)) + '"';
                break;
            }
        
            if (! io_context.paragraphCleanupBatch) {
                io_context.paragraphCleanupBatch = [];
            }            

            var newParagraphStyleHash = STYC.inDesignElementHash(io_context, in_paragraph);            
            if (io_context.artificialParagraphStylesByHashString && io_context.artificialParagraphStylesByHashString[newParagraphStyleHash.string]) {
                var reusedArificialParagraphStyle = io_context.artificialParagraphStylesByHashString[newParagraphStyleHash.string];
                io_context.paragraphCleanupBatch.push({
                    paragraph: in_paragraph,
                    paraStyle: reusedArificialParagraphStyle
                });
                break;
            }

            if (! io_context.paragraphStyleCounter) {
                io_context.paragraphStyleCounter = 0;
            }
            io_context.paragraphStyleCounter++;

            var paraStyle;
            var name = ARTIFICIAL_PARA_STYLE_NAME_PREFIX + io_context.paragraphStyleCounter;
            do {
                paraStyle = doc.paragraphStyles.itemByName(name);
                if (paraStyle && ! paraStyle.isValid) {
                    paraStyle = null;
                }
                if (paraStyle) {
                    io_context.paragraphStyleCounter++;
                    name = ARTIFICIAL_PARA_STYLE_NAME_PREFIX + io_context.paragraphStyleCounter;
                }
            }
            while (paraStyle);

            var properties = {};
            properties.name = name;
            properties.basedOn = in_paragraph.appliedParagraphStyle;
            for (var attr in ATTRIBUTES_FOR_STYLE_COMPARISONS.ParagraphStyle) {
                if (ATTRIBUTES_FOR_STYLE_COMPARISONS.ParagraphStyle[attr]) {
                    if (in_paragraph[attr] != in_paragraph.appliedParagraphStyle[attr]) {
                        properties[attr] = in_paragraph[attr];
                    }
                }
            }

            var newArtificialParagraphStyle = doc.paragraphStyles.add(properties);

            STYC.addToParagraphStyleLookup(io_context, newArtificialParagraphStyle, true);

            io_context.paragraphCleanupBatch.push({
                paragraph: in_paragraph,
                paraStyle: newArtificialParagraphStyle
            });

        }
        catch (err) {
            LOG.logError("STYC.storyParagraphCleanup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.storyParagraphCleanup");
    
    return success;
}

STYC.storyParagraphsCleanup = function(io_context, in_story) {

    var success = false;
    
    LOG.logEntry("STYC.storyParagraphsCleanup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.storyParagraphsCleanup: no io_context");
                break;
            }

            if (! (in_story instanceof Story)) {
                LOG.logError("STYC.storyParagraphsCleanup: no in_story");
                break;
            }

            success = true;

            var paragraphs = in_story.paragraphs;
            for (var paragraphIdx = 0; paragraphIdx < paragraphs.length; paragraphIdx++) {
                var paragraph = paragraphs.item(paragraphIdx);
                success = STYC.storyParagraphCleanup(io_context, paragraph) && success;         
            }
    
        }
        catch (err) {
            LOG.logError("STYC.storyParagraphsCleanup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.storyParagraphsCleanup");
    
    return success;
}

STYC.storyStyleCleanup = function(io_context, in_story) {

    var success = false;
    
    LOG.logEntry("STYC.storyStyleCleanup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.storyStyleCleanup: no io_context");
                break;
            }

            if (! (in_story instanceof Story)) {
                LOG.logError("STYC.storyStyleCleanup: no in_story");
                break;
            }

            success = true;

            io_context.paragraphCleanupBatch = undefined;            
            io_context.textStyleRangeCleanupBatch = undefined;            

            success = STYC.storyParagraphsCleanup(io_context, in_story) && success;
            success = STYC.storyTextStyleRangesCleanup(io_context, in_story) && success;

            in_story.clearOverrides(OverrideType.ALL);

            if (io_context.paragraphCleanupBatch) {
                for (var idx = 0; idx < io_context.paragraphCleanupBatch.length; idx++) {
                    var entry = io_context.paragraphCleanupBatch[idx];
                    var paragraph = entry.paragraph;
                    var paraStyle = entry.paraStyle;
                    paragraph.applyParagraphStyle(paraStyle, false);                    
                }                
                io_context.paragraphCleanupBatch = undefined;            
            }

            if (io_context.textStyleRangeCleanupBatch) {
                for (var idx = 0; idx < io_context.textStyleRangeCleanupBatch.length; idx++) {
                    var entry = io_context.textStyleRangeCleanupBatch[idx];
                    var startIdx = entry.startIdx;
                    var endIdx = entry.endIdx;
                    var textStyleRange = in_story.characters.itemByRange(startIdx, endIdx);
                    var charStyle = entry.charStyle;
                    textStyleRange.applyCharacterStyle(charStyle, false);
                }
                io_context.textStyleRangeCleanupBatch = undefined;            
            }
    
        }
        catch (err) {
            LOG.logError("STYC.storyStyleCleanup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.storyStyleCleanup");
    
    return success;
}

STYC.storyTextStyleRangeCleanup = function(io_context, in_textStyleRange) {

    var success = false;
    
    LOG.logEntry("STYC.storyTextStyleRangeCleanup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.storyTextStyleRangeCleanup: no io_context");
                break;
            }

            if (! (in_textStyleRange instanceof TextStyleRange)) {
                LOG.logError("STYC.storyTextStyleRangeCleanup: no in_textStyleRange");
                break;
            }

            if (! in_textStyleRange.isValid) {
                LOG.logError("STYC.storyTextStyleRangeCleanup: invalid in_textStyleRange");
                break;
            }

            var doc = io_context.doc;
            if (! (doc instanceof Document)) {
                LOG.logError("STYC.storyTextStyleRangeCleanup: no doc");
                break;
            }

            success = true;

            if (! in_textStyleRange.textHasOverrides(StyleType.CHARACTER_STYLE_TYPE, false)) {
                break;
            }

            var hasRelevantDifferences = false;
            for (var attr in ATTRIBUTES_FOR_STYLE_COMPARISONS.CharacterStyle) {
                if (ATTRIBUTES_FOR_STYLE_COMPARISONS.CharacterStyle[attr]) {
                    var paraStyleAttrVal = in_textStyleRange.appliedParagraphStyle[attr];
                    var charStyleAttrVal = in_textStyleRange.appliedCharacterStyle[attr];
                    var effectiveStyleAttrVal = paraStyleAttrVal;
                    if (charStyleAttrVal && charStyleAttrVal != NothingEnum.NOTHING && charStyleAttrVal != "") {
                        effectiveStyleAttrVal = charStyleAttrVal;
                    }
                    if (in_textStyleRange[attr] != effectiveStyleAttrVal) {
                        hasRelevantDifferences = true;
                        break; // exit for
                    }
                }
            }

            if (! hasRelevantDifferences) {
                // Range has manual overrides, but they are irrelevant for our purposes
                LOG.logNote("STYC.storyTextStyleRangeCleanup: clearing character overrides");
                STYC.appendLineToReport(io_context, 
                    "Cleared manual character style overrides on text range:\n" +
                        UTILS.shortenedString(in_textStyleRange.contents, 100));
                break;
            }

            if (! io_context.textStyleRangeCleanupBatch) {
                io_context.textStyleRangeCleanupBatch = [];
            }

            var definingTextStyleRangeHash = STYC.inDesignElementHash(io_context, in_textStyleRange);

            if (
                io_context.artificialCharacterStylesByDefiningTextStyleRangeHashString 
            && 
                io_context.artificialCharacterStylesByDefiningTextStyleRangeHashString[definingTextStyleRangeHash.string]
            ) {
                var reusedArtificialCharacterStyle = io_context.artificialCharacterStylesByDefiningTextStyleRangeHashString[definingTextStyleRangeHash.string];
                var startIdx = in_textStyleRange.characters.firstItem().index;
                var endIdx = startIdx + in_textStyleRange.characters.length - 1;
                io_context.textStyleRangeCleanupBatch.push({
                    startIdx: startIdx,
                    endIdx: endIdx,
                    charStyle: reusedArtificialCharacterStyle
                });
                break;
            }

            if (! io_context.characterStyleCounter) {
                io_context.characterStyleCounter = 0;
            }
            io_context.characterStyleCounter++;

            var charStyle;
            var name = ARTIFICIAL_CHAR_STYLE_NAME_PREFIX + io_context.characterStyleCounter;
            do {
                charStyle = doc.characterStyles.itemByName(name);
                if (charStyle && ! charStyle.isValid) {
                    charStyle = null;
                }
                if (charStyle) {
                    io_context.characterStyleCounter++;
                    name = ARTIFICIAL_CHAR_STYLE_NAME_PREFIX + io_context.characterStyleCounter;
                }
            }
            while (charStyle);

            var properties = {};
            properties.name = name;
            properties.basedOn = in_textStyleRange.appliedCharacterStyle;
            for (var attr in ATTRIBUTES_FOR_STYLE_COMPARISONS.TextStyleRange) {
                if (ATTRIBUTES_FOR_STYLE_COMPARISONS.TextStyleRange[attr]) {
                    properties[attr] = in_textStyleRange[attr];
                }
            }

            var newArtificialCharacterStyle = io_context.doc.characterStyles.add(properties);

            STYC.addToCharacterStyleLookup(io_context, newArtificialCharacterStyle, definingTextStyleRangeHash);

            var startIdx = in_textStyleRange.characters.firstItem().index;
            var endIdx = startIdx + in_textStyleRange.characters.length - 1;
            io_context.textStyleRangeCleanupBatch.push({
                startIdx: startIdx,
                endIdx: endIdx,
                charStyle: newArtificialCharacterStyle
            });

        }
        catch (err) {
            LOG.logError("STYC.storyTextStyleRangeCleanup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.storyTextStyleRangeCleanup");
    
    return success;
}

STYC.storyTextStyleRangesCleanup = function(io_context, in_story) {

    var success = false;
    
    LOG.logEntry("STYC.storyTextStyleRangesCleanup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.storyTextStyleRangesCleanup: no io_context");
                break;
            }

            if (! (in_story instanceof Story)) {
                LOG.logError("STYC.storyTextStyleRangesCleanup: no in_story");
                break;
            }

            success = true;

            var textStyleRanges = in_story.textStyleRanges;
            for (var textStyleRangeIdx = 0; textStyleRangeIdx < textStyleRanges.length; textStyleRangeIdx++) {
                var textStyleRange = textStyleRanges.item(textStyleRangeIdx); 
                success = STYC.storyTextStyleRangeCleanup(io_context, textStyleRange) && success;
            }
    
        }
        catch (err) {
            LOG.logError("STYC.storyTextStyleRangesCleanup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.storyTextStyleRangesCleanup");
    
    return success;
}

STYC.styleCleanup = function(io_context) {

    var success = false;
    
    LOG.logEntry("STYC.styleCleanup");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.styleCleanup: no io_context");
                break;
            }

            var doc = io_context.doc;
            if (! (doc instanceof Document)) {
                LOG.logError("STYC.styleCleanup: no doc");
                break;
            }

            if (WRITE_STYLE_REPORT) {
                if (! doc.saved) {
                    LOG.logError("STYC.styleCleanup: doc has never been saved. Cannot generate report file");
                }
                else {
                    try {
                        var docFolderPath = UTILS.dirName(doc.fullName.fsName);
                        var docName = UTILS.stripFileNameExtension(doc.name);
                        io_context.reportFilePath = docFolderPath + docName + ".md";
                        io_context.report = "";
                    }
                    catch (err) {
                        LOG.logError("STYC.styleCleanup: report file path throws " + err);
                        io_context.reportFilePath = undefined;
                    }
                }
            }

            if  (! STYC.buildParagraphStyleLookup(io_context)) {
                LOG.logError("STYC.styleCleanup: failed to build character style lookup table");
                break;
            }
            STYC.generateParagraphStyleReport(io_context);

            if  (! STYC.buildCharacterStyleLookup(io_context)) {
                LOG.logError("STYC.styleCleanup: failed to build character style lookup table");
                break;
            }
            STYC.generateCharacterStyleReport(io_context);

            success = true;
            
            var stories = doc.stories;
            if (! stories || stories.length == 0) {
                LOG.logWarning("STYC.styleCleanup: doc contains no stories");
                break;
            }
            
            for (var storyIdx = 0; storyIdx < stories.length; storyIdx++) {
                var story = stories.item(storyIdx);
                success = STYC.storyStyleCleanup(io_context, story) && success;
            }

            if (io_context.reportFilePath) {
                try {
                    var reportFile = new File(io_context.reportFilePath);
                    reportFile.open("w");
                    reportFile.writeln(io_context.report);
                    reportFile.close();
                }
                catch (err) {
                    LOG.logError("STYC.styleCleanup: writing report throws " + err);
                }
            }

        }
        catch (err) {
            LOG.logError("STYC.styleCleanup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.styleCleanup");
    
    return success;
}

// ----

})()};

// Pass configuration data to LOG module

LOG.LOG_TO_CONSOLE   = LOG_TO_CONSOLE;
LOG.LOG_LEVEL        = LOG_LEVEL;
LOG.LOG_ENTRY_EXIT   = LOG_ENTRY_EXIT;
LOG.FILE_PATH_LOG    = FILE_PATH_LOG;

ATTRIBUTES_FOR_STYLE_COMPARISONS.Paragraph = ATTRIBUTES_FOR_STYLE_COMPARISONS.ParagraphStyle;
ATTRIBUTES_FOR_STYLE_COMPARISONS.TextStyleRange = ATTRIBUTES_FOR_STYLE_COMPARISONS.CharacterStyle;
ATTRIBUTES_FOR_STYLE_COMPARISONS.Font = {
	fullName: 1
};
ATTRIBUTES_FOR_STYLE_COMPARISONS.Application = {};
ATTRIBUTES_FOR_STYLE_COMPARISONS.Events = {};
ATTRIBUTES_FOR_STYLE_COMPARISONS.EventListeners = {};


// ----

if (DEBUG) {
  STYC.main();
}
else {
  // Running the non-debug version is wrapped into a single Undo for the user.
  app.doScript("STYC.main()", ScriptLanguage.JAVASCRIPT, [], UndoModes.ENTIRE_SCRIPT);
}

/*************************************************************

StyleCleanup.jsx

(c) 2019 NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
https://nnels.ca/

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of NNELS, nor the names of its contributors
  may be used to endorse or promote products derived from this software without
  specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.

==============================================
*/


