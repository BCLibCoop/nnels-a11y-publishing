# SearchAndReport.php

## What it does

SearchAndReport.php is a command-line PHP script which can process an HTML file.

It will look for specific search patterns, perform a search-and-replace on each occurrence it finds
and then report what it has found.

It is pre-configured to report any tags of the form 

```
<span ... role="doc-pagebreak" ... aria-label="PAGENR" />
```

and it will report the aria-label contents for each occurrence found.

## Configuration

SearchAndReport.php will look for a file SearchAndReport.config.txt nearby. In that file you can set 
or override configuration options. 

The names of these options are case-sensitive.

### acceptFileNameExtensions

Optional. The script will ignore any files whose file name does not end in one of the listed extensions

The default when this is omitted is:

    "acceptFileNameExtensions": [ "html", "htm", "xhtml" ]

### backupFileNameExtension

Optional. The file name extension to use for backup files

The default when this is omitted is:

    "backupFileNameExtension": "old"

### logLevel

Set to 0, 1, 2, 3, or 4. Depending on the number, more or less logging information will be
provided. Useful for diagnostics when the script does not seem to work correctly.

The default when this is omitted is:

    "logLevel": 0

### maxBackupCount

Optional. How many backup files to keep.

The default when this is omitted is:

    "maxBackupCount": 5

If maxBackupCount is 0, no backups are made

If maxBackupCount is greater than zero the backups will be

    SomeFile.xhtml ->
        SomeFile.xhtml.old
        SomeFile.xhtml_1.old
        SomeFile.xhtml_2.old
        ...
        SomeFile.xhtml_5.old

The SomeFile.xhtml.old is special: once made, it is never overwritten. It
stores the content of the original file from before you ran the script for the 
first time.

SomeFile.xhtml&lowbar;1.old, SomeFile.xhtml&lowbar;2.old... rotate. The &lowbar;1 file is the latest,
the &lowbar;5 file is the oldest.

### searchpatterns

Required. Provide an array of entries for find, then search-and-replace in order to generate
reported items.

Each entry has a "match", a "convertMatchFrom" and a "convertMatchTo" string. Individual entries are separated by commas.

The "match" string is a PHP regular expression string, in JavaScript/JSON encoded
fashion. This expresses what we're looking for.

The "convertMatchFrom" string a search string _within_ a match string. This allows us to extract some
sub-string of the match.

The "convertMatchTo" string a replacement string. This is what will end up in the report.

All three strings are quoted and in JavaScript notation.

That means that all double quotes need to be prefixed with a backslash \

A new line character can be encoded as \n 

See

https://www.php.net/manual/en/reference.pcre.pattern.syntax.php

https://json.org/
