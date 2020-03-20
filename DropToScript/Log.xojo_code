#tag Class
Protected Class Log
	#tag Method, Flags = &h1
		Protected Shared Function GetLogFile() As FolderItem
		  do
		    
		    if fLogFile <> nil then
		      Exit
		    end if
		    
		    fLogFile = SpecialFolder.ApplicationData
		    if fLogFile = nil or not fLogFile.Exists or not fLogFile.Directory then
		      Exit
		    end if
		    
		    fLogFile = fLogFile.Child(Cfg.COMPANY_FOLDER_NAME)
		    if fLogFile = nil then
		      Exit
		    end if
		    
		    if not fLogFile.Exists then
		      fLogFile.CreateAsFolder
		    end if
		    
		    if fLogFile = nil or not fLogFile.Exists or not fLogFile.Directory then
		      fLogFile = nil
		      Exit
		    end if
		    
		    fLogFile = fLogFile.Child(Cfg.FILE_NAME_LOG)
		    if fLogFile = nil then
		      Exit
		    end if
		    
		    if fLogFile.Exists and fLogFile.Directory then
		      fLogFile = nil
		      Exit
		    end if
		    
		  Loop Until True
		  
		  return fLogFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetLogLevel() As Integer
		  return fLogLevel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LogEntry(in_methodName as String)
		  if fLogLevel >= Log.TRACE then
		    LogMessage "ENTRY  : " + in_methodName
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LogError(in_methodName as String, in_message as String = "")
		  if fLogLevel >= Log.ERROR then
		    Dim message as String
		    if in_methodName <> "" then
		      message = in_methodName + ": " + in_message
		    else
		      message = in_message
		    end if
		    LogMessage "ERROR  : " + message
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LogExit(in_methodName as String)
		  if fLogLevel >= Log.TRACE then
		    LogMessage "EXIT   : " + in_methodName
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LogMessage(in_message as String)
		  Do
		    
		    fLogFile = GetLogFile
		    if fLogFile = nil then
		      Exit
		    end if
		    
		    Dim tos as TextOutputStream
		    if fLogFile.Exists then
		      tos = TextOutputStream.Append(fLogFile)
		    else
		      tos = TextOutputStream.Create(fLogFile)
		    end if
		    
		    if tos = nil then
		      Exit
		    end if
		    
		    Dim now as Date
		    now = new Date
		    
		    Dim logLine as String
		    logLine = now.ShortTime + ":" +  in_message
		    
		    tos.WriteLine logLine
		    
		    tos.close
		    
		    App.AddToReport logLine
		  Loop Until true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LogNote(in_methodName as String, in_message as String = "")
		  if fLogLevel >= Log.NOTE then
		    Dim message as String
		    if in_methodName <> "" then
		      message = in_methodName + ": " + in_message
		    else
		      message = in_message
		    end if
		    LogMessage "NOTE   : " + message
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LogTrace(in_methodName as String, in_message as String = "")
		  if fLogLevel >= Log.TRACE then
		    Dim message as String
		    if in_methodName <> "" then
		      message = in_methodName + ": " + in_message
		    else
		      message = in_message
		    end if
		    LogMessage "TRACE  : " + message
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub LogWarning(in_methodName as String, in_message as String = "")
		  if fLogLevel >= Log.WARNING then
		    Dim message as String
		    if in_methodName <> "" then
		      message = in_methodName + ": " + in_message
		    else
		      message = in_message
		    end if
		    LogMessage "WARNING: " + message
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub SetLogLevel(in_logLevel as integer)
		  fLogLevel = in_logLevel
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Shared fLogFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared fLogLevel As Integer = 4
	#tag EndProperty


	#tag Constant, Name = ERROR, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NONE, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NOTE, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TRACE, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WARNING, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
