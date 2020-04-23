#!/usr/bin/php
<?php

// LangTag.php

function processDOM($config, &$isModified, &$dom) {

    logEntry("processDOM");

    do { // non-loop

        try {

            $rawAttrsToMove = $config["attrsToMove"];
            if ($config["format"] == "INI") {
                if (! is_array($rawAttrsToMove)) {
                    $rawIniAttrsToMove = $rawAttrsToMove;
                    $rawIniAttrsToMove = preg_split("/,/", $rawIniAttrsToMove);
                    $rawAttrsToMove = [];
                    foreach ($rawIniAttrsToMove as $rawAttr) {
                        $rawAttr = preg_replace("/\s*\"?(.*?)\"?\s*/", "$1", $rawAttr);
                        $rawAttrsToMove[] = $rawAttr;
                    }
                }
            }

            // Replace xml: with xml___
            $attrsToMove = [];
            foreach ($rawAttrsToMove as $rawAttr) {
                $attr = str_replace("xml:", "xml___", $rawAttr);
                $attrsToMove[] = $attr;
            }

            if (count($attrsToMove) == 0) {
                logError("processDOM: no attributes to move");
                break;
            }

            $html = $dom->getElementsByTagName("html");
            if (! isset($html) || count($html) == 0) {
                logWarning("processDOM: cannot find html tag");
                break;
            }

            $html = $html->item(0);
            if (! isset($html)) {
                logWarning("processDOM: cannot find html tag");
                break;
            }

            $body = $dom->getElementsByTagName("body");
            if (! isset($body) || count($body) == 0) {
                logWarning("processDOM: cannot find body tag");
                break;
            }

            $body = $body->item(0);
            if (! isset($body)) {
                logWarning("processDOM: cannot find body tag");
                break;
            }

            foreach ($attrsToMove as $attr) {

                $attrVal = $config["defaultIfMissing"];

                if ($body->hasAttribute($attr)) {
                    $attrVal = $body->getAttribute($attr);
                    $body->removeAttribute($attr);
                    $isModified = true;
                }

                if (! empty($attrVal)) {
                    $html->setAttribute($attr, $attrVal);
                    $isModified = true;
                }

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

    $fileContents = preg_replace("~(<(body|html)[^>]*\\bxml):([a-zA-Z]+=\"[^\"]*\"[^>]*/?>)~i", "$1___$3", $fileContents);

}

function postProcessFile($config, &$isModified, &$fileContents) {

    $fileContents = preg_replace("~(<(body|html)[^>]*\\bxml)___([a-zA-Z]+=\"[^\"]*\"[^>]*/?>)~i", "$1:$3", $fileContents);

}

function postPostProcessFile($config, &$isModified, &$fileContents) {

}

// -- AUTO-GENERATED CODE BELOW. DO NOT EDIT BELOW

// Any code below this line will be auto-updated from the DropScriptTemplate.php. If this file is not
// called 'DropScriptTemplate.php' you should avoid editing it and instead edit DropScriptTemplate.php

function main($droppedFile, $optionalEPUBFile) {

    do { // non-loop

        try {

            $freeUnusedStrings = true;

            $config = init($droppedFile, $optionalEPUBFile);

            if (! file_exists($droppedFile)) {
                logWarning(__METHOD__ . ": file does not exist " . $droppedFile);
                break;
            }

            if (! isAcceptedFile($config, $droppedFile)) {
                echo "File " . basename($droppedFile) . " was not modified.\n";
                logWarning(__METHOD__ . ": file not accepted for processing " . $droppedFile);
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

            $defaultDOMHeader = $config["defaultDOMHeader"];
            if (! $DOMheader && $config["addDOMHeader"]) {
                $DOMheader = $defaultDOMHeader;
            }

            $XMLheader = "";
            $XMLregExp = "~\\s*(<\\?[^>]*\\?>)\\s*~s";
            if (preg_match($XMLregExp, $headLessContents, $matches)) {
                $XMLheader = $matches[1];
                $headLessContents = preg_replace($XMLregExp, "", $headLessContents);
            }

            $defaultXMLHeader = $config["defaultXMLHeader"];
            if (! $XMLheader && $config["addXMLHeader"]) {
                $XMLheader = $defaultXMLHeader;
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

            $domXML = new DomDocument();
            $domHTML = new DomDocument();

            libxml_use_internal_errors(true);

            $isXML = false;
            $xmlErrorCount = 0;
            $isHTML = false;
            $htmlErrorCount = 0;

            $parseAs = strtolower($config["parseAs"]);
            $parseAsXML = $parseAs == "xml";
            $parseAsHTML =  $parseAs == "html";
            if (! ($parseAsXML || $parseAsHTML)) {
                $parseAsXML = true;
                $parseAsHTML = true;
            }

            $forceSaveAs = strtolower($config["forceSaveAs"]);
            $forceSaveAsXML = $forceSaveAs == "xml";
            $forceSaveAsHTML =  $forceSaveAs == "html";

            if ($parseAsXML) {
                logNote(__METHOD__ . ": Attempting to parse input as XML");
                $prefix = "XML";
                $domXML->loadXML($rewrappedContents);
                if ($domXML->hasChildNodes()) {
                    $isXML = true;
                }
                else {
                    logError(__METHOD__ . ": the input file is not valid XML");
                }
                $errors = libxml_get_errors();
                $xmlErrorCount = count($errors);
                if (! $config["ignoreDOMParserErrors"]) {
                    if ($xmlErrorCount != 0) {
                        $rewrappedContentLines = explode("\012", $rewrappedContents);
                        foreach ($errors as $error) {
                            logXMLError($prefix, $error, $rewrappedContentLines);
                        }
                    }
                }
                libxml_clear_errors();
            }

            if ($parseAsHTML) {
                logNote(__METHOD__ . ": Attempting to parse input as HTML");
                $prefix = "HTML";
                $domHTML->loadHTML($rewrappedContents);
                if ($domHTML->hasChildNodes()) {
                    $isHTML = true;
                }
                else {
                    logError(__METHOD__ . ": the input file is not valid HTML");
                }
                $errors = libxml_get_errors();
                $htmlErrorCount = count($errors);
                if (! $config["ignoreDOMParserErrors"]) {
                    if ($htmlErrorCount != 0) {
                        $rewrappedContentLines = explode("\012", $rewrappedContents);
                        foreach ($errors as $error) {
                            logXMLError($prefix, $error, $rewrappedContentLines);
                        }
                    }
                }
                libxml_clear_errors();
            }

            if ($isXML && $xmlErrorCount == 0) {
                $isHTML = false;
            }
            else if ($isHTML && $htmlErrorCount == 0) {
                $isXML = false;
            }
            else if ($isXML && $isHTML) {
                if ($xmlErrorCount <= $htmlErrorCount) {
                    $isHTML = false;
                }
                else {
                    $isXML = false;
                }
            }

            $isDomModified = false;
            if (! $isXML && ! $isHTML) {
                break;
            }

            if ($isHTML) {
                $dom = $domHTML;
            }
            else {
                $dom = $domXML;
            }


            processDOM($config, $isDomModified, $dom);

            $isModified = $isModified || $isDomModified;

            if (! $isDomModified) {
                $processedContents = $rewrappedContents;
            }
            else {
                if ($isXML || $forceSaveAsXML) {
                    $processedContents = $dom->saveXML($dom);
                }
                else if ($isHTML || $forceSaveAsHTML) {
                    $processedContents = $dom->saveHTML($dom);
                }
                else {
                    $processedContents = $rewrappedContents;
                }
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
                
            if ($isXML) {
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
            }

            postPostProcessFile($config, $isModified, $rewrappedPostProcessedContents);

            if ($rewrappedPostProcessedContents == $fileContents) {
                $isModified = false;
            }

            if (! $isModified) {
                echo "File " . basename($droppedFile) . " was not modified.\n";
                break;
            }

            makeBackup($config, $droppedFile);

            writeFileContents($droppedFile, $rewrappedPostProcessedContents);

            echo "Updated file " . basename($droppedFile) . ".\n";
            
        }
        catch (Exception $e) {
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

}

function logXMLError($prefix, $error, $xml)
{
    $message = $xml[$error->line - 1] . "\n";
    $message .= str_repeat('-', $error->column) . "^";

    $message .= trim($error->message) . "\n" .
               "  Line: $error->line" .
               "  Column: $error->column" . "\n";

    switch ($error->level) {
        case LIBXML_ERR_WARNING:
            logWarning(__METHOD__ . $prefix . ":\n" . $message);
            break;
         case LIBXML_ERR_ERROR:
            logError(__METHOD__ . $prefix . ":\n" . $message);
            break;
        case LIBXML_ERR_FATAL:
            logError(__METHOD__ . $prefix . ":\n" . $message);
            break;
    }
}

class ProtectedObject
{
protected $error = false;
    
protected function __construct($defaults = null) 
{
    logEntry(__METHOD__);

    do
    {
        if (! $defaults)
        {
            break;
        }

        $error = false;
    }
    while (false);          

    logExit(__METHOD__);
}

// ****************

}

class Utils
{
const OS_UNKNOWN  = 0;
const OS_OSX      = 1;
const OS_WINDOWS  = 2;
const OS_LINUX    = 3;

const kCRLF = "\r\n";
const kCR = "\r";
const kLF = "\n";

const kPlatformMac                      = "Mac";
const kPlatformWin                      = "Win";
const kPlatformLinux                    = "Lin";
const kPlatformUnknown                  = "Unk";

const kDespaceRegExp                    = "/\s+/";
const kTrimRegExp                       = "/^\s*(.*?)\s*$/";

private static $gPlatform = "";

// ****************

public static function getPlatform() // Static
{
    logEntry(__METHOD__);
    
    if (self::$gPlatform == "")
    {
        $os = self::getOS();
        switch ($os)
        {
            default:
                self::$gPlatform = self::kPlatformUnknown;
                break;
            case self::OS_OSX:
                self::$gPlatform = self::kPlatformMac;
                break;
            case self::OS_WINDOWS:
                self::$gPlatform = self::kPlatformWin;
                break;
            case self::OS_LINUX:
                self::$gPlatform = self::kPlatformLinux;
                break;
        }
    }
    
    logExit(__METHOD__);        
    
    return self::$gPlatform;
}

// ****************

public static function despace($value) // Static
{
    logEntry(__METHOD__);

    $retVal = (! $value) ? "" : $value;
    $retVal = preg_replace(Utils::kDespaceRegExp, "", $retVal);

    logExit(__METHOD__);        
    
    return $retVal;
}

// ****************

public static function getOS()
{
    logEntry(__METHOD__);
    
    $retVal = self::OS_UNKNOWN;
    $os = strtoupper(PHP_OS);
    if (stristr($os, 'DAR'))
    {
        $retVal = self::OS_OSX;
    }
    else if (stristr($os, 'WIN'))
    {
        $retVal = self::OS_WINDOWS;
    }
    else if (stristr($os, 'LIN'))
    {
        $retVal = self::OS_LINUX;
    }

    logExit(__METHOD__);        

    return $retVal;
}
    
// ****************

public static function expandTilde($path) 
{
    logEntry(__METHOD__);
    
    if (function_exists('posix_getuid') && strpos($path, '~') !== false) 
    {
        $info = posix_getpwuid(posix_getuid());
        $path = str_replace('~', $info['dir'], $path);
    }

    logExit(__METHOD__);        
    
    return $path;
}

// ****************

public static function msgBox($message)
{
    logEntry(__METHOD__);
    
    $os = self::getOS();
    if ($os == self::OS_OSX)
    {
        $command = "osascript -e \"display dialog \\\"" . $message . "\\\" buttons {\\\"OK\\\"}\" 2>^1 > /dev/null";
        system($command);
    }
    
    logExit(__METHOD__);        

}

// ****************

public static function setTimezone($default) 
{
    logEntry(__METHOD__);
    
    $timezone = $default;

    if (is_link("/etc/localtime")) 
    {
        // If it is, that file's name is actually the "Olsen" format timezone
        $filename = readlink("/etc/localtime");

        $pos = strpos($filename, "zoneinfo");
        if ($pos) 
        {
            // When it is, it's in the "/usr/share/zoneinfo/" folder
            $systemTimezone = substr($filename, $pos + strlen("zoneinfo/"));
            $timezone = $systemTimezone;
        }
    }
    else 
    {
        // On other systems, like Ubuntu, there's file with the Olsen time
        // right inside it.
        $systemTimezone = file_get_contents("/etc/timezone");
        if ($systemTimezone && strlen($systemTimezone)) 
        {
            $timezone = $systemTimezone;
        }
    }
    
    date_default_timezone_set($timezone);
    
    logExit(__METHOD__);        
}

// ****************

public static function stringToBooleanValue($valueString, $defaultValue)
{
    logEntry(__METHOD__);

    $value = $defaultValue;
    do
    {
        try
        {
            if ($valueString === null)
            {
                $value = $defaultValue;
                break;
            }
        
            $intValue = Utils::toInt($valueString);
            if ($intValue != 0)
            {
                $value = true;
                break;
            }
            
            $valueString = strtolower(substr($valueString,0,1));
            if ($valueString == "y" || $valueString == "t")
            {
                $value = true;
                break;
            }
        
            $value = false;
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);        

    return $value;
}        

// ****************

public static function toFloat($valueString)
{
    logEntry(__METHOD__);

    $value = 0;
    do
    {
        try
        {
            $value = floatval($valueString);                    
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);        

    return $value;
}        

// ****************

public static function toInt($valueString, $base = 10)
{
    logEntry(__METHOD__);

    $value = 0;
    do
    {
        try
        {
            $value = intval($valueString, $base);                    
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);        

    return $value;
}  

// ****************

public static function trim($value) // Static
{
    logEntry(__METHOD__);

    $retVal = (! $value) ? "" : $value;
    $retVal = preg_replace(Utils::kTrimRegExp, "$1", $retVal);

    logExit(__METHOD__);        
    
    return $retVal;
}

// ****************

}

class Ini extends ProtectedObject
{
const kEOL = "\n";
const kIniSection_Main = "main";

private $sections = null;
private $dirty = null;
private $caseSensitive = null;
private $parent = null;

protected function __construct($defaults = null) 
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            parent::__construct($defaults);
            if (! $defaults)
            {
                break;
            }

            if (! property_exists($defaults, "caseSensitive") || ! $defaults->caseSensitive)
            {
                $this->caseSensitive = false;
            }
            else
            {
                $this->caseSensitive = true;
            }

            if (property_exists($defaults, "parent") && $defaults->parent)
            {
                $this->parent = $defaults->parent;
            }
            else
            {
                $this->parent = null;
            }

            $this->dirty = false;

            $iniString = null;
            if (property_exists($defaults, "iniString"))
            {
                $iniString = $defaults->iniString;
            }

            if (! $iniString)
            {
                break;
            }

            $this->setIniString($iniString);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
            $this->error = true;
        }
    }
    while (false);          

    logExit(__METHOD__);
}

// ****************

public static function factory($defaults)
{
    logEntry(__METHOD__);

    try
    {
        $retVal = new Ini($defaults);
        if ($retVal->error)
        {
            $retVal = null;
        }
    }
    catch (Exception $exception)
    {
        logError(__METHOD__ . ": throws " + $exception->getMessage());
        $retVal = null;
    }

    logExit(__METHOD__);

    return $retVal; 
}

// ****************

public function clear()
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            $this->clearDirty();
            $this->sections = null;
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

public function clearDirty()
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            $this->dirty = false;
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

public function deleteSection($sectionName)
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            $section = $this->getSection($sectionName);
            if (! $section)
            {
                break;
            }

            if (! $this->caseSensitive)
            {
                $sectionName = strtolower($sectionName);
            }

            unset($this->sections[$sectionName]);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

public function getFileValue($sectionName, $iniKey, $defaultValue = null)
{
    logEntry(__METHOD__);

    $value = null;
    do
    {
        try
        {
            $value = $this->getFileValue_protected($sectionName, $iniKey, $defaultValue);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

protected function getFileValue_protected_($sectionName, $iniKey, $defaultValue = null)
{
    logEntry(__METHOD__);

    $value = null;
    do
    {
        try
        {
            $value = $this->getValue($sectionName, $iniKey);
            if ($value === null)
            {
                $value = $defaultValue;
                break;
            }

        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

public function getBooleanValue($sectionName, $iniKey, $defaultValue = false)
{
    logEntry(__METHOD__);

    $value = $defaultValue;
    do
    {
        try
        {
            $value = $this->getValue($sectionName, $iniKey);
            if ($value === null)
            {
                $value = $defaultValue;
                break;
            }

            $value = Utils::stringToBooleanValue($value, $defaultValue);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

public function getFloatValue($sectionName, $iniKey, $defaultValue = 0.0)
{
    logEntry(__METHOD__);

    $value = $defaultValue;
    do
    {
        try
        {
            $value = $this->getValue($sectionName, $iniKey);
            if ($value === null)
            {
                $value = $defaultValue;
                break;
            }

            $value = Utils::toFloat($value);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

public function getIniString()
{
    logEntry(__METHOD__);

    $iniString = "";
    do
    {
        try
        {
            if (! $this->sections)
            {
                logError(__METHOD__ . ": sections should be defined");
                break;
            }

            $iniEmpty = true;
            foreach ($this->sections as $sectionName => $section)
            {
                $sectionDataSeen = false;
                foreach ($section as $iniKey => $value)
                {
                    if ($value !== null)
                    {
                        if (! $sectionDataSeen)
                        {
                            if (! $iniEmpty)
                            {
                                $iniString .= Ini::kEOL . Ini::kEOL;
                            }

                            $iniString .= "[" . $sectionName . "]" . Ini::kEOL . Ini::kEOL;
                            $sectionDataSeen = true;
                        }
                        $iniString .= $iniKey . "=\"" . $value . "\"" . Ini::kEOL;
                        $iniEmpty = false;
                    }
                }
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $iniString;
}        

// ****************

public function getIntValue($sectionName, $iniKey, $defaultValue = 0)
{
    logEntry(__METHOD__);

    $value = $defaultValue;
    do
    {
        try
        {
            $value = $this->getValue($sectionName, $iniKey);
            if ($value === null)
            {
                $value = $defaultValue;
                break;
            }

            $value = Utils::toInt($value);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

private function &getSection($sectionName)
{
    logEntry(__METHOD__);

    $section = null;
    do
    {
        try
        {
            if (! $sectionName || $sectionName == "")
            {
                logError(__METHOD__ . ": needs $sectionName");
                break;
            }

            if (! $this->sections)
            {
                break;
            }

            if (! $this->caseSensitive)
            {
                $sectionName = strtolower($sectionName);
            }

            if (! array_key_exists($sectionName, $this->sections)) 
            {
                break;
            }
            
            $section = &$this->sections[$sectionName];
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
    
    return $section;
}

// ****************

public function getSectionKeys($sectionName) // Do not override. Override _protected_ variant instead
{
    logEntry(__METHOD__);

    $retVal = null;

    do
    {
        try
        {
            $retVal = $this->getSectionKeys_protected_($sectionName);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $retVal;
}        

// ****************

protected function getSectionKeys_protected_($sectionName) // Overrideable
{
    logEntry(__METHOD__);

    $retVal = null;

    do
    {
        try
        {
            $retValDict = [];
            $parent = $this->parent;
            if ($parent)
            {
                $retVal = $parent->getSectionKeys_protected_($sectionName);
                if ($retVal)
                {
                    foreach ($retVal as $key)
                    {
                        $retValDict[$key] = true;
                    }
                }
            }

            $section = $this->getSection($sectionName);
            if (! $section)
            {
                break;
            }
            
            if (! $retVal)
            {
                $retVal = [];
            }

            foreach ($section as $key => $value)
            {
                if (! array_key_exists($key, $retValDict))
                {
                    array_push($retVal, $key);
                }
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $retVal;
}        

// ****************

public function getSectionKeysNonParentRecurse($sectionName) // Do not override. Override _protected_ variant instead
{
    logEntry(__METHOD__);

    $retVal = null;

    do
    {
        try
        {
            $retVal = $this->getSectionKeysNonParentRecurse_protected_($sectionName);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $retVal;
}        

// ****************

protected function getSectionKeysNonParentRecurse_protected_($sectionName) // Overrideable
{
    logEntry(__METHOD__);

    $retVal = null;

    do
    {
        try
        {
            if (! $sectionName || $sectionName == "")
            {
                logError(__METHOD__ . ": need $sectionName");
                break;
            }

            $section = $this->getSection($sectionName);
            if (! $section)
            {
                break;
            }
            
            $retVal = [];
            foreach ($section as $iniKey)
            {
                array_push($retVal, $iniKey);
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $retVal;
}        

// ****************

public function getSectionNames() // Do not override. Override _protected_ variant instead
{
    logEntry(__METHOD__);

    $retVal = null;

    do
    {
        try
        {
            $retVal = $this->getSectionNames_protected_();
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $retVal;
}        

// ****************

protected function getSectionNames_protected_() // Overrideable
{
    logEntry(__METHOD__);

    $retVal = null;

    do
    {
        try
        {
            if (! $this->sections)
            {
                break;
            }

            $retVal = [];
            foreach ($this->sections as $sectionName => $content)
            {
                array_push($retVal, $sectionName);
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $retVal;
}        

// ****************

public function getValue($sectionName, $iniKey, $defaultValue = null) // Do not override. Override _protected_ variant instead
{
    logEntry(__METHOD__);

    $value = null;
    do
    {
        try
        {
            $value = $this->getValueRecurseParents_protected_($sectionName, $iniKey, $defaultValue);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

protected function getValue_protected_($sectionName, $iniKey, $defaultValue) // Overrideable
{
    logEntry(__METHOD__);

    $value = $defaultValue;
    
    do
    {
        try
        {
            $section = $this->getSection($sectionName);
            if (! $section)
            {
                break;
            }
            if (! $this->caseSensitive)
            {
                $iniKey = strtolower($iniKey);
            }

            if (array_key_exists($iniKey, $section))
            {
                $value = $section[$iniKey];
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

protected function getValueRecurseParents_protected_($sectionName, $iniKey, $defaultValue) // Overrideable
{
    logEntry(__METHOD__);

    $value = null;
    
    do
    {
        try
        {
            $value = $this->getValue_protected_($sectionName, $iniKey, null);
        
            if ($value === null)
            {
                $parent = $this->parent;
                if (! $parent)
                {
                    $value = $defaultValue;
                }
                else
                {
                    $value = $parent->getValueRecurseParents_protected_($sectionName, $iniKey, $defaultValue);
                }
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

public function getValueNonParentRecurse($sectionName, $iniKey, $defaultValue = null) // Do not override. Override _protected_ variant instead
{
    logEntry(__METHOD__);

    $value = null;
    do
    {
        try
        {
            $value = $this->getValue_protected_($sectionName, $iniKey, $defaultValue);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

public function isEmpty()
{
    logEntry(__METHOD__);

    $isEmpty = true;
    do
    {
        try
        {
            if (! $this->sections)
            {
                break;
            }

            foreach ($this->sections as $sectionName => $section)
            {
                foreach ($section as $iniKey)
                {
                    $isEmpty = false;
                    break;
                }
                if (! $isEmpty)
                {
                    break;
                }
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $isEmpty;
}        

// ****************

public function makeDirty()
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            $this->dirty = true;
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

private function parse($iniString)
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            if (! $this->sections)
            {
                $this->sections = [];
            }

            $iniString = preg_split("/(\015\012|\015|\012)/",$iniString);

            logNote(__METHOD__ . ': $iniString = ' . $iniString);

            $sectionName = self::kIniSection_Main;
            $suffix = null;
            foreach ($iniString as $rawIniLine)
            {
                do
                {
                    $iniLine = Utils::trim($rawIniLine);
                    $iniLineStart = substr($iniLine, 0, 1);
                    if ($iniLineStart == "#" || $iniLineStart == ";") // comment
                    {
                        break;
                    }

                    if ($iniLine == "++")
                    {
                        if (! $suffix)
                        {
                            $suffix = 1;
                        }
                        else
                        {
                            $suffix++;
                        }
                        break;
                    }

                    $iniLineEnd = substr($iniLine, -1, 1);
                    if ($iniLineStart == "[" && $iniLineEnd == "]") // section name
                    {
                        $sectionName = substr($iniLine, 1, strlen($iniLine) - 2);
                        if (! $this->caseSensitive)
                        {
                            $sectionName = strtolower($sectionName);
                        }
                        $suffix = null;
                        break;
                    }

                    $iniLineSplit = preg_split("/=/", $iniLine);
                    if (count($iniLineSplit) < 2)
                    {
                        break;
                    }
                    
                    $iniKey = Utils::despace($iniLineSplit[0]);
                    if ($iniKey == "")
                    {
                        break;
                    }

                    if (! $this->caseSensitive)
                    {
                        $iniKey = strtolower($iniKey);
                    }

                    if ($suffix)
                    {
                        $iniKey .= $suffix;
                    }

                    $value = Utils::trim(substr($iniLine,strlen($iniLineSplit[0]) + 1));
                    if (strlen($value) >= 2 && substr($value,0,1) == "\"" && substr($value, -1, 1) == "\"")
                    {
                        $value = stripcslashes(substr($value,1,strlen($value)-2));
                    }
                    
                    if ($this->getValueNonParentRecurse($sectionName, $iniKey))
                    {
                        logError(__METHOD__ . ": duplicate iniKey " . $iniKey . " in section [" . $sectionName . "]");
                    }

                    $this->setValue($sectionName, $iniKey, $value);
                    logError(__METHOD__ . ": duplicate iniKey " . $iniKey . " in section [" . $sectionName . "]");

                }
                while (false);
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

public function save() // Do not override. Override _protected_ variant instead
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            $this->save_protected_();
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

protected function save_protected_() // Overrideable
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            this.clearDirty();
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

public function setBooleanValue($sectionName, $iniKey, $value)
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            if ($value === null)
            {
                $this->setValue($sectionName, $iniKey, "N");
            }
            else
            {
                $this->setValue($sectionName, $iniKey, $value ? "Y" : "N");
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

public function setFloatValue($sectionName, $iniKey, $value)
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            if ($value === null)
            {
                $this->setValue($sectionName, $iniKey, $value);
            }
            else
            {
                $this.setValue($sectionName, $iniKey, "" + $value);
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

public function setFileValue($sectionName, $iniKey, $value)
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            if ($value === null)
            {
                $this->setValue(sectionName, iniKey, value);
            }
            {
                $this->setValue(sectionName, iniKey, value + "");
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

public function setIntValue($sectionName, $iniKey, $value)
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            if (value === null)
            {
                this.setValue(sectionName, iniKey, value);
            }
            else
            {
                this.setValue(sectionName, iniKey, value + "");
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

function setIniString($iniString)
{
    logEntry(__METHOD__);
    
    do
    {
        try
        {
            if ($iniString)
            {
                $this->parse($iniString);
                $this->clearDirty();
            }
            else
            {
                $this->clear();
            }
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);        
}

// ****************

public function setValue($sectionName, $iniKey, $value)
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            if (! $sectionName || $sectionName == "")
            {
                logError(__METHOD__ . ": needs $sectionName");
                break;
            }

            $section = &$this->getSection($sectionName);
            if (! $section)
            {
                if (! $this->sections)
                {
                    $this->sections = [];
                }

                if (! $this->caseSensitive)
                {
                    $sectionName = strtolower($sectionName);
                }

                $section = [];
                $this->sections[$sectionName] = &$section;
            }

            if (! $this->caseSensitive)
            {
                $iniKey = strtolower($iniKey);
            }

            if ($value !== null)
            {
                if (! array_key_exists($iniKey, $section) || $section[$iniKey] != $value)
                {
                    $this->makeDirty();
                    $section[$iniKey] = $value;
                }
            }
            else if (array_key_exists($iniKey, $section))
            {
                $this->makeDirty();
                unset($section[$iniKey]);
            }

        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
   }
    while (false);

    logExit(__METHOD__);        
}        

// ****************

public function toString()
{
    logEntry(__METHOD__);

    $iniString = "";
    do
    {
        try
        {
            $iniString = $this->getIniString();
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);        

    return $iniString;
}        

// ****************

}

class IniFile extends Ini
{
private $file = null;
    
protected function __construct($defaults = null) 
{
    logEntry(__METHOD__);

    do
    {
        try 
        {
            parent::__construct($defaults);
            if (! $defaults)
            {
                $this->error = true;
                break;
            }

            if (! property_exists($defaults, "file") || ! $defaults->file)
            {
                $this->error = true;
                break;
            }

            $this->setFile($defaults->file);        
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
            $this->error = true;
        }
    }
    while (false);          

    logExit(__METHOD__);
}

// ****************

public static function factory($defaults)
{
    logEntry(__METHOD__);

    try
    {
        $retVal = new IniFile($defaults);
        if ($retVal->error)
        {
            $retVal = null;
        }
    }
    catch (Exception $exception)
    {
        logError(__METHOD__ . ": throws " + $exception->getMessage());
        $retVal = null;
    }

    logExit(__METHOD__);

    return $retVal; 
}

// ****************

public function appendAndSetFile($file)
{
    logEntry(__METHOD__);

    $this->setFile($file, true);

    logExit(__METHOD__);
}        

// ****************

private function appendFile()
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            $iniFileString = $this->readFileAsString();
            $this->setIniString($iniFileString);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

private function readFile()
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            $this->clear();
            $this->appendFile();
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        

// ****************

private function readFileAsString()
{
    logEntry(__METHOD__);

    $iniFileString = "";
    do
    {
        try
        {
            $file = $this->file;
            if (! $file)
            {
                break;
            }

            if (! file_exists($file))
            {
                break;
            }

            $iniFileString = file_get_contents($file);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $iniFileString;
}        

// ****************

protected function save_protected_()
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            $dirty = $this->getDirty();
            if (! $dirty)
            {
                break;
            }

            $file = $this->file;
            if (! $file)
            {
                logError(__METHOD__ . ": needs \$this->file");
                break;
            }
            
            file_put_contents($file, $this->getIniString());

            parent::save_protected_();
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
    
}        

// ****************

protected function getFileValue_protected($sectionName, $iniKey, $defaultValue)
{
    logEntry(__METHOD__);

    $value = null;
    do
    {
        try
        {
            $value = $this->getFileValueNonParentRecurse($sectionName, $iniKey, null);
            if ($value !== null)
            {
                break;
            }

            $parent = this.getParent();
            if (! $parent)
            {
                $value = $defaultValue;
            }
            else
            {
                $value = $parent->getFileValue($sectionName, $iniKey, $defaultValue);
            }                
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

function getFileValueNonParentRecurse($sectionName, $iniKey, $defaultValue = null) // Do not override. Override _protected_ variant instead
{
    logEntry(__METHOD__);

    $value = null;
    
    do
    {
        try
        {
            $value = $this->getFileValueNonParentRecurse_protected_($sectionName, $iniKey, $defaultValue);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

protected function getFileValueNonParentRecurse_protected_($sectionName, $iniKey, $defaultValue) // Overrideable
{
    logEntry(__METHOD__);

    $value = null;
    
    do
    {
        try
        {
            $value = $this->getValueNonParentRecurse($sectionName, $iniKey, $defaultValue);
            if (! $value)
            {
                $value = $defaultValue;
                break;
            }

            if (strncmp($value, "..", 2) == 0)
            {
                $value = dirname($this->file) + "/" + value;
            }
            else if (strncmp($value, ".", 1) == 0)
            {
                $value = dirname($this->file) + substr($value,1);
            }

            $value = realpath($value);
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);

    return $value;
}        

// ****************

public function setFile($file) // Overrides default setter
{
    logEntry(__METHOD__);

    $this->setFile_private_($file);

    logExit(__METHOD__);
}        

// ****************

private function setFile_private_($file, $append = false)
{
    logEntry(__METHOD__);

    do
    {
        try
        {
            if (! $file)
            {
                break;
            }
        
            $file = realpath($file);
            if ($this->file)
            {
                if ($file == $this->file)
                {
                    break;
                }
            }

            $this->file = $file;
            if (! $append) 
            {
                $this->clear();
            }
            $this->appendFile();
        }
        catch (Exception $exception)
        {
            logError(__METHOD__ . ": throws " + $exception->getMessage());
        }
    }
    while (false);

    logExit(__METHOD__);
}        
/// ****************

}

define("KEY_SUFFIX_NEWLINE_ENCODED_AS",              "_encodedNewLines");
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

    logEntry(__METHOD__);

    do { // non-loop

        try {

            if (! $in_json) {
                logNote(__METHOD__ . ": no in_json");
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
                        if ($c == "\n" || $c == "\r") {
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

            logNote(__METHOD__ . ": decoded = \n" . $decoded_json);

            $retVal = $decoded_json;

        }
        catch (Exception $e) {
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit(__METHOD__);

    return $retVal;
}

define("LOG_LEVEL_NONE",    0);
define("LOG_LEVEL_ERROR",   1);
define("LOG_LEVEL_WARNING", 2);
define("LOG_LEVEL_NOTE",    3);
define("LOG_LEVEL_TRACE",   4);

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
    $config["logLevel"]                 = LOG_LEVEL_NONE;
    $config["logEntryExit"]             = false;
    $config["logToFile"]                = false; // File path or false
    $config["logToConsole"]             = true;  // true or false
    $config["ignoreDOMParserErrors"]    = true;
    $config["parseAsXML"]               = true;
    $config["parseAsHTML"]              = true;
    $config["format"]                   = "BUILTIN";

    return $config;
}


// --

function init($droppedFile, $optionalEPUBFile) {

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

            logNote(__METHOD__ . ": has loaded global config " . $globalConfigFile);

            $localConfigFile = nearbyConfigFile($droppedFile);
            logNote(__METHOD__ . ": attempt to load optional local config " . $localConfigFile);
            mergeConfig($config, $localConfigFile);

            if (isset($optionalEPUBFile)) {
                $epubConfigFile = nearbyConfigFile($optionalEPUBFile);
                logNote(__METHOD__ . ": attempt to load optional epub-local config " . $epubConfigFile);
                mergeConfig($config, $epubConfigFile);
            }

            // Allow over-riding

            $LOGLEVEL = $config["logLevel"];
            $LOG_TO_FILE = $config["logToFile"];
            $LOG_TO_CONSOLE = $config["logToConsole"];
            $LOG_ENTRY_EXIT = $config["logEntryExit"];

            $config["droppedFilePath"] = $droppedFile;
            $config["droppedFileName"] = basename($droppedFile);
            if ($optionalEPUBFile) {
                $config["epubFilePath"] = $optionalEPUBFile;
                $config["epubFileName"] = basename($optionalEPUBFile);
            }
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

    logEntry(__METHOD__);

    do { // non-loop
        try {

            $fileNamePieces = explode(".", basename($filePath));
            $numPieces = count($fileNamePieces);

            $extension = "";
            if ($numPieces <= 1) {
                logWarning(__METHOD__ . ": no file name extension for " . $filePath);
                break;
            }

            $extension = strtolower($fileNamePieces[$numPieces - 1]);

            $fileNameExtensions = $config["acceptFileNameExtensions"];
            if ($config["format"] == "INI") {
                if (! is_array($fileNameExtensions)) {
                    $rawFileNameExtensions = preg_split("/,/", $fileNameExtensions);
                    $fileNameExtensions = [];
                    foreach ($rawFileNameExtensions as $rawFileNameExtension) {
                        $fileNameExtension = preg_replace("/\s*\"?(.*?)\"?\s*/", "$1", $rawFileNameExtension);
                        $fileNameExtensions[] = $fileNameExtension;
                    }
                }
            }

            foreach ($fileNameExtensions as $fileNameExtension) {
                $compareExtension = strtolower($fileNameExtension);
                if ($extension == $compareExtension) {
                    $retVal = true;
                    break;
                }
            }
        }
        catch (Exception $e) {
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit(__METHOD__);

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

    if ($LOGLEVEL >= LOG_LEVEL_ERROR) {
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
            fwrite($logFile, $message . "\n");
            fclose($logFile);
        }
    }

    if ($LOG_TO_CONSOLE) {
        echo $message . "\n";
    }
}

function logNote($message) {
    global $LOGLEVEL;

    if ($LOGLEVEL >= LOG_LEVEL_NOTE) {
        logMessage("NOTE : " . $message);
    }
}

function logTrace($message) {
    global $LOGLEVEL;

    if ($LOGLEVEL >= LOG_LEVEL_TRACE) {
        logMessage("TRACE: " . $message);
    }
}

function logWarning($message) {
    global $LOGLEVEL;

    if ($LOGLEVEL >= LOG_LEVEL_WARNING) {
        logMessage("WARN : " . $message);
    }
}

function makeBackup($config, $filePath) {

    logEntry(__METHOD__);

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
                    logNote(__METHOD__ . ": retaining previous backup. No backup made");
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
                                logNote(__METHOD__ . ": removing oldest backup " . $backupFile);
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

            logNote(__METHOD__ . ": backup made to " . $backupFile);
        }
        catch (Exception $e) {
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit(__METHOD__);
}

function mergeConfig(&$config, $filePath) {

    logEntry(__METHOD__);

    do { // non-loop

        try {

            $mergeConfigTXT = readFileContents($filePath);
            if (! $mergeConfigTXT) {
                if (file_exists($filePath)) {
                    logNote(__METHOD__ . ": no data retrieved from " . $filePath);
                }
                break;
            }

            if (preg_match("/^\\s*{/", $mergeConfigTXT) > 0) {
                $mergeConfigJSON = $mergeConfigTXT;
                $mergeConfigJSON = commented_json_decode($mergeConfigJSON);
                $mergeConfig = json_decode($mergeConfigJSON);
                if (isset($mergeConfig)) {
                    foreach ($mergeConfig as $key => $value) {
                        logNote(__METHOD__ . ": merging [" . $key . "] = \"" . $value . "\"");
                        $config[$key] = $value;
                    }
                }
                $config["format"] = "JSON";
                break;
            }

            $defaults = new stdClass();
            $defaults->iniString = $mergeConfigTXT;
            $defaults->caseSensitive = true;
            $mergeConfig = Ini::factory($defaults);
            if (isset($mergeConfig)) {
                $keys = $mergeConfig->getSectionKeys("main");
                if (isset($keys)) {
                    foreach ($keys as $key) {
                        $value = $mergeConfig->getValue("main", $key);
                        logNote(__METHOD__ . ": merging [" . $key . "] = \"" . $value . "\"");
                        $config[$key] = $value;
                    }
                }

                $sectionNames = $mergeConfig->getSectionNames();
                foreach ($sectionNames as $sectionName) {
                    if ($sectionName != "main") {
                        $config[$sectionName] = [];
                        $section = &$config[$sectionName];
                        $keys = $mergeConfig->getSectionKeys($sectionName);
                        if (isset($keys)) {
                            foreach ($keys as $key) {
                                $rootKey = preg_replace("/(.*[^\d])\d+/", "$1", $key);
                                if (substr($rootKey, -strlen(KEY_SUFFIX_NEWLINE_ENCODED_AS)) != KEY_SUFFIX_NEWLINE_ENCODED_AS) {
                                    $keyIdx = substr($key, strlen($rootKey));
                                    if ($keyIdx == "") {
                                        $keyIdx = 0;
                                    }
                                    $newlineEncodedAsKey = $rootKey . KEY_SUFFIX_NEWLINE_ENCODED_AS . $keyIdx;
                                    $newLineEncodedAs = $mergeConfig->getValue($sectionName, $newlineEncodedAsKey);
                                    $value = $mergeConfig->getValue($sectionName, $key);
                                    if (isset($newLineEncodedAs)) {
                                        $value = str_replace($newLineEncodedAs, "\n", $value);
                                    }
                                    if (! isset($section[$keyIdx])) {
                                        $section[$keyIdx] = new stdClass();
                                    }
                                    $entry = &$section[$keyIdx];
                                    $entry->{$rootKey} = $value;
                                }
                            }
                        }
                    }
                }
            }
            $config["format"] = "INI";

        }
        catch (Exception $e) {
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit(__METHOD__);

}

function nearbyConfigFile($filePath) {

    logEntry(__METHOD__);

    do { // non-loop

        try {

            $parentDir = dirname($filePath);
            $scriptFileName = stripFileNameExtension(basename(__FILE__));
            $configFileName = $parentDir . DIRECTORY_SEPARATOR . $scriptFileName . ".config.txt";

        }
        catch (Exception $e) {
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit(__METHOD__);

    return $configFileName;
}

function readFileContents($filePath) {

    $retVal = "";

    logEntry(__METHOD__);
 
    do { // non-loop

        try {

            if (! file_exists($filePath)) {
                logNote(__METHOD__ . ": file does not exist " . $filePath);
                break;
            }

            $retVal = file_get_contents($filePath);
        }
        catch (Exception $e) {
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit(__METHOD__);

    return $retVal;
}

function stripFileNameExtension($fileOrFilePath) {

    $retVal = $fileOrFilePath;

    logEntry(__METHOD__);

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
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit(__METHOD__);

    return $retVal;

}

function writeFileContents($filePath, $content) {

    logEntry(__METHOD__);

    do { // non-loop

        try {

            $outFile = fopen($filePath, "w");
            if (! $outFile) {
                logWarning(__METHOD__ . ": cannot open file for writing " . $filePath);
                break;
            }

            fwrite($outFile, $content);
            fclose($outFile);
        }
        catch (Exception $e) {
            logError(__METHOD__ . ": throws " . $e->getMessage());
        }
    }
    while (false); // non-loop

    logExit(__METHOD__);

}

main($argv[1], $argv[2]);
