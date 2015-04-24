#tag Class
Protected Class SPIRVConstant
	#tag Property, Flags = &h0
		Constituents() As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Filter As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Mode As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Param As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ResultID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ResultTypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		StringValue As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As SPIRVConstantType
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StringValue"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Group="Behavior"
			Type="SPIRVConstantType"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
