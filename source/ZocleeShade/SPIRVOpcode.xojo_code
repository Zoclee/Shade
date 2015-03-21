#tag Class
Protected Class SPIRVOpcode
	#tag Method, Flags = &h0
		Sub Constructor(initVM As ZocleeShade.SPIRVVirtualMachine, initType As SPIRVOpcodeTypeEnum)
		  VM = initVM
		  Type = initType
		  
		  HasErrors = False
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		HasErrors As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim result() As String
			  Dim typ As ZocleeShade.SPIRVType
			  
			  select case Type
			    
			    // ***** OpDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.Decorate
			    result.Append "Decorate "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 4))
			    if VM.Names.HasKey(VM.ModuleBinary.UInt32Value(Offset + 4)) then
			      result.Append "("
			      result.Append VM.Names.Value(VM.ModuleBinary.UInt32Value(Offset + 4))
			      result.Append ")"
			    end if
			    result.Append " "
			    result.Append SPIRVDescribeDecoration(VM.ModuleBinary.UInt32Value(Offset + 8))
			    select case VM.ModuleBinary.UInt32Value(Offset + 8)
			    case 29 // Stream
			      break
			    case 30 // Location
			      break
			    case 31 // Component
			      break
			    case 32 // Index
			      break
			    case 33 // Binding
			      break
			    case 34 // DescriptorSet
			      break
			    case 35 // Offset
			      break
			    case 36 // Alignment
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 37 // XfbBuffer
			      break
			    case 38 // Stride
			      break
			    case 39 // Built-In
			      result.Append " "
			      result.Append SPIRVDescribeBuiltIn(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 40 // FuncParamAttr
			      result.Append " "
			      result.Append SPIRVDescribeFuncParamAttr(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 41 // FP Rounding Mode
			      result.Append " "
			      result.Append SPIRVDescribeFPRoundingMode(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 42 // FP Fast Math Mode
			      result.Append " "
			      result.Append SPIRVDescribeFPFastMathMode(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 43 // Linkage Type
			      result.Append " "
			      result.Append SPIRVDescribeLinkageType(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 44 // SpecId
			      break
			    end select
			    
			    // ***** OpEntryPoint *************************************************
			    
			  case SPIRVOpcodeTypeEnum.EntryPoint
			    result.Append "EntryPoint "
			    result.Append SPIRVDescribeExecutionModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpMemoryModel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.MemoryModel
			    result.Append "MemoryModel "
			    result.Append SPIRVDescribeAddressingModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemoryModel(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpName *************************************************
			    
			  case SPIRVOpcodeTypeEnum.Name
			    result.Append "Name "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpSource *************************************************
			    
			  case SPIRVOpcodeTypeEnum.Source
			    result.Append "Source "
			    result.Append SPIRVDescribeSourceLanguage(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpTypeInt *************************************************
			    
			  case SPIRVOpcodeTypeEnum.TypeInt
			    result.Append "TypeInt "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    if VM.ModuleBinary.UInt32Value(Offset + 12) = 0 then
			      result.Append " Unsigned"
			    else
			      result.Append " Signed"
			    end if
			    
			    // ***** OpTypePointer *************************************************
			    
			  case SPIRVOpcodeTypeEnum.TypePointer
			    result.Append "TypePointer "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append "("
			    if VM.Types.HasKey(VM.ModuleBinary.UInt32Value(Offset + 12)) then
			      typ = VM.Types.Value(VM.ModuleBinary.UInt32Value(Offset + 12))
			      result.Append typ.InstructionText
			    else
			      result.Append "Unknown"
			    end if
			    result.Append ")"
			    
			    // ***** OpTypeVector *************************************************
			    
			  case SPIRVOpcodeTypeEnum.TypeVector
			    result.Append "TypeVector "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append "("
			    if VM.Types.HasKey(VM.ModuleBinary.UInt32Value(Offset + 8)) then
			      typ = VM.Types.Value(VM.ModuleBinary.UInt32Value(Offset + 8))
			      result.Append typ.InstructionText
			    else
			      result.Append "Unknown"
			    end if
			    result.Append ")"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
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
			Name="HasErrors"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
