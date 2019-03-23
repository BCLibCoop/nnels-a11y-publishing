More info in the Wiki:


https://github.com/BCLibCoop/nnels-a11y-publishing/wiki/Requirements-List

-----

To generate a list of paragraph style attributes as seen in CONFIG.jsx, 
I opened the sample test document, then ran the following script:

var s = app.activeDocument.stories.item(0);
var p = s.paragraphs.item(0).appliedParagraphStyle;
for (var a in p) {
    $.writeln(a);
}

I then sorted the attribute names, and set them all to 0 to start with

For char styles: 

var s = app.activeDocument.stories.item(0);
var p = s.paragraphs.item(0).appliedCharacterStyle;
for (var a in p) {
    $.writeln(a);
}
