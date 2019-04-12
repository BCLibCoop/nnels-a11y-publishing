#tag Module
Protected Module Utils
	#tag Method, Flags = &h0
		Function GetFileNameExtension(in_fileNameOrPath as String, in_separator as String = "") As String
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Dim retVal as String
		  
		  Do
		    
		    Try
		      
		      Dim fileName as String
		      fileName = GetFileNameFromPath(in_fileNameOrPath, in_separator)
		      
		      Dim splitByPeriod() as String
		      splitByPeriod = fileName.Split(".")
		      
		      if UBound(splitByPeriod) = 0 then
		        Exit
		      end if
		      
		      Dim extension as String
		      extension = splitByPeriod.Pop()
		      
		      if extension.Len > Cfg.MAX_FILE_NAME_EXTENSION_LEN then
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
		Function GetFileNameFromPath(in_filePath as String, in_separator as String = "") As String
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Dim retVal as String
		  
		  Do
		    
		    Try
		      
		      Dim separator as String
		      separator = in_separator
		      if separator = "" then
		        #if TargetWindows
		          separator = "\"
		        #else
		          separator = "/"
		        #endif
		      end if
		      
		      Dim splitBySeparator() as String
		      splitBySeparator = in_filePath.Split(separator)
		      
		      Dim fileName as String
		      fileName = splitBySeparator.Pop()
		      
		      retVal = fileName
		      
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
End Module
#tag EndModule
