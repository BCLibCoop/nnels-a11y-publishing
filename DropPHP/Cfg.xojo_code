#tag Class
Protected Class Cfg
	#tag Constant, Name = COMPANY_FOLDER_NAME, Type = String, Dynamic = False, Default = \"ca.nnels.a11y.publishing.dropphp", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DISABLE_COMPILER_RUNTIME_CHECKS, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FILE_NAME_TEMP_SCRIPT, Type = String, Dynamic = False, Default = \"ca.nnels.a11y.publishing.dropphp.php", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FOLDER_NAME_PLUGINS, Type = String, Dynamic = False, Default = \"PHP_Plugins", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IS_ENTRY_EXIT_LOGGING, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LOG_FILE_NAME, Type = String, Dynamic = False, Default = \"DropPHP.log", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MAX_FILE_NAME_EXTENSION_LEN, Type = Double, Dynamic = False, Default = \"5", Scope = Public
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
