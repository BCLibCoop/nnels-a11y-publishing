#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  Open_App
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  Open_AppDocument item
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function FinalizeStartup() As Boolean
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
		      
		      success = Init
		      if not success then
		        Exit
		      end if
		      
		      if fSelectedScript <> nil and UBound(fDocumentQueue) >= 0 then
		        success = true
		        for idx as integer = 0 to UBound(fDocumentQueue)
		          Dim droppedFile as FolderItem
		          droppedFile = fDocumentQueue(idx)
		          success = HandleDroppedFile(droppedFile) and success
		        next
		        Quit
		        Exit
		      end if
		      
		      if UBound(fDocumentQueue) < 0 then
		        success = WndPrefs.EditPrefs
		        if not success then
		          Log.LogError CurrentMethodName, "failed to manage prefs"
		        end if
		        Quit
		        Exit
		      end if
		      
		      fSelectedScript = WndSelectScript.ChooseScript
		      success = true
		      if fSelectedScript <> nil then
		        for idx as integer = 0 to UBound(fDocumentQueue)
		          Dim droppedFile as FolderItem
		          droppedFile = fDocumentQueue(idx)
		          success = HandleDroppedFile(droppedFile) and success
		        next
		      end if
		      
		      if not success then
		        Log.LogError CurrentMethodName, "failed to handle all dropped files"
		      end if
		      
		      Quit
		      
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

	#tag Method, Flags = &h0
		Function GetPrefs() As CPrefs
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as CPrefs
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      retVal = fPrefs
		      
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
		Private Function GetPrefsFile() As FolderItem
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as FolderItem
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      Dim prefsFile as FolderItem
		      prefsFile = SpecialFolder.ApplicationData
		      if prefsFile = nil or not prefsFile.Exists or not prefsFile.Directory then
		        Log.LogError CurrentMethodName, "ApplicationData not a directory"
		        Exit
		      end if
		      
		      prefsFile = prefsFile.Child(Cfg.COMPANY_FOLDER_NAME)
		      if prefsFile = nil then
		        Log.LogError CurrentMethodName, "ApplicationData subdir = nil"
		        Exit
		      end if
		      
		      if not prefsFile.Exists then
		        prefsFile.CreateAsFolder
		      end if
		      
		      if not prefsFile.Exists then
		        Log.LogError CurrentMethodName, "cannot create directory"
		        Exit
		      end if
		      
		      prefsFile = prefsFile.Child(Cfg.FILE_NAME_PREFS)
		      if prefsFile = nil then
		        Log.LogError CurrentMethodName, "prefsFile = nil"
		        Exit
		      end if
		      
		      retVal = prefsFile
		      
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

	#tag Method, Flags = &h0
		Function GetScriptCollection() As CScriptCollection
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as CScriptCollection
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      retVal = fScriptCollection
		      
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
		Private Function HandleDroppedFile(in_file as FolderItem) As Boolean
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
		      
		      if in_file = nil then
		        Log.LogError CurrentMethodName, "in_file is nil"
		        Exit
		      end if
		      
		      if not in_file.Exists then
		        Log.LogError CurrentMethodName, "in_file does not exist"
		        Exit
		      end if
		      
		      if fPrefs = nil then
		        Log.LogError CurrentMethodName, "fPrefs is nil"
		        Exit
		      end if
		      
		      if fSelectedScript = nil then
		        Log.LogError CurrentMethodName, "fSelectedScript is nil"
		        Exit
		      end if
		      
		      if not fSelectedScript.Exists then
		        Log.LogError CurrentMethodName, "fSelectedScript does not exist"
		        Exit
		      end if
		      
		      Dim extension as String
		      extension = Utils.GetFileNameExtension(fSelectedScript.Name)
		      
		      Dim scriptInterpreterPath as String
		      scriptInterpreterPath = fPrefs.GetScriptInterpreterPathByExtension(extension)
		      
		      if scriptInterpreterPath = "" then
		        Log.LogError CurrentMethodName, "no interpreter for extension " + extension
		        Exit
		      end if
		      
		      Dim commandLine as String
		      commandLine = scriptInterpreterPath + " " + fSelectedScript.ShellPath + " " + in_file.ShellPath
		      
		      Dim sh as Shell
		      sh = new Shell
		      sh.Execute commandLine
		      
		      if sh.ErrorCode <> 0 then
		        Log.LogError CurrentMethodName, "failed to run script: ErrorCode = " + Str(sh.ErrorCode)
		        Exit
		      End If
		      
		      Dim output as String
		      output = Trim(sh.ReadAll)
		      if output <> "" then
		        MsgBox output
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
		Private Function Init() As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Dim success As Boolean
		  
		  Do 
		    
		    Try
		      
		      if fInitialized then
		        success = true
		        Exit
		      end if
		      
		      Dim prefsFile as FolderItem
		      prefsFile = GetPrefsFile
		      
		      fPrefs = CPrefs.Factory(prefsFile)
		      if fPrefs = nil then
		        Exit
		      end if
		      
		      fScriptCollection = CScriptCollection.Factory
		      if fScriptCollection = nil then
		        Exit
		      end if
		      
		      if fScriptCollection.GetNumScripts = 1 then
		        fSelectedScript = fScriptCollection.GetScriptByIdx(0)
		      else
		        fSelectedScript = fScriptCollection.GetScriptByName(fPrefs.GetDefaultScriptName)
		      end if
		      
		      fInitialized = true
		      success = True
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Return success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Open_App()
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
		      
		      Log.SetLogLevel Log.WARNING
		      
		      fFinalizeStartupTimer = new CFinalizeStartupTimer
		      fFinalizeStartupTimer.Period = 1000
		      fFinalizeStartupTimer.Mode = Timer.ModeSingle
		      
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
		Private Sub Open_AppDocument(in_file as FolderItem)
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Try
		    
		    fDocumentQueue.Append in_file
		    
		    if fFinalizeStartupTimer <> nil then
		      fFinalizeStartupTimer.Mode = Timer.ModeOff
		      fFinalizeStartupTimer.Mode = Timer.ModeSingle
		    end if
		    
		  Catch e As RuntimeException
		    Log.LogError CurrentMethodName, "throws " + e.Message
		  End Try
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private fDocumentQueue() As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fFinalizeStartupTimer As CFinalizeStartupTimer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fInitialized As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fPrefs As CPrefs
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fScriptCollection As CScriptCollection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fSelectedScript As FolderItem
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
