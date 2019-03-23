//
// StyleCleanup.jsx - a script for Adobe InDesign
//
// v 1.0.0, March 23, 2019
// written by Kris Coppieters, kris@rorohiko.com
// https://www.linkedin.com/in/kristiaan/
//
// Commissioned by NNELS (National Network for Equitable Library Service/The Canadian Accessible Library System)
//
// See License information at end of script.
//
// Check for updated versions at
//
// https://github.com/BCLibCoop/nnels-a11y-publishing
//
// ---------------
//
// About this script:
//
// This script will scan an InDesign document and find any manual text style overriddes
// Manual text style overrides are not easy to spot or clean up. 
//
// This script will help removing or restructuring these manual overrides.
//
// For each manual style override, the script will create a new paragraph or character
// style. Once all manual overrides have been converted to styles, the user can 
// then delete, rename, remap,... all these styles and clean up the document.
//

#targetengine "ca.nnels.indesignscripts.stylecleanup"

#include "CONFIG.jsx"
#include "../../SharedCode/LOG.jsx"
#include "../../SharedCode/UTILS.jsx"
#include "STYC.jsx"
#include "SETUP.jsx"

// ----

if (DEBUG) {
  STYC.main();
}
else {
  // Running the non-debug version is wrapped into a single Undo for the user.
  app.doScript("STYC.main()", ScriptLanguage.JAVASCRIPT, [], UndoModes.ENTIRE_SCRIPT);
}

/*************************************************************

StyleCleanup.jsx

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

