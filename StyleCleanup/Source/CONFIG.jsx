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