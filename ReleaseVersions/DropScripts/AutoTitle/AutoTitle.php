<?php

$file = $argv[1];
$oldFile = $file . ".old";

$dom = new DomDocument();
$dom->loadHTMLFile($file);

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

if ($isModified) {

	rename($file, $oldFile);
	$output = $dom->saveHTML();

	$outFile = fopen($file, "w");
	fwrite($outFile, $output);
	fclose($outFile);

}

