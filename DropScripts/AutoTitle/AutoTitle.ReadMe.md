# AutoTitle.php

## What it does

AutoTitle.php is a command-line PHP script which can process an HTML file.

It will look for the  &lt;title&gt; tag. 

If the  &lt;title&gt; tag matches the HTML file name, the script will try to find a 
more suitable title and replace the  &lt;title&gt; tag with it.

Example: if there is a file

    SomeFile.xhtml

and it contains

    <title>SomeFile</title>

it will be processed by AutoTitle.php.

If the title is different, it won't be touched, unless you change the AutoTitle.config.txt 
file.

For a suitable title, the script will look for the first &lt;h1&gt; tag. If no &lt;h1&gt; tag can be found
it will try &lt;h2&gt;, then &lt;h3&gt;...

If still no suitable title can be found, it will look for the first &lt;p&gt; tag.

By default, the AutoTitle.php script will ignore subtags in the header. For example, if it finds:

    <h1><span class="chapternumber">iii&</span>My Chapter</h1>

then the title will be

    My Chapter

## Configuration

AutoTitle.php will look for a file AutoTitle.config.txt nearby. In that file you can set 
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

### forcedReplaceTitle

Set to 0 or 1. If set to 1 the script will always replace the title, even if it is not the same
as the HTML file name.

The default when this is omitted is:

    "forcedReplaceTitle": 0

### keepTitleSubtags

Set to 0 or 1. If set to 1 the script will retain the content of the subtags. In the example
earlier on the title would become

     iiiMy Chapter

The default when this is omitted is:

    "keepTitleSubtags": 0

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

    SomeFile.xhtml -&gt;
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
