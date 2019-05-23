<?php

// GlobalSearchAndReplace.php.inc

function processDOM($config, &$isModified, &$dom) {

}

function preProcessFile($config, &$isModified, &$fileContents) {

}

function postProcessFile($config, &$isModified, &$fileContents) {

}

function postPostProcessFile($config, &$isModified, &$fileContents) {

    do { // non-loop
        try {

            $replacements = $config["replacements"];
            if (! isset($replacements)) {
                logNote("postProcessFile: no replacements found in config");
                break;
            }

            $newFileContents = $fileContents;

            foreach ($replacements as $replacement) {
                $from = $replacement->from;
                $to = $replacement->to;
                try {
                    $newFileContents = preg_replace($from, $to, $newFileContents);
                }
                catch (Exception $e) {
                    echo "Replacement '$from' -> '$to' failed " . $e->getMessage();
                }
            }

            if ($newFileContents != $fileContents) {
                $isModified = true;
                $fileContents = $newFileContents;
            }
        }
        catch (Exception $e) {
            echo "Processing file throws a PHP error: " . $e->getMessage();
        }
    }
    while (false); // non-loop

}
