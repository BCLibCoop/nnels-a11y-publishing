#tag Class
Protected Class CScriptCollection
	#tag Method, Flags = &h21
		Private Sub Constructor()
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
		Shared Function Factory() As CScriptCollection
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
		      
		      if fInitialized then
		        retVal = fSingleton
		        Exit
		      end if
		      
		      fInitialized = true
		      
		      Dim scriptCollection as CScriptCollection
		      scriptCollection = new CScriptCollection
		      
		      Dim success as Boolean
		      success = scriptCollection.ScanScripts
		      if not success then
		        Log.LogError CurrentMethodName, "failed to scan scripts"
		        Exit
		      end if
		      
		      fSingleton = scriptCollection
		      retVal = fSingleton
		      
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
		Function GetNumScripts() As Integer
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as Integer
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      retVal = UBound(fScriptList) + 1
		      
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
		Function GetScriptByIdx(in_idx as Integer) As FolderItem
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
		      
		      if in_idx < 0 or in_idx > UBound(fScriptList) then
		        Log.LogError CurrentMethodName, "in_idx out of range"
		        Exit
		      end if
		      
		      retVal = fScriptList(in_idx)
		      
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
		Function GetScriptByName(in_scriptName as String) As FolderItem
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
		      
		      if in_scriptName = "" then
		        Exit
		      end if
		      
		      Dim idx as integer
		      idx = 0
		      
		      while idx <= UBound(fScriptList) and retVal = nil
		        retVal = fScriptList(idx)
		        idx = idx + 1
		        if retVal.Name <> in_scriptName then
		          retVal = nil
		        end if
		      wend
		      
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
		Function IsValidScriptName(in_scriptName as String) As Boolean
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
		      
		      Dim found as Boolean
		      Dim idx as integer
		      while not found and idx <= UBound(fScriptList)
		        
		        Dim script as FolderItem
		        script = fScriptList(idx)
		        idx = idx + 1
		        
		        found = script.Name = in_scriptName
		      wend
		      
		      retVal = found
		      
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
		Private Function ScanScripts() As Boolean
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
		      
		      Dim prefs as CPrefs
		      prefs = App.GetPrefs
		      if prefs = nil then
		        Log.LogError CurrentMethodName, "prefs is nil"
		        Exit
		      end if
		      
		      Dim appFolder As FolderItem
		      appFolder = GetFolderItem("")
		      If appFolder = Nil Or Not appFolder.Exists Or Not appFolder.Directory Then
		        Log.LogError CurrentMethodName, "app cannot locate its own folder"
		        Exit
		      End If
		      
		      do
		        fScriptsFolder = appFolder.Child(Cfg.FOLDER_NAME_PLUGINS)
		        If fScriptsFolder <> Nil and (Not fScriptsFolder.Exists Or Not fScriptsFolder.Directory) Then
		          appFolder = appFolder.Parent
		        End If
		      Loop until appFolder = Nil or (fScriptsFolder.Exists and fScriptsFolder.Directory)
		      
		      If fScriptsFolder = Nil Or Not fScriptsFolder.Exists Or Not fScriptsFolder.Directory Then
		        Log.LogError CurrentMethodName, "cannot locate DropScripts folder"
		        Exit
		      End If
		      
		      Redim fScriptList(-1)
		      
		      Dim numFiles as integer
		      numFiles = fScriptsFolder.Count
		      
		      for idx as integer = 1 to numFiles
		        Dim scriptFile as FolderItem
		        scriptFile = fScriptsFolder.TrueItem(idx)
		        if scriptFile <> nil and scriptFile.Exists and not scriptFile.Directory then
		          Dim extension as String
		          extension = Utils.GetFileNameExtension(scriptFile.name)
		          if prefs.GetScriptInterpreterPathByExtension(extension) <> "" then 
		            fScriptList.append scriptFile
		          end if
		        end if
		        
		        #if DebugBuild
		          
		          // Also scan a source DropToScript folder in git repo when debugging
		          
		          if scriptFile <> nil and scriptFile.Exists and scriptFile.Directory then
		            Dim numSubFiles as integer
		            numSubFiles = scriptFile.Count
		            for subIdx as integer = 1 to numSubFiles
		              Dim subScriptFile as FolderItem
		              subScriptFile = scriptFile.TrueItem(subIdx)
		              if subScriptFile <> nil and subScriptFile.Exists and not subScriptFile.Directory then
		                Dim extension as String
		                extension = Utils.GetFileNameExtension(subScriptFile.name)
		                if prefs.GetScriptInterpreterPathByExtension(extension) <> "" then 
		                  fScriptList.append subScriptFile
		                end if
		              end if
		            next
		          end if
		          
		        #endif
		        
		      next
		      
		      success = true
		      
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


	#tag Property, Flags = &h21
		Private Shared fInitialized As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fScriptList() As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fScriptsFolder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared fSingleton As CScriptCollection
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
