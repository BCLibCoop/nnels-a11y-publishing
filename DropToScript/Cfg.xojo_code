#tag Class
Protected Class Cfg
	#tag Constant, Name = COMPANY_FOLDER_NAME, Type = String, Dynamic = False, Default = \"ca.nnels.a11y.publishing.droptoscript", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DISABLE_COMPILER_RUNTIME_CHECKS, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = EDIT_SYMBOL, Type = String, Dynamic = False, Default = \"\xE2\x87\xA0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NAME_LOG, Type = String, Dynamic = False, Default = \"DropToScript.log", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NAME_PREFS, Type = String, Dynamic = False, Default = \"DropToScriptPrefs.txt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FOLDER_NAME_PLUGINS, Type = String, Dynamic = False, Default = \"DropScripts", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IS_ENTRY_EXIT_LOGGING, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MAX_FILE_NAME_EXTENSION_LEN, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SCRIPT_FILENAME_EXTENSION_LISTS, Type = String, Dynamic = False, Default = \".php.py.command.bat.", Scope = Public
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
