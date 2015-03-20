#tag Class
Protected Class SPIRVOpcode
	#tag Method, Flags = &h0
		Sub Constructor(initVM As ZocleeShade.SPIRVVirtualMachine, initType As SPIRVOpcodeTypeEnum)
		  VM = initVM
		  Type = initType
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim result() As String
			  
			  select case Type
			    
			  case SPIRVOpcodeTypeEnum.Decorate
			    // todo, extra decoration operands
			    // todo names
			    result.Append "Decorate "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeDecoration(VM.ModuleBinary.UInt32Value(Offset + 8))
			    if VM.ModuleBinary.UInt16Value(Offset + 2) > 3 then
			      break 
			    end if
			  case else
			    result.Append "Unknown"
			    
			  end select
			  
			  return Join(result, "")
			End Get
		#tag EndGetter
		InstructionText As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Offset As UInt32
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim result As UInt32
			  
			  result = 0
			  
			  select case Type
			    
			  case SPIRVOpcodeTypeEnum.TypeFunction
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.TypeInt
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.TypePointer
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.TypeVector
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.TypeVoid
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  end select
			  
			  return result
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  break
			End Set
		#tag EndSetter
		ResultID As UInt32
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Type As SPIRVOpcodeTypeEnum
	#tag EndProperty

	#tag Property, Flags = &h0
		VM As ZocleeShade.SPIRVVirtualMachine
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
			Type="SPIRVOpcodeTypeEnum"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - Decorate"
				"2 - EntryPoint"
				"3 - MemoryModel"
				"4 - Name"
				"5 - TypeFunction"
				"6 - TypeInt"
				"7 - TypePointer"
				"8 - TypeVector"
				"9 - TypeVoid"
				"10 - Source"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
