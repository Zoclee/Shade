#tag Class
Protected Class Type
	#tag Method, Flags = &h0
		Sub Constructor(initVM As SPIRV.VirtualMachine, initResultID As UInt32)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  VM = initVM
		  ResultID = initResultID
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AccessQualifier As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Arrayed As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ColumnCount As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ColumnTypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Compare As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ComponentCount As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ComponentTypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Content As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		DataTypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Dimensionality As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ElementTypeID As UInt32
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			  ' www.zoclee.com/shade
			  
			  Dim result() As String
			  Dim typ As SPIRV.Type
			  Dim i As UInt32
			  
			  select case Type
			    
			    ' ***** Array ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Array_
			    if VM.Types.HasKey(ElementTypeID) then
			      typ = VM.Types.Value(ElementTypeID)
			      result.Append typ.InstructionText
			    else
			      result.Append "Unknown"
			    end if
			    result.Append "["
			    result.Append Str(Length)
			    result.Append "]"
			    
			    ' ***** Bool ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Boolean
			    result.Append "Bool"
			    
			    ' ***** Enum ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Integer
			    if Signed then
			      result.Append "Int"
			    else
			      result.Append "UInt"
			    end if
			    result.Append Str(Width)
			    
			    ' ***** Filter ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Filter
			    result.Append "Filter"
			    
			    ' ***** Float ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Float
			    result.Append "Float"
			    result.Append Str(Width)
			    
			    ' ***** Function_ ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Function_
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
			    
			    ' ***** Matrix ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Matrix
			    if (ColumnTypeID <> ResultID) and VM.Types.HasKey(ColumnTypeID) then
			      typ = VM.Types.Value(ColumnTypeID)
			      result.Append typ.InstructionText
			      result.Append "Mat"
			      result.Append "["
			      result.Append Str(ColumnCount)
			      result.Append "]"
			    else
			      result.Append "Unknown"
			    end if
			    
			    ' ***** Pointer ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Pointer
			    if (TypeID <> ResultID) and VM.Types.HasKey(TypeID) then
			      typ = VM.Types.Value(TypeID)
			      result.Append "Ptr:"
			      result.Append typ.InstructionText
			    else
			      result.Append "Unknown"
			    end if
			    
			    ' ***** RuntimeArray ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Array_
			    if VM.Types.HasKey(ElementTypeID) then
			      typ = VM.Types.Value(ElementTypeID)
			      result.Append typ.InstructionText
			    else
			      result.Append "Unknown"
			    end if
			    result.Append "["
			    result.Append "]"
			    
			    ' ***** Sampler ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Sampler
			    result.Append "Sampler"
			    
			    ' ***** Struct ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Struct
			    if App.VM.Names.HasKey(ResultID)  then
			      result.Append App.VM.Names.Value(ResultID)
			    else
			      result.Append "struct"
			    end if
			    
			    ' ***** Vector ***********************************************************************************
			    
			  case SPIRV.TypeEnum.Vector
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
			    
			  case SPIRV.TypeEnum.Void
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
		Length As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		MemberTypeID() As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Multisampled As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

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
		SampledTypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Signed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		StorageClass As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As SPIRV.TypeEnum
	#tag EndProperty

	#tag Property, Flags = &h0
		TypeID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		VM As SPIRV.VirtualMachine
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
				"4 - Filter"
				"5 - Float"
				"6 - Function_"
				"7 - Integer"
				"8 - Matrix"
				"9 - Opaque"
				"10 - Pipe"
				"11 - Pointer"
				"12 - Queue"
				"13 - ReservedId"
				"14 - RuntimeArray"
				"15 - Sampler"
				"16 - Struct"
				"17 - Vector"
				"18 - Void"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
