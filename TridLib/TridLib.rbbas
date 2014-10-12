#tag Module
Protected Module TridLib
	#tag Method, Flags = &h1
		Protected Function Analyze() As Integer
		  Return TrID_Analyze()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetInfo(InfoType As Integer, InfoIndex As Integer) As Integer
		  Dim mb As New MemoryBlock(4 * 1024)
		  Return TrID_GetInfo(InfoType, InfoIndex, mb)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetInfo(InfoType As Integer, InfoIndex As Integer, ByRef Output As MemoryBlock) As Integer
		  Return TrID_GetInfo(InfoType, InfoIndex, Output)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LoadDefsPack(Directory As FolderItem) As Integer
		  Dim mb As New MemoryBlock(Directory.AbsolutePath.LenB * 2)
		  mb.CString(0) = Directory.AbsolutePath
		  If DefsLoaded <= 0 Then
		    DefsLoaded = TrID_LoadDefsPack(mb)
		    Return DefsLoaded
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SetDefsPack(RawDefData As MemoryBlock) As Integer
		  If DefsLoaded <= 0 Then
		    DefsLoaded = TrID_SetDefsPack(RawDefData)
		    Return DefsLoaded
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SubmitFile(File As FolderItem) As Integer
		  Dim mb As New MemoryBlock(File.AbsolutePath.LenB * 2)
		  mb.CString(0) = File.AbsolutePath
		  Return TrID_SubmitFileA(mb)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TrIDTypes(Extends f As FolderItem) As TridLib.FileType()
		  #If DebugBuild Then
		    Call LoadDefsPack(App.ExecutableFile.Parent.Parent)
		  #else
		    Call LoadDefsPack(App.ExecutableFile.Parent)
		  #endif
		  Dim ret() As TridLib.FileType
		  
		  If DefsLoaded > 0 Then
		    If SubmitFile(f) = 1 And Analyze() = 1 Then
		      Dim count As Integer = GetInfo(TRID_GET_RES_NUM, 0)
		      For i As Integer = 1 To count
		        Dim out As New MemoryBlock(4 * 1024)
		        Dim t As New TridLib.FileType
		        Call GetInfo(TridLib.TRID_GET_RES_FILETYPE, i, out)
		        t.Description = out.CString(0)
		        out = New MemoryBlock(4 * 1024)
		        Call GetInfo(TridLib.TRID_GET_RES_FILEEXT, i, out)
		        t.Extension = out.CString(0)
		        t.Points = GetInfo(TridLib.TRID_GET_RES_POINTS, i)
		        ret.Append(t)
		      Next
		    End If
		  End If
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_Analyze Lib "tridlib" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_GetInfo Lib "tridlib" (InfoType As Integer, InfoIndex As Integer, TridRes As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_LoadDefsPack Lib "tridlib" (Path As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_SetDefsPack Lib "tridlib" (DefsPtr As Ptr) As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Soft Declare Function TrID_SubmitFileA Lib "tridlib" (FileName As Ptr) As Integer
	#tag EndExternalMethod


	#tag Property, Flags = &h21
		Private DefsLoaded As Integer
	#tag EndProperty


	#tag Constant, Name = TRID_GET_DEFSNUM, Type = Double, Dynamic = False, Default = \"1004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_RES_FILEEXT, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_RES_FILETYPE, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_RES_NUM, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_RES_POINTS, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = TRID_GET_VER, Type = Double, Dynamic = False, Default = \"1001", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
