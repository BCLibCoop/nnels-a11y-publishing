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


	#tag Method, Flags = &h21
		Private Sub AddFile(in_zipFile as ZipMBS, in_file as FolderItem, in_fileNameInZip as String)
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
		      
		      Dim fileInfo as new ZipFileInfoMBS
		      fileInfo.SetDate in_file.CreationDate
		      in_zipFile.CreateFile(in_fileNameInZip,  fileInfo, "", "", "", ZipMBS.MethodDeflated, ZipMBS.CompressionDefault, false)
		      
		      Dim inData as String
		      
		      Dim inStream As BinaryStream
		      inStream = BinaryStream.Open(in_file, false)
		      
		      const kBufferSize = 10240
		      
		      Dim block as String
		      
		      Do
		        
		        block = inStream.Read(kBufferSize)
		        
		        if block.Len > 0 then
		          in_zipFile.Write(block)
		        end if
		        
		      Loop Until inStream.EOF
		      
		      inStream.Close
		      
		      in_zipFile.CloseFile
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddFiles(in_zipFile as ZipMBS, in_dir as FolderItem, in_prefix as String)
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
		      
		      if not in_dir.Directory then
		        Log.LogError CurrentMethodName, "in_dir must be a directory"
		        exit
		      end if
		      
		      Dim nItems as integer
		      nItems = in_dir.Count
		      
		      for idx as Integer = 1 to nItems
		        
		        Dim file as FolderItem
		        file = in_dir.Item(idx)
		        
		        if file.Directory then
		          Dim subPrefix as String
		          subPrefix = in_prefix + file.Name + "/"
		          AddFiles in_zipFile, file, subPrefix
		        elseif file.name <> "mimetype" and left(file.name,1) <> "."  then
		          AddFile in_zipFile, file, in_prefix + file.name
		        end if
		        
		      next
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddToReport(in_message as String)
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
		      
		      fReport = fReport + in_message + EndOfLine
		      WndReport.ShowLogLine in_message
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddToScriptOutput(in_output as String)
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
		      
		      fScriptOutput = fScriptOutput + in_output + EndOfLine
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CleanupFolderContent(in_folder as FolderItem, in_folderContentDict as Dictionary) As Boolean
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
		      
		      if in_folder = nil then
		        Log.LogError CurrentMethodName, "in_folder is nil"
		        Exit
		      end if
		      
		      if in_folderContentDict = nil then
		        Log.LogError CurrentMethodName, "in_folderContentDict is nil"
		        Exit
		      end if
		      
		      if not in_folder.Exists() then
		        Log.LogNote CurrentMethodName, "in_folder does not exist"
		        Exit
		      end if
		      
		      success = true
		      
		      Dim itemCount as integer
		      itemCount = in_folder.Count
		      dim filesToDelete() as FolderItem
		      dim folders() as FolderItem
		      for itemIdx as integer = 1 to itemCount
		        
		        dim file as FolderItem
		        file = in_folder.TrueItem(itemIdx)
		        
		        if file <> nil then
		          
		          if file.Directory then
		            folders.Append file
		          else
		            
		            if not in_folderContentDict.HasKey(file.NativePath) then
		              filesToDelete.Append file
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		      for each file as FolderItem in filesToDelete
		        file.Delete
		      next
		      
		      Redim filesToDelete(-1)
		      
		      for each folder as FolderItem in folders
		        
		        success = CleanupFolderContent(folder, in_folderContentDict) and success
		        
		      next
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		  return success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ConvertToEPUB(in_epubFolder as FolderItem, in_outputEPUBFile as FolderItem) As Boolean
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
		      
		      Dim emptyZip as String
		      emptyZip = DecodeHex("504B03040A0000000000D103DA406F61AB2C1400000014000000080000006D696D65747970656170706C69636174696F6E2F657075622B7A6970504B01021E030A0000000000D103DA406F61AB2C1400000014000000080000000000000000000000A481000000006D696D6574797065504B05060000000001000100360000003A0000000000")
		      
		      Dim binStream as BinaryStream
		      binStream = BinaryStream.Create(in_outputEPUBFile, True)
		      binStream.Write emptyZip
		      binStream.close
		      
		      Dim zipFile as ZipMBS
		      zipFile = new ZipMBS(in_outputEPUBFile, ZipMBS.AppendStatusAddInZip)
		      
		      AddFiles zipFile, in_epubFolder, ""
		      
		      zipFile.Close
		      
		      success = true
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateFolderContentDict(in_folder as FolderItem, io_folderContentDict as Dictionary) As Boolean
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
		      
		      if in_folder = nil then
		        Log.LogError CurrentMethodName, "in_folder is nil"
		        Exit
		      end if
		      
		      if io_folderContentDict = nil then
		        Log.LogError CurrentMethodName, "io_folderContentDict is nil"
		        Exit
		      end if
		      
		      if not in_folder.Exists() then
		        Log.LogNote CurrentMethodName, "in_folder does not exist"
		        Exit
		      end if
		      
		      success = true
		      
		      Dim itemCount as integer
		      itemCount = in_folder.Count
		      dim folders() as FolderItem
		      for itemIdx as integer = 1 to itemCount
		        
		        dim file as FolderItem
		        file = in_folder.TrueItem(itemIdx)
		        
		        if file <> nil then
		          
		          if file.Directory then
		            folders.Append file
		          else
		            Dim hash as String 
		            hash = MD5DigestMBS.HashFile(file)
		            io_folderContentDict.Value(file.NativePath) = hash
		          end if
		          
		        end if
		      next
		      
		      for each folder as FolderItem in folders
		        
		        success = CreateFolderContentDict(folder, io_folderContentDict) and success
		        
		      next
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		  return success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CreateSubFolder(in_parentFolder as FolderItem, in_path as String) As FolderItem
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Dim retVal as FolderItem
		  
		  Do 
		    
		    Try
		      
		      Dim segmentCount as integer
		      segmentCount = CountFields(in_path, "/")
		      
		      dim folder as FolderItem 
		      folder = in_parentFolder
		      
		      for segmentIdx as integer = 1 to segmentCount
		        
		        dim segment as string
		        segment = NthField(in_path, "/", segmentIdx)
		        
		        if segment <> "" then
		          
		          if not folder.Exists then
		            folder.CreateAsFolder
		          end if
		          
		          folder = folder.Child(segment)
		          
		        end if
		        
		      next
		      
		      retVal = folder 
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  Return retVal
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DeleteFolder(in_folder as FolderItem, in_continueIfErrors as Boolean = false) As Integer
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  // Returns an error code if it fails, or zero if the folder was deleted successfully
		  
		  Dim retVal as integer
		  
		  Do 
		    
		    Try
		      
		      
		      if in_folder = nil then
		        Log.LogError CurrentMethodName, "in_folder is nil"
		        Exit
		      end if
		      
		      if not in_folder.Exists() then
		        Log.LogNote CurrentMethodName, "in_folder does not exist"
		        Exit
		      end if
		      
		      // Collect the folder‘s contents first.
		      // This is faster than collecting them in reverse order and deleting them right away!
		      
		      Dim itemCount as integer
		      itemCount = in_folder.Count
		      dim files(), folders() as FolderItem
		      for itemIdx as integer = 1 to itemCount
		        
		        dim file as FolderItem
		        file = in_folder.TrueItem(itemIdx)
		        
		        if file <> nil then
		          
		          if file.Directory then
		            folders.Append file
		          else
		            files.Append file
		          end if
		          
		        end if
		      next
		      
		      for each file as FolderItem in files
		        
		        file.Delete
		        
		        Dim lastErr as integer
		        lastErr = file.LastErrorCode
		        
		        if lastErr <> 0 then
		          
		          if retVal = 0 then 
		            retVal = lastErr
		          end if
		          
		          if not in_continueIfErrors then
		            Exit // for
		          end if
		          
		        end if
		        
		      next
		      
		      if retVal <> 0 and not in_continueIfErrors then
		        Exit
		      end if
		      
		      // Free the memory used by the files array before we enter recursion
		      Redim files(-1) 
		      
		      // Now delete the directories
		      for each folder as FolderItem in folders
		        
		        Dim lastErr as integer
		        lastErr = DeleteFolder(folder, in_continueIfErrors)
		        
		        if lastErr <> 0 then
		          
		          if retVal = 0 then 
		            retVal = lastErr
		          end if
		          
		          if not in_continueIfErrors then
		            Exit // for
		          end if
		          
		        end if
		        
		      next
		      
		      if retVal <> 0 and not in_continueIfErrors then
		        Exit
		      end if
		      
		      in_folder.Delete
		      
		      retVal = in_folder.LastErrorCode
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		  return retVal
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExtractFiles(in_zipFile as FolderItem, in_destDir as FolderItem) As Boolean
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
		      
		      Do
		        If in_zipFile = Nil Or Not in_zipFile.exists Then
		          Log.LogError CurrentMethodName, "in_zipFile does not exist"
		          Exit
		        End If
		        
		        If in_destDir = Nil Then
		          Log.LogError CurrentMethodName, "in_destDir is nil"
		          Exit
		        End If
		        
		        If in_destDir.exists and Not in_destDir.Directory Then
		          Log.LogError CurrentMethodName, "in_destDir is an existing file"
		          Exit
		        End If
		        
		        dim unZipFile as UnZipMBS
		        unZipFile = new UnZipMBS(in_zipFile)
		        
		        unZipFile.GoToFirstFile
		        
		        const kBufferSize = 10240
		        Dim file as FolderItem
		        Dim info as UnZipFileInfoMBS
		        Dim block as String
		        do
		          
		          dim path as string
		          path = unZipFile.FileName
		          path = DefineEncoding(path, encodings.ASCII)
		          
		          dim isFolder as Boolean
		          isFolder = Right(path,1) = "/"
		          
		          file = CreateSubFolder(in_destDir, path)
		          
		          info = unZipFile.FileInfo
		          
		          if isFolder then
		            
		            file.CreateAsFolder
		            
		          else
		            
		            dim binStream as BinaryStream 
		            binStream = file.CreateBinaryFile("")
		            
		            if binStream <> nil then
		              
		              unZipFile.OpenCurrentFile
		              
		              if unZipFile.LastError = 0 then
		                
		                do
		                  
		                  block = unZipFile.ReadCurrentFile(kBufferSize)
		                  binStream.Write block
		                  
		                loop until lenb(block) = 0
		                
		                unZipFile.CloseCurrentFile
		                
		                binStream.Close
		                
		              end if
		              
		            end if
		            
		          end if
		          
		          file.ModificationDate = info.Date
		          file.CreationDate = info.date
		          
		          unZipFile.GoToNextFile
		          
		        loop until unZipFile.LastError <> 0
		        
		        success = true
		        
		      Loop Until True
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		  
		  return success
		End Function
	#tag EndMethod

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
		        Log.LogError CurrentMethodName + ": init failed"
		        Exit
		      end if
		      
		      if fSelectedScript <> nil and UBound(fDocumentQueue) >= 0 then
		        
		        Log.LogNote "Using script " + fSelectedScript.Name
		        
		        success = true
		        for idx as integer = 0 to UBound(fDocumentQueue)
		          Dim droppedFile as FolderItem
		          droppedFile = fDocumentQueue(idx)
		          Dim fileSuccess as Boolean
		          fileSuccess = HandleDroppedFile(droppedFile)
		          if fileSuccess then
		            Log.LogNote "Success: processed " + droppedFile.Name
		          else
		            Log.LogError "Failure: attempted to process " + droppedFile.Name
		          end if
		          success = fileSuccess and success
		        next
		        ReportAndQuit
		        Exit
		      end if
		      
		      if UBound(fDocumentQueue) < 0 then
		        success = WndPrefs.EditPrefs
		        if not success then
		          Log.LogError CurrentMethodName, "failed to manage prefs"
		        end if
		        ReportAndQuit
		        Exit
		      end if
		      
		      fSelectedScript = WndSelectScript.ChooseScript
		      success = true
		      if fSelectedScript <> nil then
		        
		        Log.LogNote "Using script " + fSelectedScript.Name
		        
		        for idx as integer = 0 to UBound(fDocumentQueue)
		          Dim droppedFile as FolderItem
		          droppedFile = fDocumentQueue(idx)
		          Dim fileSuccess as Boolean
		          fileSuccess = HandleDroppedFile(droppedFile)
		          if fileSuccess then
		            Log.LogNote "Success: processed " + droppedFile.Name
		          else
		            Log.LogError "Failure: attempted to process " + droppedFile.Name
		          end if
		          success = fileSuccess and success
		        next
		      end if
		      
		      if not success then
		        Log.LogError CurrentMethodName, "failed to handle all dropped files"
		      end if
		      
		      ReportAndQuit
		      
		    Catch e As RuntimeException
		      if not e isa EndException then
		        Log.LogError CurrentMethodName, "throws " + e.Message
		      end if
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
		Private Function GetTargetFiles(in_folder as FolderItem, in_targetFileNameExtensionDict as Dictionary, ByRef io_targetFiles() as FolderItem) As Boolean
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
		      
		      if in_folder = nil then
		        Log.LogError CurrentMethodName, "in_folder is nil"
		        Exit
		      end if
		      
		      if not in_folder.Exists() then
		        Log.LogError CurrentMethodName, "in_folder does not exist"
		        Exit
		      end if
		      
		      success = true
		      
		      Dim itemCount as integer
		      itemCount = in_folder.Count
		      
		      dim folders() as FolderItem
		      for itemIdx as integer = 1 to itemCount
		        
		        dim file as FolderItem
		        file = in_folder.TrueItem(itemIdx)
		        
		        if file <> nil then
		          
		          if file.Directory then
		            folders.Append file
		          else
		            Dim fileNameExtension as String
		            fileNameExtension = GetFileNameExtension(file.name)
		            
		            if in_targetFileNameExtensionDict.HasKey(fileNameExtension) and in_targetFileNameExtensionDict.Value(fileNameExtension) then
		              io_targetFiles.Append file
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		      for each folder as FolderItem in folders
		        
		        success = GetTargetFiles(folder, in_targetFileNameExtensionDict, io_targetFiles)
		        if not success then
		          Exit
		        end if
		        
		      next
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		      success = false
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		  return success
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandleDroppedEPUB(in_epubFile as FolderItem) As Boolean
		  #If Cfg.DISABLE_COMPILER_RUNTIME_CHECKS
		    #Pragma DisableBoundsChecking
		    #Pragma StackOverflowchecking False
		    #Pragma NilObjectChecking False
		  #EndIf
		  
		  Dim success as Boolean
		  Dim prvRecursiveEPUB as Boolean
		  static recursiveEPUB as Boolean
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  prvRecursiveEPUB = recursiveEPUB
		  
		  Do
		    
		    Try
		      
		      if recursiveEPUB then
		        Log.LogError CurrentMethodName, "recursiveEPUB"
		        Exit
		      end if
		      
		      recursiveEPUB = true
		      
		      if in_epubFile = nil then
		        Log.LogError CurrentMethodName, "in_epubFile is nil"
		        Exit
		      end if
		      
		      if not in_epubFile.Exists then
		        Log.LogError CurrentMethodName, "in_epubFile does not exist"
		        Exit
		      end if
		      
		      Log.LogNote "Handling EPUB file " + in_epubFile.Name
		      
		      if fTemporaryDecompressedEPUB = nil then
		        fTemporaryDecompressedEPUB = GetTemporaryFolderItem()
		      end if
		      
		      if fTemporaryDecompressedEPUB.Exists then
		        if fTemporaryDecompressedEPUB.Directory then
		          if DeleteFolder(fTemporaryDecompressedEPUB) <> 0 then
		            Log.LogError CurrentMethodName, "failed to delete fTemporaryDecompressedEPUB"
		            Exit
		          end if
		        else
		          fTemporaryDecompressedEPUB.Delete
		        end if
		      end if
		      
		      if fTemporaryDecompressedEPUB.Exists then
		        Log.LogError CurrentMethodName, "cannot delete fTemporaryDecompressedEPUB"
		        Exit
		      end if
		      
		      if not ExtractFiles(in_epubFile, fTemporaryDecompressedEPUB) then
		        Log.LogError CurrentMethodName, "failed to extract EPUB"
		        Exit
		      end if
		      
		      Dim targetFileNameExtensionDict as Dictionary
		      targetFileNameExtensionDict = fPrefs.GetTargetFileNameExtensionDict
		      if targetFileNameExtensionDict = nil then
		        Log.LogError CurrentMethodName, "targetFileNameExtensionDict = nil"
		        Exit
		      end if
		      
		      dim targetFiles() as FolderItem
		      if not GetTargetFiles(fTemporaryDecompressedEPUB, targetFileNameExtensionDict, targetFiles) then
		        Log.LogError CurrentMethodName, "GetTargetFiles failed"
		        Exit
		      end if
		      
		      if UBound(targetFiles) < 0 then
		        Log.LogError CurrentMethodName, "no target files found"
		        Exit
		      end if
		      
		      Dim beforeContentDict as Dictionary
		      beforeContentDict = new Dictionary
		      if not CreateFolderContentDict(fTemporaryDecompressedEPUB, beforeContentDict) then
		        Log.LogError CurrentMethodName, "cannot create content snapshot"
		        Exit
		      end if
		      
		      success = true
		      
		      Dim changed as Boolean
		      for each targetFile as FolderItem in targetFiles
		        Dim fileSuccess as Boolean
		        fileSuccess = HandleDroppedFile(targetFile, in_epubFile)
		        if fileSuccess then
		          Log.LogNote "Success: processed " + targetFile.Name
		        else
		          Log.LogError "Failure: attempted to process " + targetFile.Name
		        end if
		        
		        if not changed then
		          Dim beforeHash as String
		          beforeHash = beforeContentDict.Value(targetFile.NativePath)
		          Dim afterHash as String
		          afterHash = MD5DigestMBS.HashFile(targetFile)
		          changed = beforeHash <> afterHash
		        end if
		        
		        success = fileSuccess and success
		        
		      next
		      
		      if not changed then
		        Log.LogNote CurrentMethodName, "nothing was changed"
		        success = DeleteFolder(fTemporaryDecompressedEPUB) = 0
		        fTemporaryDecompressedEPUB = nil
		        Exit
		      end if
		      
		      if not CleanupFolderContent(fTemporaryDecompressedEPUB, beforeContentDict) then
		        Log.LogError CurrentMethodName, "cannot clean up backup files"
		        success = false
		        Exit
		      end if
		      
		      if not MoveToBackup(in_epubFile) then
		        Log.LogError CurrentMethodName, "failed to backup old EPUB"
		        success = false
		        Exit
		      end if
		      
		      if not ConvertToEPUB(fTemporaryDecompressedEPUB, in_epubFile) then
		        Log.LogError CurrentMethodName, "failed to recompress EPUB"
		        success = false
		        Exit
		      end if
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  // Cleanup
		  
		  Do
		    
		    Try
		      
		      if fTemporaryDecompressedEPUB = nil then
		        Exit
		      end if
		      
		      if not fTemporaryDecompressedEPUB.Exists then
		        Exit
		      end if
		      
		      if fTemporaryDecompressedEPUB.Directory then
		        Dim lastErr as Integer
		        lastErr = DeleteFolder(fTemporaryDecompressedEPUB)
		      else
		        fTemporaryDecompressedEPUB.Delete
		      end if
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "cleanup throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  recursiveEPUB = prvRecursiveEPUB
		  
		  if not success then
		    Log.LogError "Failed to process EPUB file"
		  end if
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  return success
		  
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
		      
		      fFileCount = fFileCount + 1
		      
		      if in_file = nil then
		        Log.LogError CurrentMethodName, "in_file is nil"
		        Exit
		      end if
		      
		      if not in_file.Exists then
		        Log.LogError CurrentMethodName, "in_file does not exist"
		        Exit
		      end if
		      
		      Dim droppedFileExtension as String
		      droppedFileExtension = Utils.GetFileNameExtension(in_file.Name)
		      if droppedFileExtension = "EPUB" then
		        success = HandleDroppedEPUB(in_file)
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
		      
		      #if TargetWindows
		        
		        // Shellpaths are shortened. Mix up a shortened parent dir path with an unshortened file name
		        
		        Dim parentFolderShellPath as String
		        parentFolderShellPath = in_file.Parent.ShellPath
		        
		        commandLine = """" + scriptInterpreterPath + """ " + fSelectedScript.ShellPath + " """ + parentFolderShellPath + "\" + in_file.Name + """"
		      #else
		        commandLine = """" + scriptInterpreterPath + """ " + fSelectedScript.ShellPath + " " + in_file.ShellPath
		      #endif
		      
		      Log.LogNote CurrentMethodName, "commandLine = '" + commandLine + "'"
		      
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
		        Dim outputLines() as String
		        outputLines = output.Split(Chr(13) + Chr(10))
		        if UBound(outputLines) = 0 then
		          outputLines = output.Split(Chr(10))
		          if UBound(outputLines) = 0 then
		            outputLines = output.Split(Chr(13))
		          end if
		        end if
		        
		        for idx as integer = 0 to UBound(outputLines)
		          Dim line as String
		          line = outputLines(idx)
		          if Left(line, Len(OUTPUTPREFIX)) = OUTPUTPREFIX then
		            AddToScriptOutput Mid(line, Len(OUTPUTPREFIX) + 1)
		          else
		            Log.LogNote output
		          end if
		        next
		        
		      end if
		      
		      success = true
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until True
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  if success then
		    fSuccessFileCount = fSuccessFileCount + 1
		  end if
		  
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
		        Log.LogNote CurrentMethodName, "already initialized"
		        success = true
		        Exit
		      end if
		      
		      dim s as string = decodeBase64("S1IwUjMxQ1JaejcyTFFHMXkrUzI=", encodings.UTF8)
		      dim p as string = decodeBase64("TUJTIENvbXBsZXRl", encodings.UTF8)
		      dim n as string = decodeBase64("Um9yb2hpa28gTHRkLg==", encodings.UTF8)
		      dim e as integer = 201909
		      dim t as string = decodeBase64("MEw0ZnpRdHJzTDc2MTdJMU53SDRoNXgwSExuKzJzVithc2FPRURRQzFBSj0=", encodings.UTF8)
		      
		      if not registerMBSPlugin(n, p, e, s+t) then  
		        MsgBox "MBS Plugin serial not valid?"
		        Exit  
		      end if
		      
		      Dim prefsFile as FolderItem
		      prefsFile = GetPrefsFile
		      
		      fPrefs = CPrefs.Factory(prefsFile)
		      if fPrefs = nil then
		        Log.LogError CurrentMethodName, "failed to create fPrefs"
		        Exit
		      end if
		      
		      Log.SetLogLevel fPrefs.GetPrefsLogLevel
		      
		      fScriptCollection = CScriptCollection.Factory
		      if fScriptCollection = nil then
		        Log.LogError CurrentMethodName, "failed to create fScriptCollection"
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
		Private Function MoveToBackup(in_file as FolderItem) As Boolean
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
		      
		      if in_file = nil then
		        Log.LogError CurrentMethodName, "in_file is nil"
		        Exit
		      end if
		      
		      if not in_file.Exists then
		        Log.LogError CurrentMethodName, "in_file does not exist"
		        Exit
		      end if
		      
		      Dim parentFolder as FolderItem
		      parentFolder = in_file.Parent
		      
		      Dim fileNameExtension as String
		      fileNameExtension = GetFileNameExtension(in_file.Name)
		      
		      Dim baseFileName as String
		      if fileNameExtension = "" then
		        baseFileName = in_file.Name
		      else
		        baseFileName = Left(in_file.Name, Len(in_file.Name) - Len(fileNameExtension) - 1)
		        if baseFileName = "" then
		          Log.LogError CurrentMethodName, "baseFileName is empty"
		          Exit
		        end if
		      end if
		      
		      Dim backupFile as FolderItem
		      Dim backupIdx as integer
		      
		      do
		        
		        backupIdx =  backupIdx + 1
		        
		        Dim backupFileName as String
		        backupFileName = baseFileName + ".old." + Str(backupIdx) + "." + fileNameExtension
		        
		        backupFile = parentFolder.Child(backupFileName)
		        
		      loop until Not backupFile.Exists or backupIdx >= Cfg.MAX_BACKUPS
		      
		      while backupIdx > 2
		        
		        Dim prvBackupFile as FolderItem
		        prvBackupFile = backupFile
		        if prvBackupFile.Exists then
		          prvBackupFile.Delete
		        end if
		        
		        backupIdx = backupIdx - 1
		        
		        Dim backupFileName as String
		        backupFileName = baseFileName + ".old." + Str(backupIdx) + "." + fileNameExtension
		        
		        backupFile = parentFolder.Child(backupFileName)
		        
		        backupFile.MoveFileTo prvBackupFile
		        
		      wend
		      
		      in_file.CopyFileTo backupFile
		      
		      success = true
		      
		    Catch e As RuntimeException
		      Log.LogError CurrentMethodName, "throws " + e.Message
		    End Try
		    
		  Loop Until true
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogExit CurrentMethodName
		  #EndIf
		  
		  return success
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
		      
		      Log.SetLogLevel Log.NONE
		      
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

	#tag Method, Flags = &h21
		Private Sub ReportAndQuit()
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
		      
		      if fFileCount > 0 then
		        Log.LogMessage "Total # of files inspected: " + Str(fFileCount)
		        Log.LogMessage "# of files that caused an error: " + Str(fFileCount - fSuccessFileCount)
		      end if
		      
		      WndReport.ShowReport fScriptOutput
		      
		      Quit
		      
		    Catch e As RuntimeException
		      if not e isa EndException then
		        Log.LogError CurrentMethodName, "throws " + e.Message
		      end if
		    End Try
		    
		  Loop Until True
		  
		  
		  #If Cfg.IS_ENTRY_EXIT_LOGGING
		    Log.LogEntry CurrentMethodName
		  #EndIf
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private fDocumentQueue() As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fFileCount As Integer
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
		Private fReport As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fScriptCollection As CScriptCollection
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fScriptOutput As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fSelectedScript As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fSuccessFileCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fTemporaryDecompressedEPUB As FolderItem
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

	#tag Constant, Name = OUTPUTPREFIX, Type = String, Dynamic = False, Default = \">!>:", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
