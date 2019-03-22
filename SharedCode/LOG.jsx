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

(c) 2019 NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
https://nnels.ca/

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of NNELS, nor the names of its contributors
  may be used to endorse or promote products derived from this software without
  specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.

==============================================
*/
