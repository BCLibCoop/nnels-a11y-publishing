#!/usr/bin/php
<?php

// MakeBreaksConform.php

if (file_exists(__DIR__ . "/GlobalSearchAndReplace.php.inc")) {
    include __DIR__ . "/GlobalSearchAndReplace.php.inc";
}
else if (file_exists(__DIR__ . "/../DropScriptTemplate/GlobalSearchAndReplace.php.inc")) {
    include __DIR__ . "/../DropScriptTemplate/GlobalSearchAndReplace.php.inc";   
}

// -- AUTO-GENERATED CODE BELOW. DO NOT EDIT BELOW

// Any code below this line will be auto-updated from the DropScriptTemplate.php. If this file is not
// called 'DropScriptTemplate.php' you should avoid editing it and instead edit DropScriptTemplate.php

function main($droppedFile) {

    do { // non-loop

        try {

            $freeUnusedStrings = true;

            $config = init($droppedFile);

            if (! file_exists($droppedFile)) {
                logWarning("main: file does not exist " . $droppedFile);
                break;
            }

            if (! isAcceptedFile($config, $droppedFile)) {
                echo "File " . basename($droppedFile) . " was not modified.\n";
                logWarning("main: file not accepted for processing " . $droppedFile);
                break;
            }

            $isModified = false;

            $fileContents = file_get_contents($droppedFile);

            $lineEndCleanFileContents = str_replace("\015\012", "\012", $fileContents);
            $lineEndCleanFileContents = str_replace("\015", "\012", $lineEndCleanFileContents);

            $preProcessModified = false;
            preProcessFile($config, $preProcessModified, $lineEndCleanFileContents);
            $isModified |=  $preProcessModified;

            $header = "";
            $headLessContents = $lineEndCleanFileContents;

            if ($freeUnusedStrings) {
                $lineEndCleanFileContents = NULL;
            }

            $matches = [];

            $DOMheader = "";
            $DOMregExp = "~\\s*(<![^>]*>)\\s*~s";
            if (preg_match($DOMregExp, $headLessContents, $matches)) {
                $DOMheader = $matches[1];
                $headLessContents = preg_replace($DOMregExp, "", $headLessContents);
            }
            if (! $DOMheader && $config["addDOMHeader"]) {
                $DOMheader = $config["defaultDOMHeader"];   
            }

            $XMLheader = "";
            $XMLregExp = "~\\s*(<\\?[^>]*\\?>)\\s*~s";
            if (preg_match($XMLregExp, $headLessContents, $matches)) {
                $XMLheader = $matches[1];
                $headLessContents = preg_replace($XMLregExp, "", $headLessContents);
            }
            if (! $XMLheader && $config["addXMLHeader"]) {
                $XMLheader = $config["defaultXMLHeader"];   
            }

            $defaultHTMLheader = $config["defaultHTMLheader"];
            $defaultHTMLtrailer = "</html>";

            $hasHTMLHeader = false;
            $HTMLheader = $defaultHTMLheader;
            $HTMLheaderRegExp = "~\\s*(<html[^>]*>)\\s*~s";
            $HTMLtrailerRegExp = "~\\s*</html>\\s*~s";
            if (preg_match($HTMLheaderRegExp, $headLessContents, $matches)) {
                $HTMLheader = $matches[1];
                $headLessContents = preg_replace($HTMLheaderRegExp, "", $headLessContents);
                $headLessContents = preg_replace($HTMLtrailerRegExp, "", $headLessContents);
                $hasHTMLHeader = true;
            }

            $rewrappedContents = 
                "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" .
                $HTMLheader . $headLessContents . $defaultHTMLtrailer;

            if ($freeUnusedStrings) {
                $headLessContents = NULL;
            }


            $dom = new DomDocument();

            if ($config["ignoreDOMParserErrors"]) {
                libxml_use_internal_errors(true);
            }
            
            $dom->loadXML($rewrappedContents);

            if ($config["ignoreDOMParserErrors"]) {
                libxml_clear_errors();
            }
            
            $isDomModified = false;
            processDOM($config, $isDomModified, $dom);

            $isModified = $isModified || $isDomModified;

            if (! $isDomModified) {
                $processedContents = $rewrappedContents;
            }
            else {
                $processedContents = $dom->saveXML($dom);
            }

            if ($freeUnusedStrings) {
                $rewrappedContents = NULL;
            }

            $postProcessedContents = $processedContents;

            if ($freeUnusedStrings) {
                $processedContents = NULL;
            }

            $postProcessModified = false;
            postProcessFile($config, $postProcessModified, $postProcessedContents);
            $isModified |=  $postProcessModified;

            $headLessProcessedContents = $postProcessedContents;

            if ($freeUnusedStrings) {
                $postProcessedContents = NULL;
            }

            $headLessProcessedContents = preg_replace($DOMregExp, "", $headLessProcessedContents);
            $headLessProcessedContents = preg_replace($XMLregExp, "", $headLessProcessedContents);
            
            if (preg_match($HTMLheaderRegExp, $headLessProcessedContents, $matches)) {
                $postProcessedHTMLheader = $matches[0];
                $headLessProcessedContents = preg_replace($HTMLheaderRegExp, "", $headLessProcessedContents);
                $headLessProcessedContents = preg_replace($HTMLtrailerRegExp, "", $headLessProcessedContents);
            }

            $rewrappedPostProcessedContents = $headLessProcessedContents;

            if ($freeUnusedStrings) {
                $headLessProcessedContents = NULL;
            }

            if ($config["lockHTMLHeader"]) {
                if ($hasHTMLHeader) {
                    $rewrappedPostProcessedContents = $HTMLheader . "\n" . $rewrappedPostProcessedContents . "\n" . $defaultHTMLtrailer . "\n";
                }
                else if ($config["addHTMLHeader"]) {
                    $rewrappedPostProcessedContents = $defaultHTMLheader . "\n" . $rewrappedPostProcessedContents . "\n" . $defaultHTMLtrailer . "\n";
                }
            }
            else {
                if ($postProcessedHTMLheader) {
                    $rewrappedPostProcessedContents = $postProcessedHTMLheader . "\n" . $rewrappedPostProcessedContents . "\n" . $defaultHTMLtrailer . "\n";
                }
                else {
                    $rewrappedPostProcessedContents = $defaultHTMLheader . "\n" . $rewrappedPostProcessedContents . "\n" . $defaultHTMLtrailer . "\n";
                }
            }

            if ($config["lockDOMHeader"]) {
                if ($DOMheader) {
                    $rewrappedPostProcessedContents = $DOMheader . "\n" . $rewrappedPostProcessedContents;
                }
                else if ($config["addDOMHeader"]) {
                    $rewrappedPostProcessedContents = $defaultDOMHeader . "\n" . $rewrappedPostProcessedContents;
                }
            }
            else {
                $rewrappedPostProcessedContents = $defaultDOMHeader . "\n" . $rewrappedPostProcessedContents;
            }
                
            if ($config["lockXMLHeader"]) {
                if ($XMLheader) {
                    $rewrappedPostProcessedContents = $XMLheader . "\n" . $rewrappedPostProcessedContents;
                }
                else if ($config["addXMLHeader"]) {
                    $rewrappedPostProcessedContents = $defaultXMLHeader . "\n" . $rewrappedPostProcessedContents;
                }
            }
            else {
                $rewrappedPostProcessedContents = $defaultXMLHeader . "\n" . $rewrappedPostProcessedContents;
            }

            postPostProcessFile($config, $isModified, $rewrappedPostProcessedContents);

            if (! $isModified) {
                echo "File " . basename($droppedFile) . " was not modified.\n";
                break;
            }

            makeBackup($config, $droppedFile);

            writeFileContents($droppedFile, $rewrappedPostProcessedContents);

            echo "Updated file " . basename($droppedFile) . ".\n";
            
        }
        catch (Exception $e) {
            logError("main: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

}

define("JSON_PARSE_STATE_IDLE",                      0);
define("JSON_PARSE_STATE_SEEN_SLASH",                1);
define("JSON_PARSE_STATE_SEEN_DOUBLE_SLASH",         2);
define("JSON_PARSE_STATE_SEEN_SLASH_STAR",           3);
define("JSON_PARSE_STATE_SEEN_SLASH_STAR_STAR",      4);
define("JSON_PARSE_STATE_SEEN_SINGLE_QUOTE",         5);
define("JSON_PARSE_STATE_SEEN_SINGLE_QUOTE_ESCAPE",  6);
define("JSON_PARSE_STATE_SEEN_DOUBLE_QUOTE",         7);
define("JSON_PARSE_STATE_SEEN_DOUBLE_QUOTE_ESCAPE",  8);

function commented_json_decode($in_json) {

    logEntry("commented_json_decode");

    do { // non-loop

        try {

            if (! $in_json) {
                logNote("commented_json_decode: no in_json");
                break;
            }

            $state = JSON_PARSE_STATE_IDLE;
            $charPos = 0;
            $len = strlen($in_json);
            $decoded_json = "";
            while ($charPos < $len) {

                $c = $in_json[$charPos];
                $charPos++;
                switch ($state) {

                    case JSON_PARSE_STATE_IDLE: {
                        if ($c == "/") {
                            $state = JSON_PARSE_STATE_SEEN_SLASH;
                        }
                        else if ($c == "\"") {
                            $decoded_json .= $c;
                            $state = JSON_PARSE_STATE_SEEN_DOUBLE_QUOTE;
                        }
                        else if ($c == "'") {
                            $decoded_json .= $c;
                            $state = JSON_PARSE_STATE_SEEN_SINGLE_QUOTE;
                        }
                        else {
                            $decoded_json .= $c;
                        }
                    }
                    break;

                    case JSON_PARSE_STATE_SEEN_SLASH: {
                        if ($c == "/") {
                            $state = JSON_PARSE_STATE_SEEN_DOUBLE_SLASH;
                        }
                        else if ($c == "*") {
                            $state = JSON_PARSE_STATE_SEEN_SLASH_STAR;
                        }
                        else {
                            $decoded_json .= "/" . $c;
                            $state = JSON_PARSE_STATE_IDLE;                            
                        }
                    }
                    break;

                    case JSON_PARSE_STATE_SEEN_DOUBLE_SLASH: {
                        if ($c == "\n" || c == "\r") {
                            $decoded_json .= $c;
                            $state = JSON_PARSE_STATE_IDLE;
                        }
                    }
                    break;

                    case JSON_PARSE_STATE_SEEN_SLASH_STAR: {
                        if ($c == "*") {
                            $state = JSON_PARSE_STATE_SEEN_SLASH_STAR_STAR;
                        }
                    }
                    break;

                    case JSON_PARSE_STATE_SEEN_SLASH_STAR_STAR: {
                        if ($c == "/") {
                            $state = JSON_PARSE_STATE_IDLE;
                        }
                        else if ($c == "*") {
                            $state = JSON_PARSE_STATE_SEEN_SLASH_STAR_STAR;
                        }
                        else {
                            $state = JSON_PARSE_STATE_SEEN_SLASH_STAR;
                        }
                    }
                    break;

                    case JSON_PARSE_STATE_SEEN_SINGLE_QUOTE: {
                        $decoded_json .= $c;
                        if ($c == "'") {
                            $state = JSON_PARSE_STATE_IDLE;
                        }
                        else if ($c == "\\") {
                            $state = JSON_PARSE_STATE_SEEN_SINGLE_QUOTE_ESCAPE;
                        }
                    }
                    break;

                    case JSON_PARSE_STATE_SEEN_SINGLE_QUOTE_ESCAPE: {
                        $decoded_json .= $c;
                        $state = JSON_PARSE_STATE_SEEN_SINGLE_QUOTE;
                    }
                    break;

                    case JSON_PARSE_STATE_SEEN_DOUBLE_QUOTE: {
                        $decoded_json .= $c;
                        if ($c == "\"") {
                            $state = JSON_PARSE_STATE_IDLE;
                        }
                        else if ($c == "\\") {
                            $state = JSON_PARSE_STATE_SEEN_DOUBLE_QUOTE_ESCAPE;
                        }
                    }
                    break;

                    case JSON_PARSE_STATE_SEEN_DOUBLE_QUOTE_ESCAPE: {
                        $decoded_json .= $c;
                        $state = JSON_PARSE_STATE_SEEN_DOUBLE_QUOTE;
                    }
                    break;
                }
            }

            logNote("commented_json_decode: decoded = \n" . $decoded_json);

            $retVal = $decoded_json;

        }
        catch (Exception $e) {
            logError("commented_json_decode: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("commented_json_decode");

    return $retVal;
}

define("LOG_NONE",    0);
define("LOG_ERROR",   1);
define("LOG_WARNING", 2);
define("LOG_NOTE",    3);
define("LOG_TRACE",   4);

function defaultConfig() {

    $config = [];

    $config["acceptFileNameExtensions"] = [ "html", "htm", "xhtml" ];
    $config["backupFileNameExtension"]  = "old";
    $config["lockDOMHeader"]            = true;
    $config["lockXMLHeader"]            = true;
    $config["lockHTMLHeader"]           = true;
    $config["addDOMHeader"]             = false;
    $config["addXMLHeader"]             = false;
    $config["addHTMLHeader"]            = false;
    $config["defaultDOMHeader"]         = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">";
    $config["defaultXMLHeader"]         = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
    $config["defaultHTMLheader"]        = "<html xmlns:epub=\"http://www.idpf.org/2007/ops\" xmlns=\"http://www.w3.org/1999/xhtml\">";
    $config["maxBackupCount"]           = 5;
    $config["logLevel"]                 = LOG_NONE;
    $config["logEntryExit"]             = false;
    $config["logToFile"]                = false; // File path or false
    $config["logToConsole"]             = true;  // true or false
    $config["ignoreDOMParserErrors"]    = true;

    return $config;
}


// --

function init($droppedFile) {

    global $LOGLEVEL;
    global $LOG_ENTRY_EXIT;
    global $LOG_TO_FILE;
    global $LOG_TO_CONSOLE;
    $config = [];

    do { // non-loop
        try {

            $config = defaultConfig();

            $globalConfigFile = nearbyConfigFile(__FILE__);
            mergeConfig($config, $globalConfigFile);

            $LOGLEVEL = $config["logLevel"];
            $LOG_TO_FILE = $config["logToFile"];
            $LOG_TO_CONSOLE = $config["logToConsole"];
            $LOG_ENTRY_EXIT = $config["logEntryExit"];

            $localConfigFile = nearbyConfigFile($droppedFile);
            logNote("attempt to load optional local config " . $localConfigFile);
            mergeConfig($config, $localConfigFile);

            // Allow over-riding 

            $LOGLEVEL = $config["logLevel"];
            $LOG_TO_FILE = $config["logToFile"];
            $LOG_TO_CONSOLE = $config["logToConsole"];
            $LOG_ENTRY_EXIT = $config["logEntryExit"];

            $config["droppedFilePath"] = $droppedFile;            
            $config["droppedFileName"] = basename($droppedFile);
        }
        catch (Exception $e) {
            // Logging might not work yet. Use echo
            echo "init: throws " . $e->getMessage();
        }
    }
    while (false); // non-loop

    return $config;
}

function isAcceptedFile($config, $filePath) {

    $retVal = false;

    logEntry("isAcceptedFile");

    do { // non-loop
        try {
            
            $fileNamePieces = explode(".", basename($filePath));
            $numPieces = count($fileNamePieces);

            $extension = "";
            if ($numPieces <= 1) {
                logWarning("isAcceptedFile: no file name extension for " . $filePath);
                break;
            }

            $extension = strtolower($fileNamePieces[$numPieces - 1]);

            foreach ($config["acceptFileNameExtensions"] as $fileNameExtension) {
                $compareExtension = strtolower($fileNameExtension);
                if ($extension == $compareExtension) {
                    $retVal = true;
                    break;
                }
            }
        }
        catch (Exception $e) {
            logError("isAcceptedFile: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("isAcceptedFile");

    return $retVal;
}

function logEntry($function) {
    global $LOG_ENTRY_EXIT;

    if ($LOG_ENTRY_EXIT) {
        logNote("ENTRY: " . $function);
    }
}

function logError($message) {
    global $LOGLEVEL;

    if ($LOGLEVEL >= LOG_ERROR) {
        logMessage("ERROR: " . $message);
    }
}

function logExit($function) {
    global $LOG_ENTRY_EXIT;

    if ($LOG_ENTRY_EXIT) {
        logNote("EXIT : " . $function);
    }
}

function logMessage($message) {
    global $LOG_TO_FILE;
    global $LOG_TO_CONSOLE;

    if ($LOG_TO_FILE) {

        $logFile = fopen($LOG_TO_FILE, "a");
        if ($logFile) {
            fwrite($outFile, $message . "\n");
            fclose($outFile);        
        }
    }

    if ($LOG_TO_CONSOLE) {
        echo $message . "\n";
    }
}

function logNote($message) {
    global $LOGLEVEL;

    if ($LOGLEVEL >= LOG_NOTE) {
        logMessage("NOTE : " . $message);
    }
}

function logTrace($message) {
    global $LOGLEVEL;

    if ($LOGLEVEL >= LOG_TRACE) {
        logMessage("TRACE: " . $message);
    }
}

function logWarning($message) {
    global $LOGLEVEL;

    if ($LOGLEVEL >= LOG_WARNING) {
        logMessage("WARN : " . $message);
    }
}

function makeBackup($config, $filePath) {

    logEntry("makeBackup");

    //
    // If maxBackupCount = 1
    //    if the backup file does not exist: 
    //       move the original file to the backup file
    //    if the backup file does exist: 
    //       delete the original file so we can overwrite it. 
    //       The existing backup is probably from a previous
    //       run of the script and should not be overwritten.
    //
    // If maxBackupCount > 1
    //    if the backup file does not exist: 
    //       move the original file to the backup file.
    //    if the backup file does exist: 
    //       Make a backup to backup_1.old, backup_2.old,... 
    //       Delete the oldest of these if there are too many
    //

    do { // non-loop

        try {

            $backupFile = $filePath . "." . $config["backupFileNameExtension"];

            if (file_exists($backupFile)) {

                $maxBackupCount = $config["maxBackupCount"];

                if ($maxBackupCount <= 1) {
                    // Only one backup file allowed and it already exists.
                    // Retain the backup as-is. We'll overwrite $filePath
                    $backupFile = "";
                    logNote("makeBackup: retaining previous backup. No backup made");
                }
                else {
                    $backupCount = $maxBackupCount;
                    $previousBackupFile = "";
                    while ($backupCount >= 2) {
                        $backupFile =  $filePath . "_" . $backupCount . "." . $config["backupFileNameExtension"];
                        $backupCount--;
                        if (file_exists($backupFile)) {
                            if (! $previousBackupFile) {
                                unlink($backupFile);
                                logNote("makeBackup: removing oldest backup " . $backupFile);
                            }
                            else {
                                rename($backupFile, $previousBackupFile);
                            }
                        }
                        $previousBackupFile = $backupFile;
                    }
                }
            }

            if (! $backupFile) {
                break;
            }

            copy($filePath, $backupFile);

            logNote("makeBackup: backup made to " . $backupFile);
        }
        catch (Exception $e) {
            logError("makeBackup: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("makeBackup");
}

function mergeConfig(&$config, $filePath) {

    logEntry("mergeConfig");

    do { // non-loop

        try {

            $mergeConfigJSON = readFileContents($filePath);
            if (! $mergeConfigJSON) {
                logNote("mergeConfig: no data retrieved from " . $filePath);
                break;
            }

            $mergeConfigJSON = commented_json_decode($mergeConfigJSON);

            $mergeConfig = json_decode($mergeConfigJSON);
            if (isset($mergeConfig)) {
                foreach ($mergeConfig as $key => $value) {
                    logNote("mergeConfig: merging [" . $key . "] = \"" . $value . "\"");
                    $config[$key] = $value;
                }
            }
        }
        catch (Exception $e) {
            logError("mergeConfig: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("mergeConfig");

}

function nearbyConfigFile($filePath) {

    logEntry("nearbyConfigFile");

    do { // non-loop

        try {

            $parentDir = dirname($filePath);
            $scriptFileName = stripFileNameExtension(basename(__FILE__));
            $configFileName = $parentDir . DIRECTORY_SEPARATOR . $scriptFileName . ".config.txt";

        }
        catch (Exception $e) {
            logError("nearbyConfigFile: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("nearbyConfigFile");

    return $configFileName;
}

function readFileContents($filePath) {

    $retVal = "";

    logEntry("readFileContents");
 
    do { // non-loop

        try {

            if (! file_exists($filePath)) {
                logNote("readFileContents: file does not exist " . $filePath);
                break;
            }

            $retVal = file_get_contents($filePath);
        }
        catch (Exception $e) {
            logError("readFileContents: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("readFileContents");

    return $retVal;
}

function stripFileNameExtension($fileOrFilePath) {

    $retVal = $fileOrFilePath;

    logEntry("stripFileNameExtension");

    do { // non-loop

        try {

            $baseName = basename($fileOrFilePath);
            $dirName = dirname($fileOrFilePath);

            $baseNamePieces = explode(".", $baseName);
            $numPieces = count($baseNamePieces);
            if ($numPieces > 1) {
                array_splice($baseNamePieces, $numPieces - 1, 1);
                $baseName = join(".", $baseNamePieces);
            }

            if (! $dirName || $dirName == ".") {
                $retVal = $baseName; 
            }
            else {
                $retVal = $dirName . DIRECTORY_SEPARATOR . $baseName; 
            }

        }
        catch (Exception $e) {
            logError("stripFileNameExtension: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("stripFileNameExtension");

    return $retVal;

}

function writeFileContents($filePath, $content) {

    logEntry("writeFileContents");

    do { // non-loop

        try {

            $outFile = fopen($filePath, "w");
            if (! $outFile) {
                logWarning("writeFileContents: cannot open file for writing " . $filePath);
                break;
            }

            fwrite($outFile, $content);
            fclose($outFile);
        }
        catch (Exception $e) {
            logError("writeFileContents: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("writeFileContents");

}

main($argv[1]);
