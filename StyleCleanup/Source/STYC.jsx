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
