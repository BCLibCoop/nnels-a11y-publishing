//
// LOG.jsx - an ExtendScript shared module for Adobe InDesign
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
// This module provides logging facilities for ExtendScript code
//

var LOG;
if (! LOG) {
(function() {

// --

LOG = {};	

LOG.LOG_NONE    = 0;
LOG.LOG_ERROR   = 1;
LOG.LOG_WARNING = 2;
LOG.LOG_NOTE    = 3;
LOG.LOG_TRACE   = 4;

LOG.LOG_TO_CONSOLE   = false;
LOG.LOG_LEVEL        = LOG.LOG_NONE;
LOG.LOG_ENTRY_EXIT   = false;
LOG.FILE_PATH_LOG    = undefined; // File path or undefined

LOG.logMessage = function(in_message) {

	if (! LOG.busyWriting) {
		LOG.busyWriting = true;
		try {
			if (LOG.LOG_TO_CONSOLE) {
				$.writeln(in_message);
			}
			if (LOG.FILE_PATH_LOG) {
				var f = File(LOG.FILE_PATH_LOG);
				f.open("a");
				f.writeln(in_message);
				f.close();
			}
		}
		catch (err) {		
		}
		LOG.busyWriting = false;
	}
	
};

LOG.logError = function(in_message) {
	if (LOG.LOG_LEVEL >= LOG.LOG_ERROR) {
		LOG.logMessage("ERROR: " + in_message);
	}
};

LOG.logWarning = function(in_message) {
	if (LOG.LOG_LEVEL >= LOG.LOG_WARNING) {
		LOG.logMessage("WARN : " + in_message);
	}
};

LOG.logNote = function(in_message) {
	if (LOG.LOG_LEVEL >= LOG.LOG_NOTE) {
		LOG.logMessage("NOTE : " + in_message);
	}
};

LOG.logTrace = function(in_message) {
	if (LOG.LOG_LEVEL >= LOG.LOG_TRACE) {
		LOG.logMessage("TRACE: " + in_message);
	}
};

LOG.logEntry = function(in_functionName) {
	if (LOG.LOG_ENTRY_EXIT) {
		LOG.logTrace("ENTRY: " + in_functionName);
	}
};

LOG.logExit = function(in_functionName) {
	if (LOG.LOG_ENTRY_EXIT) {
		LOG.logTrace("EXIT : " + in_functionName);
	}
};


// --

})();}

/*************************************************************

LOG.jsx

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
