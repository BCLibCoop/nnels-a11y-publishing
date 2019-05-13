#tag Class
Protected Class CPrefs
	#tag Method, Flags = &h21
		Private Sub Constructor(in_prefsFile as FolderItem)
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
		      
		      fLogLevel = 0
		      fDefaultScriptName = ""
		      fTargetFileNameExtensions = kDefaultTargetFileNameExtensions
		      fDirty = false
		      fPrefsFile = in_prefsFile
		      Redim fScriptFileNameExtensions(-1)
		      fScriptInterpreterPathsByExtension = new Dictionary
		      
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
		Shared Function Factory(in_prefsFile as FolderItem) As CPrefs
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
		      
		      if in_prefsFile = nil then
		        Log.LogError CurrentMethodName, "in_prefsFile = nil"
		        Exit
		      end if
		      
		      Dim prefs as CPrefs
		      prefs = new CPrefs(in_prefsFile)
		      
		      Dim success as Boolean
		      success = prefs.ReloadPrefs
		      if not success then
		        Log.LogError CurrentMethodName, "failed to load prefs"
		        Exit
		      end if
		      
		      retVal = prefs
		      
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
		Private Function GetDefaultScriptInterpreterPath(in_extension as String) As String
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as String
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      #if TargetMacOS
		        if in_extension = "command" then
		          retVal = "/bin/bash -C"
		          Exit
		        end if
		        
		        if in_extension = "php" then
		          retVal = "/usr/bin/php"
		          Exit
		        end if
		        
		        if in_extension = "py" then
		          retVal = "/usr/bin/python"
		          Exit
		        end if
		      #endif
		      
		      #if TargetLinux
		        if in_extension = "command" then
		          retVal = "/bin/bash -C"
		          Exit
		        end if
		        
		        if in_extension = "php" then
		          retVal = "/usr/bin/php"
		          Exit
		        end if
		        
		        if in_extension = "py" then
		          retVal = "/usr/bin/python"
		          Exit
		        end if
		      #endif
		      
		      #if TargetWindows
		        if in_extension = "bat" then
		          retVal = "cmd.exe"
		          Exit
		        end if
		        
		        if in_extension = "php" then
		          retVal = "php.exe"
		          Exit
		        end if
		        
		        if in_extension = "py" then
		          retVal = "python.exe"
		          Exit
		        end if
		      #endif
		      
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
		Function GetDefaultScriptName() As String
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as String
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      retVal = fDefaultScriptName
		      
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
		Function GetExtensionByIdx(in_idx as integer) As String
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as String
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      if in_idx < 0 or in_idx > UBound(fScriptFileNameExtensions) then
		        Log.LogError CurrentMethodName, "in_idx out of bounds " + str(in_idx)
		        Exit
		      end if
		      
		      Dim extension as String
		      extension = Trim(fScriptFileNameExtensions(in_idx))
		      
		      if extension = "" then
		        Log.LogError CurrentMethodName, "empty extension"
		        Exit
		      end if
		      
		      retVal = extension
		      
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
		Function GetPrefsLogLevel() As Integer
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
		      
		      retVal = fLogLevel
		      
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
		Function GetScriptInterpreterCount() As Integer
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as integer
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      retVal = UBound(fScriptFileNameExtensions) + 1
		      
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
		Function GetScriptInterpreterPathByExtension(in_extension as String) As String
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as String
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      if fScriptInterpreterPathsByExtension = nil then
		        Log.LogError CurrentMethodName, "fScriptInterpreterPathsByExtension = nil"
		        Exit
		      end if
		      
		      Dim extension as String
		      extension = Trim(in_extension)
		      
		      if extension = "" then
		        Log.LogError CurrentMethodName, "empty extension"
		        Exit
		      end if
		      
		      if not fScriptInterpreterPathsByExtension.HasKey(extension) then
		        Log.LogNote CurrentMethodName, "unlisted extension '" + extension + "'"
		        Exit
		      end if
		      
		      return fScriptInterpreterPathsByExtension.Value(extension)
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetScriptInterpreterPathByIdx(in_idx as integer) As String
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as String
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      Dim extension as String
		      extension = GetExtensionByIdx(in_idx)
		      if extension = "" then
		        Log.LogError CurrentMethodName, "empty extension"
		        Exit
		      end if
		      
		      if not fScriptInterpreterPathsByExtension.HasKey(extension) then
		        Log.LogError CurrentMethodName, "invalid extension " + extension
		        Exit
		      end if
		      
		      retVal = fScriptInterpreterPathsByExtension.Value(extension)
		      
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
		Function GetTargetFileNameExtensionDict() As Dictionary
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim retVal as Dictionary
		  retVal = new Dictionary
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      Dim extensions() as String
		      extensions = fTargetFileNameExtensions.Split(".")
		      
		      for each extension as String in extensions
		        retVal.Value(extension) = true
		      next
		      
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
		Function ReloadPrefs() As Boolean
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
		      
		      fDirty = false
		      
		      if fPrefsFile = nil then
		        Log.LogError CurrentMethodName, "fPrefsFile is nil"
		        Exit
		      end if
		      
		      fDefaultScriptName = ""
		      fScriptInterpreterPathsByExtension = new Dictionary
		      
		      success = true
		      
		      Dim extensions() as String
		      extensions = Cfg.SCRIPT_FILENAME_EXTENSION_LISTS.Split(".")
		      
		      for idx as integer = 0 to UBound(extensions)
		        
		        Dim extension as String
		        extension = Trim(extensions(idx))
		        if extension <> "" then
		          
		          Dim scriptInterpreterPath as String
		          scriptInterpreterPath = GetDefaultScriptInterpreterPath(extension)
		          
		          if scriptInterpreterPath <> "" then
		            
		            if not fScriptInterpreterPathsByExtension.HasKey(extension) then
		              fScriptFileNameExtensions.Append extension
		              fScriptInterpreterPathsByExtension.Value(extension) = scriptInterpreterPath
		            end if
		            
		          end if
		        end if
		      next
		      
		      if not fPrefsFile.Exists then
		        Log.LogNote CurrentMethodName, "fPrefsFile does not exist"
		        Exit
		      end if
		      
		      Dim tis as TextInputStream
		      tis = TextInputStream.Open(fPrefsFile)
		      if tis = nil then
		        Log.LogError CurrentMethodName, "tis = nil"
		        success = false
		        Exit
		      end if
		      
		      fDefaultScriptName = tis.ReadLine
		      
		      Dim outOfBandLineIdx as integer
		      
		      while not tis.EOF
		        
		        Dim line as String
		        line = tis.ReadLine
		        
		        // Prefix out-of-band lines with ".."
		        if left(line, Len(kOutOfBandPrefix)) = kOutOfBandPrefix then
		          
		          line = Mid(line, Len(kOutOfBandPrefix) + 1)
		          
		          if outOfBandLineIdx = 0 then
		            fTargetFileNameExtensions = line
		          elseif outOfBandLineIdx = 1 then
		            fLogLevel = Val(line)
		          end if
		          
		          outOfBandLineIdx = outOfBandLineIdx + 1
		          
		        else
		          
		          Dim lineSplit() as String
		          lineSplit = line.split(".")
		          
		          Dim lineExtension as String
		          lineExtension = lineSplit(0)
		          
		          Dim lineScriptInterpreterPath as String
		          lineScriptInterpreterPath = Trim(Mid(line, Len(lineExtension) + 2))
		          
		          lineExtension = Trim(lineExtension)
		          
		          if lineScriptInterpreterPath <> "" and lineExtension <> "" then
		            
		            if not fScriptInterpreterPathsByExtension.HasKey(lineExtension) then
		              fScriptFileNameExtensions.Append lineExtension
		            end if
		            
		            fScriptInterpreterPathsByExtension.Value(lineExtension) = lineScriptInterpreterPath
		          end if
		          
		        end if
		        
		      wend
		      
		      tis.Close
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		      success = false
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SavePrefs() As Boolean
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
		      
		      if not fDirty then
		        Log.LogNote CurrentMethodName, "not saving because not dirty"
		        Exit
		      end if
		      
		      if fPrefsFile = nil then
		        Log.LogError CurrentMethodName, "fPrefsFile is nil"
		        Exit
		      end if
		      
		      Dim tos as TextOutputStream
		      tos = TextOutputStream.Create(fPrefsFile)
		      
		      tos.WriteLine fDefaultScriptName
		      tos.WriteLine kOutOfBandPrefix + fTargetFileNameExtensions
		      tos.WriteLine kOutOfBandPrefix + Str(fLogLevel)
		      
		      Dim extensions() as Variant
		      extensions = fScriptInterpreterPathsByExtension.Keys
		      for idx as integer = 0 to UBound(extensions) 
		        
		        Dim extension as string
		        extension = extensions(idx)
		        
		        Dim scriptInterpreterPath as String
		        scriptInterpreterPath = fScriptInterpreterPathsByExtension.Value(extension)
		        
		        extension = Trim(extension)
		        scriptInterpreterPath = Trim(scriptInterpreterPath)
		        
		        if scriptInterpreterPath <> "" and extension <> "" then
		          tos.WriteLine extension + "." + scriptInterpreterPath
		        end if
		        
		      next
		      
		      tos.Close
		      
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

	#tag Method, Flags = &h0
		Function SetDefaultScriptName(in_defaultScriptName as String) As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim success as Boolean
		  success = true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      Dim scriptCollection as CScriptCollection
		      scriptCollection = App.GetScriptCollection
		      if scriptCollection = nil then
		        Log.LogError CurrentMethodName, "scriptCollection is nil"
		        success = false
		        Exit
		      end if
		      
		      if in_defaultScriptName <> "" and not scriptCollection.IsValidScriptName(in_defaultScriptName) then
		        Log.LogError CurrentMethodName, "invalid script name " + in_defaultScriptName
		        success = false
		        Exit
		      end if
		      
		      fDirty = fDirty or (fDefaultScriptName <> in_defaultScriptName)
		      
		      fDefaultScriptName = in_defaultScriptName
		      
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
		Function SetPrefsLogLevel(in_logLevel as integer) As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim success as Boolean
		  success = true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      fDirty = fDirty or (fLogLevel <> in_logLevel)
		      
		      fLogLevel = in_logLevel
		      
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
		Function SetScriptInterpreterPath(in_extension as String, in_scriptInterpreterPath as String) As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim success as Boolean
		  success = true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Do 
		    
		    Try
		      
		      if fScriptInterpreterPathsByExtension = nil then
		        Log.LogError CurrentMethodName, "fScriptInterpreterPathsByExtension = nil"
		        success = false
		        Exit
		      end if
		      
		      if not fScriptInterpreterPathsByExtension.HasKey(in_extension) then
		        if in_scriptInterpreterPath <> "" then
		          fDirty = true
		          fScriptInterpreterPathsByExtension.Value(in_extension) = in_scriptInterpreterPath
		        end if
		        Exit
		      end if
		      
		      if fScriptInterpreterPathsByExtension.Value(in_extension) = in_scriptInterpreterPath then
		        Exit
		      end if
		      
		      fDirty = true
		      if in_scriptInterpreterPath = "" then
		        fScriptInterpreterPathsByExtension.Remove in_extension
		      else
		        fScriptInterpreterPathsByExtension.Value(in_extension) = in_scriptInterpreterPath
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


	#tag Property, Flags = &h21
		Private fDefaultScriptName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fDirty As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fLogLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fPrefsFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fScriptFileNameExtensions() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fScriptInterpreterPathsByExtension As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fTargetFileNameExtensions As String
	#tag EndProperty


	#tag Constant, Name = kDefaultTargetFileNameExtensions, Type = String, Dynamic = False, Default = \"xhtml.html.htm.css", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kOutOfBandPrefix, Type = String, Dynamic = False, Default = \"..", Scope = Private
	#tag EndConstant


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
