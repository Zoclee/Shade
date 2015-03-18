#tag Class
Protected Class SPIRVType
	#tag Property, Flags = &h0
		ComponentCount As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ComponentTypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ParmTypeID() As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ReturnTypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Signed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		StorageClass As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As SPIRVTypeEnum
	#tag EndProperty

	#tag Property, Flags = &h0
		TypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Width As UInt32
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
			Name="Signed"
			Group="Behavior"
			Type="Boolean"
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
			Type="SPIRVTypeEnum"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
