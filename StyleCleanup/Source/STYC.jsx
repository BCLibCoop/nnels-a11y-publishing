var STYC;
if (DEBUG) {
    // Clear persistent code on each run when debugging
    STYC = undefined;
}

if (! STYC) {
STYC = {};
(function() {

// ----

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

STYC.textStyleHash = function(io_context, in_styleElement) {

    var textStyleHash = undefined;

    LOG.logEntry("STYC.textStyleHash");

    do {

        try {

            if (! io_context) {
                LOG.logError("STYC.textStyleHash: no io_context");
                break;
            }

            if (! in_styleElement) {
                LOG.logError("STYC.textStyleHash: no in_styleElement");
                break;
            }



        }
        catch (err) {
            LOG.logError("STYC.textStyleHash: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.textStyleHash");
}

STYC.storyStyleCleanup = function(io_context, in_story) {

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



        }
        catch (err) {
            LOG.logError("STYC.storyStyleCleanup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.storyStyleCleanup");
}

STYC.styleCleanup = function(io_context) {

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

            var stories = doc.stories;
            if (! stories || stories.length == 0) {
                LOG.logNote("STYC.styleCleanup: doc contains no stories");
                break;
            }

            for (var storyIdx = 0; storyIdx < stories.length; storyIdx++) {
                var story = stories.item(storyIdx);
                STYC.storyStyleCleanup(io_context, story);
            }

        }
        catch (err) {
            LOG.logError("STYC.styleCleanup: throws " + err);
        }
    }
    while (false);

    LOG.logExit("STYC.styleCleanup");
}

// ----

})()};
