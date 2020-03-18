#tag Window
Begin Window WndPrefs
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   270
   ImplicitInstance=   True
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   33992703
   MenuBarVisible  =   True
   MinHeight       =   270
   MinimizeButton  =   False
   MinWidth        =   600
   Placement       =   0
   Resizeable      =   True
   Title           =   "DropToScript Preferences"
   Visible         =   False
   Width           =   600
   Begin Label LblSystemPaths
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
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "System Paths:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   64
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label LblDefaultScript
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
      Scope           =   2
      Selectable      =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Default Script:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   21
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin PopupMenu PupScript
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   132
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   448
   End
   Begin PushButton BtnOK
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   500
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton BtnCancel
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   408
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Listbox LstScriptInterpreterPaths
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "80,,100"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   0
      Height          =   137
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Ext	Path	 "
      Italic          =   False
      Left            =   132
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   64
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   448
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin BevelButton BtnAddPath
      AcceptFocus     =   True
      AutoDeactivate  =   True
      BackColor       =   &c00000000
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   "+"
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   22
      HelpTag         =   ""
      Icon            =   0
      IconAlign       =   0
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   132
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MenuValue       =   "0"
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   202
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   26
   End
   Begin BevelButton BtnRemovePath
      AcceptFocus     =   True
      AutoDeactivate  =   True
      BackColor       =   &c00000000
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   "-"
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   False
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   22
      HelpTag         =   ""
      Icon            =   0
      IconAlign       =   0
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   158
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MenuValue       =   "0"
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   202
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   26
   End
   Begin Label LblLogLevel
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
      Scope           =   2
      Selectable      =   False
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Log Level:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   230
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin PopupMenu PupLogLevel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   132
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   229
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   124
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Sub Action_BtnAddPath()
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
		      
		      LstScriptInterpreterPaths.AddRow "???"
		      LstScriptInterpreterPaths.Cell(LstScriptInterpreterPaths.ListCount - 1, 2) = Cfg.EDIT_SYMBOL
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Action_BtnCancel()
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
		      
		      Hide
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Action_BtnOK()
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
		      
		      Dim success as Boolean
		      success = SavePrefs
		      if not success then
		        Log.LogError CurrentMethodName, "failed to save prefs"
		      end if
		      
		      Hide
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Action_BtnRemovePath()
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
		      
		      if LstScriptInterpreterPaths.ListIndex < 0 or LstScriptInterpreterPaths.ListIndex >= LstScriptInterpreterPaths.ListCount then
		        Log.logError CurrentMethodName, "invalid ListIndex"
		        Exit
		      end if
		      
		      LstScriptInterpreterPaths.RemoveRow LstScriptInterpreterPaths.ListIndex
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CellClick_LstScriptInterpreterPaths(in_row as integer, in_col as integer) As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as Boolean
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      if in_col <> 2 then
		        Exit
		      end if
		      
		      if in_row < 0 or in_row >= LstScriptInterpreterPaths.ListCount then
		        Exit
		      end if
		      
		      Dim extension as String
		      extension = Trim(LstScriptInterpreterPaths.Cell(in_row, 0))
		      
		      Dim selectedFile as FolderItem
		      
		      Dim selectFileDialolg As OpenDialog
		      selectFileDialolg = New OpenDialog
		      #If TargetWindows Then
		        selectFileDialolg.InitialDirectory = SpecialFolder.Applications
		      #Else   // open Home directory on linux
		        selectFileDialolg.InitialDirectory = GetFolderItem("/usr/bin", FolderItem.PathTypeShell)
		      #Endif
		      
		      selectFileDialolg.Title = "Select a script interpreter"
		      selectFileDialolg.Filter = FileTypes1.Any //Defined as file type in FileTypes1.
		      
		      selectedFile = selectFileDialolg.ShowModal
		      If selectedFile <> Nil Then
		        LstScriptInterpreterPaths.Cell(in_row, 1) = selectedFile.NativePath
		      End If
		      
		      retVal = true
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return retVal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Change_LstScriptInterpreterPaths()
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
		      
		      UpdateUI
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EditPrefs() As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Dim success as Boolean
		  
		  Do 
		    
		    Try
		      
		      success = Init
		      if not success then
		        Log.LogError CurrentMethodName, "failed to initialize"
		        Exit
		      end if
		      
		      ShowModal
		      
		      success = true
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return success
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Init() As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim success as Boolean
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      PupLogLevel.AddRow "None"
		      PupLogLevel.AddRow "Error"
		      PupLogLevel.AddRow "Warning"
		      PupLogLevel.AddRow "Note"
		      PupLogLevel.AddRow "Trace"
		      
		      Dim prefs as CPrefs
		      prefs = App.GetPrefs
		      if prefs = nil then
		        Log.LogError CurrentMethodName, "prefs is nil"
		        Exit
		      end if
		      
		      PupLogLevel.ListIndex = prefs.GetPrefsLogLevel
		      
		      Dim defaultScriptName as String
		      defaultScriptName = prefs.GetDefaultScriptName
		      
		      success = InitPupScripts(defaultScriptName)
		      if not success then
		        Log.LogError CurrentMethodName, "failed to init scripts"
		        Exit
		      end if
		      
		      success = InitScriptInterpreterPaths
		      if not success then
		        Log.LogError CurrentMethodName, "failed to init interpreter paths"
		        Exit
		      end if
		      
		      success = true
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return success
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InitPupScripts(in_defaultScriptName as String) As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim success as Boolean
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      Dim scriptCollection as CScriptCollection
		      scriptCollection = App.GetScriptCollection
		      if scriptCollection = nil then
		        Log.LogError CurrentMethodName, "scriptCollection is nil"
		        Exit
		      end if
		      
		      PupScript.DeleteAllRows
		      
		      Dim numScripts as integer
		      numScripts = scriptCollection.GetNumScripts
		      if numScripts = 0 then
		        Log.LogError CurrentMethodName, "no scripts"
		        Exit
		      end if
		      
		      Dim maxScriptIdx as integer
		      maxScriptIdx = numScripts - 1
		      
		      PupScript.AddRow "- None -"
		      PupScript.RowTag(0) = nil
		      
		      Dim selectedIdx as integer
		      selectedIdx = 0
		      
		      for idx as integer = 0 to maxScriptIdx
		        Dim scriptFile as FolderItem
		        scriptFile = scriptCollection.GetScriptByIdx(idx)
		        if scriptFile <> nil then
		          Dim scriptName as String
		          scriptName = scriptFile.name
		          Dim scriptIdx as Integer
		          scriptIdx = PupScript.ListCount
		          PupScript.AddRow scriptName
		          PupScript.RowTag(scriptIdx) = scriptFile 
		          if scriptName = in_defaultScriptName then
		            selectedIdx = scriptIdx
		          end if
		        end if
		      next
		      
		      PupScript.ListIndex = selectedIdx
		      
		      success = true
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return success
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InitScriptInterpreterPaths() As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim success as Boolean
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      Dim prefs as CPrefs
		      prefs = App.GetPrefs
		      if prefs = nil then
		        Log.LogError CurrentMethodName, "prefs is nil"
		        Exit
		      end if
		      
		      LstScriptInterpreterPaths.DeleteAllRows
		      LstScriptInterpreterPaths.TextSize = 10
		      LstScriptInterpreterPaths.DefaultRowHeight = 20
		      LstScriptInterpreterPaths.ColumnType(0) = ListBox.TypeEditableTextField
		      LstScriptInterpreterPaths.ColumnType(1) = ListBox.TypeEditableTextField
		      
		      Dim numScriptsInterpreters as integer
		      numScriptsInterpreters = prefs.GetScriptInterpreterCount
		      
		      Dim maxScriptInterpreterIdx as integer
		      maxScriptInterpreterIdx = numScriptsInterpreters - 1
		      
		      for idx as integer = 0 to maxScriptInterpreterIdx
		        
		        Dim extension as String
		        extension = prefs.GetExtensionByIdx(idx)
		        
		        Dim scriptInterpreterPath as String
		        scriptInterpreterPath = prefs.GetScriptInterpreterPathByIdx(idx)
		        
		        LstScriptInterpreterPaths.AddRow extension
		        LstScriptInterpreterPaths.Cell(idx, 1) = scriptInterpreterPath
		        
		        LstScriptInterpreterPaths.Cell(idx, 2) = Cfg.EDIT_SYMBOL
		      next
		      
		      success = true
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return success
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SavePrefs() As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim success as Boolean
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      Dim prefs as CPrefs
		      prefs = App.GetPrefs
		      if prefs = nil then
		        Log.LogError CurrentMethodName, "prefs = nil"
		        Exit
		      end if
		      
		      Dim maxExtensionIdx as integer
		      maxExtensionIdx = prefs.GetScriptInterpreterCount - 1
		      
		      Dim extensionsSeen as Dictionary
		      extensionsSeen = new Dictionary
		      
		      for idx as integer = 0 to maxExtensionIdx
		        Dim extension as String
		        extension = prefs.GetExtensionByIdx(idx)
		        if extension <> "" then
		          extensionsSeen.Value(extension) = false
		        end if
		      next
		      
		      Dim defaultScriptName as String
		      if PupScript.ListIndex >= 0 then
		        Dim selectedScriptFile as FolderItem
		        selectedScriptFile = PupScript.RowTag(PupScript.ListIndex)
		        if selectedScriptFile <> nil and selectedScriptFile.Exists then
		          defaultScriptName = selectedScriptFile.Name
		        end if
		      end if
		      
		      Dim logLevel as integer
		      logLevel = PupLogLevel.ListIndex
		      
		      success = prefs.SetPrefsLogLevel(logLevel)
		      if not success then
		        Log.LogError CurrentMethodName, "failed to set log level"
		        Exit
		      end if
		      
		      success = prefs.SetDefaultScriptName(defaultScriptName)
		      if not success then
		        Log.LogError CurrentMethodName, "failed to set default script name"
		        Exit
		      end if
		      
		      Dim maxIdx as integer 
		      maxIdx = LstScriptInterpreterPaths.ListCount - 1
		      for idx as integer = 0 to maxIdx
		        
		        dim extension as String
		        extension = Trim(LstScriptInterpreterPaths.Cell(idx,0))
		        
		        dim scriptInterpreterPath as String
		        scriptInterpreterPath = Trim(LstScriptInterpreterPaths.Cell(idx,1))
		        
		        extensionsSeen.Value(extension) = true
		        success = prefs.SetScriptInterpreterPath(extension, scriptInterpreterPath) and success
		        
		      next
		      
		      for idx as integer = 0 to maxExtensionIdx
		        Dim extension as String
		        extension = prefs.GetExtensionByIdx(idx)
		        if not extensionsSeen.Value(extension) then
		          success = prefs.SetScriptInterpreterPath(extension, "") and success
		        end if
		      next
		      
		      if not success then
		        Log.LogError CurrentMethodName, "failed to set script interpreter paths"
		        Exit
		      end if
		      
		      success = prefs.SavePrefs
		      if not success then
		        Log.LogError CurrentMethodName, "failed to save prefs"
		        Exit
		      end if
		      
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return success
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
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
		      
		      if LstScriptInterpreterPaths.ListIndex >= 0 then
		        BtnRemovePath.Enabled = true
		      else
		        BtnRemovePath.Enabled = false
		      end if
		      
		      PupLogLevel.ListIndex = Log.GetLogLevel
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events BtnOK
	#tag Event
		Sub Action()
		  Action_BtnOK
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BtnCancel
	#tag Event
		Sub Action()
		  Action_BtnCancel
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LstScriptInterpreterPaths
	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  return CellClick_LstScriptInterpreterPaths(row, column)
		End Function
	#tag EndEvent
	#tag Event
		Sub Change()
		  Change_LstScriptInterpreterPaths
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BtnAddPath
	#tag Event
		Sub Action()
		  Action_BtnAddPath
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BtnRemovePath
	#tag Event
		Sub Action()
		  Action_BtnRemovePath
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
