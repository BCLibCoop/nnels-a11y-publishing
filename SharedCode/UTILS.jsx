//
// UTILS.jsx - an ExtendScript shared module for Adobe InDesign
//
// v 1.0.0, March 23, 2019
// written by Kris Coppieters, kris@rorohiko.com
// https://www.linkedin.com/in/kristiaan/
//
// Commissioned by NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
//
// See License information at end of script.
//
// Check for source code at
//
// https://github.com/BCLibCoop/nnels-a11y-publishing
//
// ---------------
//
// About this module
//
// This module provides some additional utility functions for ExtendScript code
//

var UTILS;
if (DEBUG) {
    UTILS = undefined;
}
if (! UTILS) {
(function() {

// --

UTILS = {}; 

UTILS.REGEXP_EXTRACT_FUNCTION_NAME = /function (.{1,})\(/;
UTILS.REGEXP_SPACES = /\s/g;

UTILS.shortenedString = function(in_s, in_targetLength) {

    var retVal;

    LOG.logEntry("UTILS.shortenedString");

    try {
        if (in_s.length <= in_targetLength) {
            retVal = in_s;
        }
        else {
            var splitLen = Math.trunc((in_targetLen - 3) / 2);
            retVal = in_s.substr(0, splitLen) + "..." + in_s.substr(-splitLen);
        }
    }
    catch (err) {
        LOG.logError("UTILS.shortenedString: throws " + err);
    }

    LOG.logExit("UTILS.shortenedString");

    return retVal;
}

UTILS.baseName = function(in_filePath, in_separator) {
    
    var retVal = undefined;

    LOG.logEntry("UTILS.baseName");

    try {

        if (! in_separator) {
            in_separator = UTILS.SEPARATOR;
        }

        LOG.logNote("UTILS.baseName: using separator " + in_separator);

        // toString() handles cases where in_filePath is an ExtendScript File/Folder object
        var splitPath = in_filePath.toString().split(in_separator);
        do {
            var endSegment = splitPath.pop();   
        }
        while (splitPath.length > 0 && endSegment == "");

        retVal = endSegment;
    }
    catch (err) {
        LOG.logError("UTILS.baseName: throws " + err);
        retVal = undefined;
    }

    return retVal;
};

UTILS.checkMac = function() {
    var retVal = $.os.substr(0,3) == "Mac";
    return retVal;
};

UTILS.deepClone = function(in_obj) {

    var retVal = undefined;

    LOG.logEntry("UTILS.deepClone");

    try {
        if (in_obj instanceof Array) {
            retVal = [];
        }
        else {
            retVal = {};        
        }

        for (var x in in_obj) 
        {
            var val = in_obj[x];
            if (typeof val == "object")
            {
                retVal[x] = UTILS.deepClone(val);
            }
            else
            {
                retVal[x] = val;
            }
        }       
    }
    catch (err) {
        LOG.logError("UTILS.deepClone: throws " + err);
        retVal = undefined;
    }

    LOG.logExit("UTILS.deepClone");

    return retVal;
};

UTILS.despace = function(s) {
    var retVal = s.replace(UTILS.REGEXP_SPACES, "");
    return retVal;
};

UTILS.dirName = function(in_filePath, in_separator) {
    
    var retVal = undefined;

    LOG.logEntry("UTILS.dirName");

    try {

        if (! in_separator) {
            in_separator = UTILS.SEPARATOR;
        }

        LOG.logNote("UTILS.dirName: using in_separator " + in_separator);

        // toString() handles cases where in_filePath is an ExtendScript File/Folder object
        var splitPath = in_filePath.toString().split(in_separator);
        do {
            var endSegment = splitPath.pop();   
        }
        while (splitPath.length > 0 && endSegment == "");

        retVal = splitPath.join(in_separator) + in_separator;
    }
    catch (err) {
        LOG.logError("UTILS.dirName: throws " + err);            
    }
    
    LOG.logExit("UTILS.dirName");

    return retVal;
};

UTILS.dQ = function(in_s) {

    var retVal = '"' + in_s.replace(/\\/g,"\\\\").replace(/"/g,'\\"') + '"';
    return retVal;

};

UTILS.endsWith = function(in_s, in_end) {

    var retVal = in_s.substr(-in_end.length) == in_end;
    return retVal;

};

UTILS.exists = function(in_filePath) {
    var f = File(in_filePath);
    var retVal = f.exists;
    return retVal;
};

UTILS.fileNameExtension = function(in_filePath, in_separator) {

    var retVal = "";

    LOG.logEntry("UTILS.fileNameExtension");

    try {
        var splitName = UTILS.baseName(in_filePath, in_separator).split(".");
        if (splitName.length > 1) {
            retVal = splitName.pop();
            retVal = retVal.toLowerCase();
        }
    }
    catch (err) {
        LOG.logError("UTILS.fileNameExtension: throws " + err);            
    }
    
    LOG.logExit("UTILS.fileNameExtension");

    return retVal;
};

UTILS.getClassName = function(in_object) {

    var retVal;

    LOG.logEntry("UTILS.getClassName");

    do {
        try {
            if ("object" != typeof in_object) {
                LOG.logError("UTILS.getClassName: in_object is not an object");
                break;
            }

            if (! in_object) {
                LOG.logError("UTILS.getClassName: no in_object");
                break;
            }

            var match = UTILS.REGEXP_EXTRACT_FUNCTION_NAME.exec(in_object.constructor.toString());
            retVal = (match && match.length > 1) ? match[1] : "";
        }
        catch (err) {
            LOG.logError("UTILS.getClassName: throws " + err);            
        }
    }
    while (false);
    
    LOG.logExit("UTILS.getClassName");

    return retVal;
};

UTILS.hashCode = function(in_s) {

    LOG.logEntry("UTILS.hashCode");

    var hash = 0;

    do {

        try {

            if (! in_s.length) {
                break;
            }

            for (var i = 0; i < in_s.length; i++) {
                var chr = in_s.charCodeAt(i);
                hash = ((hash << 5) - hash) + chr;
                hash |= 0; // Convert to 32bit integer
            }            
        }
        catch (err) {
            LOG.logError("UTILS.hashCode: throws " + err);            
        }
    }
    while (false);

    LOG.logExit("UTILS.hashCode");

    return hash;
};

UTILS.isDir = function(in_folderPath) {
    
    // This casts to a File instead of a Folder if the
    // path references a file

    var folder = Folder(in_folderPath);
    var retVal = (folder instanceof Folder);

    return retVal;
};

UTILS.mkdir = function(in_folderPath, in_separator) {

    var success = false;

    do {
        try {
            if (! in_folderPath) {
                LOG.logError("UTILS.mkdir: no in_folderPath");
                break;
            }

            if (UTILS.exists(in_folderPath)) {
                success = true;
                break;
            }

            var parentFolderPath = UTILS.dirName(in_folderPath, in_separator);
            success = UTILS.mkdir(parentFolderPath, in_separator);
            if (! success) {
                LOG.logError("UTILS.mkdir: cannot create parent folder");
                break;
            }

            var folder = Folder(in_folderPath);
            folder.create();
            success = folder.exists;
        }
        catch (err) {
            LOG.logError("UTILS.mkdir throws" + err);       
        }
    }
    while (false);
    
    return success;
};

UTILS.shallowClone = function(in_obj) 
{
    var retVal = {};
    for (var x in in_obj) 
    {
        retVal[x] = in_obj[x];
    }

    return retVal;
}

UTILS.startsWith = function(in_s, in_start) {
    var retVal = in_s.substr(0, in_start.length) == in_start;
    return retVal;
};

UTILS.stripFileNameExtension = function(in_filePath, in_separator) {

    var retVal = in_filePath;
    
    do {
        try {

            var fileNameExtension = UTILS.fileNameExtension(in_filePath);
            if (! fileNameExtension) {
                break;
            }

            retVal = in_filePath.substr(0, in_filePath.length - fileNameExtension.length - 1);
        }
        catch (err) {
            LOG.logError("UTILS.stripFileNameExtension: throws " + err);
        }
    }
    while (false);

    return retVal;
}

if (UTILS.checkMac()) {
    UTILS.SEPARATOR = "/";
    UTILS.isMac = true;
    UTILS.isWindows = false;
}
else {
    UTILS.SEPARATOR = "\\";
    UTILS.isMac = false;
    UTILS.isWindows = true;
}

// --

})();}

/*************************************************************

UTILS.jsx

(c) 2019 NNELS, The National Network for Equitable Library Service
(formerly, CALS, The Canadian Accessible Library System)
https://nnels.ca

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

Neither the name of NNELS, nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.

==============================================
*/
