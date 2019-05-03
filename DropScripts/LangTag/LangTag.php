#!/usr/bin/php
<?php

// LangTag.php

function processDOM($config, &$isModified, &$dom) {

    logEntry("processDOM");

    do { // non-loop

        try {

            $html = $dom->getElementsByTagName("html");
            if (! isset($html) || count($html) == 0) {
                logWarning("processDOM: cannot find html tag");
                break;
            }
            $html = $html[0];
            if (! isset($html)) {
                logWarning("processDOM: cannot find html tag");
                break;
            }

            $body = $dom->getElementsByTagName("body");
            if (! isset($body) || count($body) == 0) {
                logWarning("processDOM: cannot find body tag");
                break;
            }
            $body = $body[0];
            if (! isset($body)) {
                logWarning("processDOM: cannot find body tag");
                break;
            }

            $xmlLang = "";
            if ($body->hasAttribute('xml___lang')) {
                $xmlLang = $body->getAttribute('xml___lang');
                $body->removeAttribute('xml___lang');
                $isModified = true;
            }

            $lang = "";
            if ($body->hasAttribute('lang')) {
                $lang = $body->getAttribute('lang');
                $body->removeAttribute('lang');
                $isModified = true;
            }

            if (empty($lang) && empty($xmlLang)) {
                break;
            }

            if (! empty($lang)) {
                $html->setAttribute('lang', $lang);
            }

            if (! empty($xmlLang)) {
                $html->setAttribute('xml___lang', $xmlLang);
            }

        }
        catch (Exception $e) {
            logError("processDOM: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit("processDOM");

}

function preProcessFile($config, &$isModified, &$fileContents) {

    // I've got trouble processing xml:lang 
    //
    // xml: is supposed to be predefined as xmlns:xml="http://www.w3.org/XML/1998/namespace"
    // and it seems to work for writing to the DOM, but I cannot read xml:lang, for some reason.
    //
    // So we're sidestepping the issue and temporarily replace xml:lang with xml___lang

    $fileContents = preg_replace("/(<(body|html)[^>]*)xml:lang(=\"[^\"]*\"[^>]*>)/", "$1xml___lang$3", $fileContents);

}

function postProcessFile($config, &$isModified, &$fileContents) {

    $fileContents = preg_replace("/(<(body|html)[^>]*)xml___lang(=\"[^\"]*\"[^>]*>)/", "$1xml:lang$3", $fileContents);

}

// -- AUTO-GENERATED CODE BELOW. DO NOT EDIT BELOW

// Any code below this line will be auto-updated from the DropScriptTemplate.php. If this file is not
// called 'DropScriptTemplate.php' you should avoid editing it and instead edit DropScriptTemplate.php

function main($droppedFile) {

    do { // non-loop

        try {

            $config = init($droppedFile);

            if (! file_exists($droppedFile)) {
                logWarning("main: file does not exist " . $droppedFile);
                break;
            }

            if (! isAcceptedFile($config, $droppedFile)) {
                logWarning("main: file not accepted for processing " . $droppedFile);
                break;
            }

            $isModified = false;

            $fileContents = file_get_contents($droppedFile);

            preProcessFile($config, $isModified, $fileContents);

            $dom = new DomDocument();

            if ($config["ignoreDOMParserErrors"]) {
                libxml_use_internal_errors(true);
            }

            $dom->loadHTML($fileContents);

            if ($config["ignoreDOMParserErrors"]) {
                libxml_clear_errors();
            }
            
            processDOM($config, $isModified, $dom);

            $output = $dom->saveHTML();

            postProcessFile($config, $isModified, $output);            

            if (! $isModified) {
                break;
            }

            makeBackup($config, $droppedFile);

            writeFileContents($droppedFile, $output);
        }
        catch (Exception $e) {
            logError("main: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

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

            $parentDir = dirname($filePath);

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

            rename($filePath, $backupFile);

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
            logNote("mergeConfig: mergeConfigJSON = \n" . $mergeConfigJSON);

            $mergeConfig = json_decode($mergeConfigJSON);
            foreach ($mergeConfig as $key => $value) {
                logNote("mergeConfig: merging [" . $key . "] = \"" . $value . "\"");
                $config[$key] = $value;
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
