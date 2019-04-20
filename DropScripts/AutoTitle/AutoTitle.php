#!/usr/bin/php
<?php

// AutoTitle.php

function processDOM($config, &$isModified, &$dom) {

    $isModified = false;

    $h1s = $dom->getElementsByTagName("h1");
    if (count($h1s) > 0) {
        foreach($h1s->item(0)->childNodes as $node) {
            if ($node->nodeType != XML_TEXT_NODE) {
                continue;
            }
            $firstH1 = $node->textContent;
        }
    }

    if ($firstH1) {
        $titles = $dom->getElementsByTagName("title");
        if (count($titles) > 0) {
            $title = $titles->item(0);
            $title->textContent = $firstH1;
            $isModified = true;
        }
    }
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

            $dom = new DomDocument();
            $dom->loadHTMLFile($droppedFile);

            $isModified = false;
            processDOM($config, $isModified, $dom);

            // ...
            //

            if (! $isModified) {
                break;
            }

            makeBackup($config, $droppedFile);

            $output = $dom->saveHTML();

            writeFileContents($droppedFile, $output);
        }
        catch (Exception $e) {
            logError("main: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

}

define(LOG_NONE,    0);
define(LOG_ERROR,   1);
define(LOG_WARNING, 2);
define(LOG_NOTE,    3);
define(LOG_TRACE,   4);

function defaultConfig() {

    $config = [];

    $config["acceptFileNameExtensions"] = [ "html", "htm", "xhtml" ];
    $config["backupFileNameExtension"]  = "old";
    $config["maxBackupCount"]           = 1;
    $config["logLevel"]                 = LOG_WARNING;
    $config["logToFile"]                = false; // File path or false
    $config["logToConsole"]             = true;  // true or false

    return $config;
}


// --

function init($droppedFile) {

    global $LOGLEVEL;
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

            $localConfigFile = nearbyConfigFile($droppedFile);
            mergeConfig($config, $localConfigFile);

            // Allow over-riding 

            $LOGLEVEL = $config["logLevel"];
            $LOG_TO_FILE = $config["logToFile"];
            $LOG_TO_CONSOLE = $config["logToConsole"];
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

    return $retVal;
}

function logError($message) {
    global $LOGLEVEL;

    if ($LOGLEVEL >= LOG_ERROR) {
        logMessage("ERROR: " . $message);
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

            logNote("makeBackup: backup made to " . $backupFile);

            rename($filePath, $backupFile);
        }
        catch (Exception $e) {
            logError("makeBackup: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

}

function mergeConfig(&$config, $filePath) {

    do { // non-loop
        try {

            $mergeConfigJSON = readFileContents($filePath);
            if (! $mergeConfigJSON) {
                logNote("mergeConfig: no data retrieved from " . $filePath);
                break;
            }

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

}

function nearbyConfigFile($filePath) {

     do { // non-loop

        try {

            $parentDir = dirname($filePath);

            $scriptFileName = basename(__FILE__);

            // Strip extension

            $scriptFileNamePieces = explode(".", $scriptFileName);
            $numPieces = count($scriptFileNamePieces);
            if ($numPieces > 1) {
                array_splice($scriptFileNamePieces, $numPieces - 1, 1);
                $scriptFileName = join(".", $scriptFileNamePieces);
            }

            $configFileName = $parentDir . "/" . $scriptFileName . ".config.txt";

        }
        catch (Exception $e) {
            logError("nearbyConfigFile: throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    return $configFileName;
}

function readFileContents($filePath) {

    $retVal = "";

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

    return $retVal;
}

function writeFileContents($filePath, $content) {

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

}

main($argv[1]);
