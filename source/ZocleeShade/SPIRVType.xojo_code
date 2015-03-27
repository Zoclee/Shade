#tag Class
Protected Class SPIRVType
	#tag Method, Flags = &h0
		Sub Constructor(initVM As ZocleeShade.SPIRVVirtualMachine, initResultID As UInt32)
		  VM = initVM
		  ResultID = initResultID
		  
		End Sub
	#tag EndMethod


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
			  Dim typ As ZocleeShade.SPIRVType
			  Dim i As UInt32
			  
			  select case Type
			    
			    ' ***** Bool ***********************************************************************************
			    
			  case SPIRVTypeEnum.Boolean
			    result.Append "Bool"
			    
			    ' ***** Float ***********************************************************************************
			    
			  case SPIRVTypeEnum.Float
			    result.Append "Float"
			    result.Append Str(Width)
			    
			    ' ***** Function_ ***********************************************************************************
			    
			  case SPIRVTypeEnum.Function_
			    if (ReturnTypeID <> ResultID) and VM.Types.HasKey(ReturnTypeID) then
			      typ = VM.Types.Value(ReturnTypeID)
			      result.Append typ.InstructionText
			    else
			      result.Append "Unknown"
			    end if
			    result.Append " func("
			    i = 0
			    while i <= ParmTypeID.Ubound
			      if i > 0 then
			        result.Append ", "
			      end if
			      if (ParmTypeID(i) <> ResultID) and VM.Types.HasKey(ParmTypeID(i)) then
			        typ = VM.Types.Value(ParmTypeID(i))
			        result.Append typ.InstructionText
			      else
			        result.Append "Unknown"
			      end if
			      i = i + 1
			    wend
			    result.Append ")"
			    
			    ' ***** Enum ***********************************************************************************
			    
			  case SPIRVTypeEnum.Integer
			    if Signed then
			      result.Append "Int"
			    else
			      result.Append "UInt"
			    end if
			    result.Append Str(Width)
			    
			  case SPIRVTypeEnum.Pointer
			    if (TypeID <> ResultID) and VM.Types.HasKey(TypeID) then
			      typ = VM.Types.Value(TypeID)
			      result.Append "Ptr:"
			      result.Append typ.InstructionText
			    else
			      result.Append "Unknown"
			    end if
			    
			    ' ***** Vector ***********************************************************************************
			    
			  case SPIRVTypeEnum.Vector
			    if (ComponentTypeID <> ResultID) and VM.Types.HasKey(ComponentTypeID) then
			      typ = VM.Types.Value(ComponentTypeID)
			      result.Append typ.InstructionText
			      result.Append "Vec"
			      result.Append "["
			      result.Append Str(ComponentCount)
			      result.Append "]"
			    else
			      result.Append "Unknown"
			    end if
			    
			    ' ***** Void ***********************************************************************************
			    
			  case SPIRVTypeEnum.Void
			    result.Append "Void"
			    
			  case else
			    break
			    result.Append "Unknown"
			    
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
		ResultID As UInt32
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
		VM As ZocleeShade.SPIRVVirtualMachine
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
			Name="InstructionText"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
