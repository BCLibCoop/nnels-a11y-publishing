#tag Window
Begin Window WndProgress
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "0"
   FullScreen      =   False
   HasBackColor    =   False
   HasCloseButton  =   False
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   90
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "DropToScript"
   Type            =   "7"
   Visible         =   False
   Width           =   364
   Begin ProgressBar PrgDropToScript
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Indeterminate   =   False
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Maximum         =   100
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      Top             =   50
      Transparent     =   False
      Value           =   0.0
      Visible         =   True
      Width           =   324
   End
   Begin Label LblProcessing
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Processing..."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Update(in_fileCount as integer, in_totalFileCount as Integer, in_selectedScript as FolderItem)
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      Dim ratio as Double
		      if in_totalFileCount > 0 then
		        ratio = 100 * in_fileCount / in_totalFileCount
		      else
		        ratio = 0
		      end if
		      
		      PrgDropToScript.Value = ratio
		      
		      if in_selectedScript <> nil and in_totalFileCount > 0 and in_fileCount < in_totalFileCount then
		        if not WndProgress.Visible then
		          WndProgress.Show
		        end if
		      else 
		        if WndProgress.Visible then
		          WndProgress.Hide
		        end if
		      end if
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

