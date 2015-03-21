#tag Class
Protected Class SPIRVType
	#tag Property, Flags = &h0
		ComponentCount As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ComponentTypeID As UInt32
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim result() As String
			  
			  select case Type
			    
			  case SPIRVTypeEnum.Integer
			    if Signed then
			      result.Append "Int"
			    else
			      result.Append "UInt"
			    end if
			    result.Append Str(Width)
			    
			  case else
			    break
			    
			  end select
			  
			  return Join(result, "")
			End Get
		#tag EndGetter
		InstructionText As String
	#tag EndComputedProperty

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
			EditorType="Enum"
			#tag EnumValues
				"0 - Array_"
				"1 - Boolean"
				"2 - DeviceEvent"
				"3 - Event_"
				"4 - Float"
				"5 - Function_"
				"6 - Integer"
				"7 - Matrix"
				"8 - Opaque"
				"9 - Pipe"
				"10 - Pointer"
				"11 - Queue"
				"12 - ReservedId"
				"13 - RuntimeArray"
				"14 - Sampler"
				"15 - Struct"
				"16 - Vector"
				"17 - Void"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
