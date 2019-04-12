<?php

$file = "/Users/kris/Desktop/t.txt";
$handle = fopen($file, "a");
fwrite($handle, $argv[1] . "\n");
fclose($handle);

echo "Hello";