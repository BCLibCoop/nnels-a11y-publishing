//
// StyleCleanup.jsx - a script for Adobe InDesign
//
// v 1.0.2, April 11, 2019
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

// The makeReleaseVersion.command script will replace this to "CONFIG.jsx" instead of "CONFIG_debug.jsx"
#include "CONFIG_debug.jsx"
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

