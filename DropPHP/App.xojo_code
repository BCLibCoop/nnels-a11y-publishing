#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  App_Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  App_OpenDocument item
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub App_Open()
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
		      Log.LogError CurrentMethodName, "Throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub App_OpenDocument(in_file as FolderItem)
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
		    Log.LogError CurrentMethodName, "Throws " + e.Message
		  End Try
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FinalizeStartup()
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
		      success = Init
		      if not success then
		        Exit
		      end if
		      
		      if fSelectedPlugin <> nil and UBound(fDocumentQueue) >= 0 then
		        for idx as integer = 0 to UBound(fDocumentQueue)
		          Dim droppedFile as FolderItem
		          droppedFile = fDocumentQueue(idx)
		          HandleDroppedFile droppedFile
		        next
		        Quit
		      else
		        WndMain.Show
		      end if
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "Throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleDroppedFile(in_file as FolderItem)
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
		      
		      Dim tis As TextInputStream
		      tis = TextInputStream.Open(fSelectedPlugin)
		      If tis = Nil Then
		        Log.LogError CurrentMethodName, "Cannot open PHP plugin file"
		        Exit
		      End If
		      
		      Dim phpScript As String
		      phpScript = tis.ReadAll
		      
		      tis.close
		      
		      Dim scriptFolderItem As FolderItem
		      scriptFolderItem = SpecialFolder.Temporary.Child(Cfg.FILE_NAME_TEMP_SCRIPT)
		      
		      Dim tos As TextOutputStream
		      tos = TextOutputStream.Create(scriptFolderItem)
		      tos.Write phpScript
		      tos.close
		      
		      Dim phpProgramFolderItem as FolderItem
		      #if TargetWindows
		        phpProgramFolderItem = SpecialFolder.Home.Child("php").Child("php.exe")
		      #else
		        phpProgramFolderItem = GetFolderItem("/usr/bin/php", FolderItem.PathTypeShell)
		      #endif
		      
		      Dim commandLine as String
		      commandLine = phpProgramFolderItem.ShellPath + " " + scriptFolderItem.ShellPath + " " + in_file.ShellPath
		      
		      Dim sh as Shell
		      sh = new Shell
		      sh.Execute commandLine
		      
		      if sh.ErrorCode <> 0 then
		        Log.LogError CurrentMethodName, "Failed to run PHP script: ErrorCode = " + Str(sh.ErrorCode)
		      End If
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "Throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Sub
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
		      
		      Dim appFolder As FolderItem
		      appFolder = GetFolderItem("")
		      If appFolder = Nil Or Not appFolder.Exists Or Not appFolder.Directory Then
		        Log.LogError CurrentMethodName, "App cannot locate its own folder"
		        Exit
		      End If
		      
		      fPluginsFolder = appFolder.Child(Cfg.FOLDER_NAME_PLUGINS)
		      If fPluginsFolder = Nil Or Not fPluginsFolder.Exists Or Not fPluginsFolder.Directory Then
		        Log.LogError CurrentMethodName, "Cannot locate plugins folder"
		        Exit
		      End If
		      
		      Redim fPluginList(-1)
		      
		      Dim numFiles as integer
		      numFiles = fPluginsFolder.Count
		      for idx as integer = 1 to numFiles
		        Dim pluginFile as FolderItem
		        pluginFile = fPluginsFolder.TrueItem(idx)
		        if pluginFile <> nil and pluginFile.Exists and not pluginFile.Directory then
		          Dim extension as String
		          extension = GetFileNameExtension(pluginFile.name)
		          if extension = "php" then
		            fPluginList.append pluginFile
		          end if
		        end if
		      next
		      
		      if UBound(fPluginList) = 0 then
		        fSelectedPlugin = fPluginList(0)
		      end if
		      
		      fInitialized = true
		      success = True
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "Throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Return success
		End Function
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
		Private fPHPMBS As PHPMBS
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fPluginList() As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fPluginsFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fSelectedPlugin As FolderItem
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
