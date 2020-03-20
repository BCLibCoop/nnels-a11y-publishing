# Extractor.php

More info, see:

https://github.com/BCLibCoop/nnels-a11y-publishing/wiki/DropScript-Template-Documentation

## What it does

Extractor will do a search through the files inside an EPUB or EPUB folder,
and will look for certain patterns. When a pattern is found, it is replaced
with some replacement string, then output to a file with the same name as the
original htm, html or xhtml file but with a modified file name extension.

Extractor does not make changes to the xhtml or EPUB files, so no backups need to
be made.

## Configuration

### acceptFileNameExtensions

Optional. The script will ignore any files whose file name does not end in one of the listed extensions

The default when this is omitted is:

    "acceptFileNameExtensions": [ "html", "htm", "xhtml" ]

### extractions

A list between `[]` of one or more JSON objects (each between `{}`). Each JSON object contains three attributes: 
```
patternFrom
patternTo
outputFileNameExtension
```

When processing single files (.xhtml, .html) the output file is a same-name file
with a file name extension as defined by outputFileNameExtension. 

E.g. if `"outputFileNameExtension": "txt"`, then processing
```
Page1.xhtml
```
will get output results in
```
Page1.txt
```

When processing whole EPUB files, the output file name is based on the EPUB file name, rather
than on the individual files inside the EPUB.

Each file is searched for one or more matches of `patternFrom`. If a match is found, then
`patternTo` is written to the output file, after doing a second search-and-replace on 
`patternTo`. 

Placeholders `$1, $2,...` in `patternTo` are replaced with the corresponding matches taken from 
the matching `patternFrom`. 

Furthermore, placeholder `$fileName` is replaced with the name
of the .xhtml or .html file.

Example: 

If an input myfile.xhtml file contains:
```
<div id="_idContainer083" class="Basic-Text-Frame">
   <div style="width:6060px;height:160px;position:absolute;top:0px;left:0px;-webkit-transform-origin: 0% 0%; -webkit-transform: translate(0px,2.63px) rotate(0deg) scale(0.05);transform-origin: 0% 0%; transform: translate(0px,2.63px) rotate(0deg) scale(0.05);">
       <p class="VRH ParaOverride-1"><span id="_idTextSpan9142" class="CharOverride-4" style="position:absolute;top:7.75px;left:0px;">123</span></p>
   </div>
</div>
```   
and the Extractor.config.txt file has a JSON object:
```
{
    "patternFrom": "/<div id=\"[^\"]*\" class=\"Basic-Text-Frame\"[^>]*>[ \\r\\n\\s]*<div[^>]*>[ \\r\\n\\s]*<p class=\"(Basic-Paragraph|VRH|RRH)[^>]*>[ \\r\\n\\s]*<span[^>]*>[ \\r\\n\\s]*(\\d+|[ivxclm]+)[ \\r\\n\\s]*<\\/span>[ \\r\\n\\s]*<\\/p>[ \\r\\n\\s]*<\\/div>[ \\r\\n\\s]*<\\/div>/",
    "patternTo": "\\t\\t\\t<li><a href=\"$fileName#$2\">$2</a></li>",
    "outputFileNameExtension": "txt"
}
```
then we'll have a match. The matching parenthesized GREP subpatterns are `$1` = `VRH`, `$2` = `123`.

We then take `patternTo`, and replace `$2` with `123`, and `$filename` with `myfile.xhtml`. `\t` stands for a tab, so we output
```
            <li><a href="myfile.xhtml#123">123</a></li>
```
Because we need to store the GREP pattern as a JSON string, pay attention to the escaping that's needed. 

The actual GREP expression:
```
<div id="[^"]*" class="Basic-Text-Frame"[^>]*>[ \r\n\s]*<div[^>]*>[ \r\n\s]*<p class="(Basic-Paragraph|VRH|RRH)[^>]*>[ \r\n\s]*<span[^>]*>[ \r\n\s]*(\d+|[ivxclm]+)[ \r\n\s]*</span>[ \r\n\s]*</p>[ \r\n\s]*</div>[ \r\n\s]*</div>
```
Split up over multiple lines for readability:
```
<div id="[^"]*" class="Basic-Text-Frame"[^>]*>[ \r\n\s]*
  <div[^>]*>[ \r\n\s]*
    <p class="(Basic-Paragraph|VRH|RRH)[^>]*>[ \r\n\s]*
      <span[^>]*>[ \r\n\s]*
        (\d+|[ivxclm]+)[ \r\n\s]*
      </span>[ \r\n\s]*
    </p>[ \r\n\s]*
  </div>[ \r\n\s]*
</div>
```
Step 1: Encoding for PHP: we escape any forward slashes inside the GREP expression (i.e. `/` becomes `\/`), then put the GREP expression between two forward slashes. Do not change the order of these operations. 
```
/<div id="[^"]*" class="Basic-Text-Frame"[^>]*>[ \r\n\s]*
  <div[^>]*>[ \r\n\s]*
    <p class="(Basic-Paragraph|VRH|RRH)[^>]*>[ \r\n\s]*
      <span[^>]*>[ \r\n\s]*
        (\d+|[ivxclm]+)[ \r\n\s]*
      <\/span>[ \r\n\s]*
    <\/p>[ \r\n\s]*
  <\/div>[ \r\n\s]*
<\/div>/
```
Step 2: Encoding for JSON: we replace all backslashes by double-backslashes (`\` to `\\`), then prefix all double quotes with a backslash (`"` to `\"`), then we enclose the string in double quotes. Do not change the order of these operations.
```
"/<div id=\"[^\"]*\" class=\"Basic-Text-Frame\"[^>]*>[ \\r\\n\\s]*
  <div[^>]*>[ \\r\\n\\s]*
    <p class=\"(Basic-Paragraph|VRH|RRH)[^>]*>[ \\r\\n\\s]*
      <span[^>]*>[ \\r\\n\\s]*
        (\\d+|[ivxclm]+)[ \\r\\n\\s]*
      <\\/span>[ \\r\\n\\s]*
    <\\/p>[ \\r\\n\\s]*
  <\\/div>[ \\r\\n\\s]*
<\\/div>/"
```
As one long line:
```
"/<div id=\"[^\"]*\" class=\"Basic-Text-Frame\"[^>]*>[ \\r\\n\\s]*<div[^>]*>[ \\r\\n\\s]*<p class=\"(Basic-Paragraph|VRH|RRH)[^>]*>[ \\r\\n\\s]*<span[^>]*>[ \\r\\n\\s]*(\\d+|[ivxclm]+)[ \\r\\n\\s]*<\\/span>[ \\r\\n\\s]*<\\/p>[ \\r\\n\\s]*<\\/div>[ \\r\\n\\s]*<\\/div>/"
```
This gives us the string for `patternFrom`

### logLevel

Set to 0, 1, 2, 3, or 4. Depending on the number, more or less logging information will be
provided. Useful for diagnostics when the script does not seem to work correctly.

The default when this is omitted is:

    "logLevel": 0
