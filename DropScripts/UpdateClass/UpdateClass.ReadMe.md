# UpdateClass.php

## What it does

UpdateClass.php is a command-line PHP script which can process an HTML file.

It will look for certain tags. On each of the designated tags, it will look for 
the class attribute. It will then perform one or more search-and-replace
operations on these classes. 

All search patterns use a GREP syntax.

The script will scan all tags, and for each matching tag, it will scan all classes,
and for each matching class, it will perform a search-and-replace.

If the class becomes empty, the class attribute will be removed from the tag.

## Configuration

UpdateClass.php will look for a file UpdateClass.config.txt nearby. In that file you can set 
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

SomeFile.xhtml_1.old, SomeFile.xhtml_2.old... rotate. The _1 file is the latest,
the _5 file is the oldest.

### processTags

A data structure which sets up the search and replace.

processTags is an array of entries. Each entry can match one or more tags.

The sample setup uses /.*/ as its matching pattern, so it will match all tags,
and hence only a single entry is needed. But you could have multiple entries,
for example, some to match the <p> tag, some to match a <div> tag, and so on...

Each processTag entry is similar to:

    {
		"tagMatch": "/^.*$/i",
		"processClasses": [ ... ]	
    }

If a tag matches the tagMatch the script will process the list of processClasses.

Each processClass entry is similar to:

    {
		"classMatch": "/_idGenCharOverride-\\d*/",
		"classReplace": ""
    }

The classMatch is a GREP expression to match a class name

The classReplace is how that GREP expression should be replaced.
