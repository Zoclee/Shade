#tag Class
Protected Class SPIRVOpcode
	#tag Method, Flags = &h21
		Private Function compose_id(binOffset As UInt32) As String
		  Dim result() As String
		  
		  result.Append Str(VM.ModuleBinary.UInt32Value(binOffset))
		  if VM.Names.HasKey(VM.ModuleBinary.UInt32Value(binOffset)) then
		    result.Append "("
		    result.Append VM.Names.Value(VM.ModuleBinary.UInt32Value(binOffset))
		    result.Append ")"
		  end if
		  
		  return Join(result, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function compose_type(binOffset As UInt32) As String
		  Dim result() As String
		  Dim typ As ZocleeShade.SPIRVType
		  
		  result.Append Str(VM.ModuleBinary.UInt32Value(binOffset))
		  result.Append "("
		  if VM.Types.HasKey(VM.ModuleBinary.UInt32Value(binOffset)) then
		    typ = VM.Types.Value(VM.ModuleBinary.UInt32Value(binOffset))
		    result.Append typ.InstructionText
		  else
		    result.Append "Unknown"
		  end if
		  result.Append ")"
		  
		  return Join(result, "")
		  
		End Function
	#tag EndMethod

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
			  Dim i As UInt32
			  Dim ub As UInt32
			  
			  select case Type
			    
			    // ***** OpBranchConditional *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBranchConditional
			    result.Append "BranchConditional "
			    result.Append Str(VM.ModuleBinary.UInt16Value(Offset + 4))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt16Value(Offset + 8))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt16Value(Offset + 12))
			    ub = offset + WordCount
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpCompositeExtract *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCompositeExtract
			    result.Append "CompositeExtract "
			    result.Append compose_id(Offset + 12)
			    ub = offset + WordCount
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpConstant *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConstant
			    result.Append "Constant "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpConstantComposite *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConstantComposite
			    result.Append "ConstantComposite "
			    ub = offset + WordCount
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDecorate
			    result.Append "Decorate "
			    result.Append compose_id(Offset + 4)
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
			    
			  case SPIRVOpcodeTypeEnum.OpEntryPoint
			    result.Append "EntryPoint "
			    result.Append SPIRVDescribeExecutionModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpExtInstImport *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpExtInstImport
			    result.Append "ExtInstImport """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    
			    // ***** OpFunction *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunction
			    result.Append "Function "
			    result.Append SPIRVDescribeFunctionControlMask(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_type(Offset + 16)
			    
			    // ***** OpFunctionEnd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunctionEnd
			    result.Append "FunctionEnd"
			    
			    // ***** OpFunctionParameter *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunctionParameter
			    result.Append "FunctionParameter"
			    
			    // ***** OpIAdd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIAdd
			    result.Append "IAdd "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpInBoundsAccessChain *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpInBoundsAccessChain
			    result.Append "InBoundsAccessChain "
			    result.Append compose_id(Offset + 12)
			    ub = offset + WordCount
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpLabel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLabel
			    result.Append "Label"
			    
			    // ***** OpLoad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLoad
			    result.Append "Load "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpMemberName *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMemberName
			    result.Append "MemberName "
			    result.Append compose_type(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 12)
			    result.Append """"
			    
			    // ***** OpMemoryModel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMemoryModel
			    result.Append "MemoryModel "
			    result.Append SPIRVDescribeAddressingModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemoryModel(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpName *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpName
			    result.Append "Name "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpReturn *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReturn
			    result.Append "Return"
			    
			    // ***** OpSelectionMerge *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSelectionMerge
			    result.Append "SelectionMerge "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeSelectionControl(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSource *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSource
			    result.Append "Source "
			    result.Append SPIRVDescribeSourceLanguage(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpStore *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpStore
			    result.Append "Store "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    ub = offset + WordCount
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpTypeArray *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeArray
			    result.Append "TypeArray "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeBool *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeBool
			    result.Append "TypeBool"
			    
			    // ***** OpTypeFloat *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeFloat
			    result.Append "TypeFloat "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpTypeFunction *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeFunction
			    result.Append "TypeFunction "
			    result.Append compose_type(Offset + 8)
			    ub = offset + WordCount
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      result.Append "("
			      if VM.Types.HasKey(VM.ModuleBinary.UInt32Value(i)) then
			        typ = VM.Types.Value(VM.ModuleBinary.UInt32Value(i))
			        result.Append typ.InstructionText
			      else
			        result.Append "Unknown"
			      end if
			      result.Append ")"
			      i = i + 4
			    wend
			    
			    // ***** OpTypeInt *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeInt
			    result.Append "TypeInt "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    if VM.ModuleBinary.UInt32Value(Offset + 12) = 0 then
			      result.Append " Unsigned"
			    else
			      result.Append " Signed"
			    end if
			    
			    // ***** OpTypePointer *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypePointer
			    result.Append "TypePointer "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append compose_type(Offset + 12)
			    
			    // ***** OpTypeStruct *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeStruct
			    result.Append "TypeStruct "
			    ub = offset + WordCount
			    i = Offset + 8
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      result.Append "("
			      if VM.Types.HasKey(VM.ModuleBinary.UInt32Value(i)) then
			        typ = VM.Types.Value(VM.ModuleBinary.UInt32Value(i))
			        result.Append typ.InstructionText
			      else
			        result.Append "Unknown"
			      end if
			      result.Append ")"
			      i = i + 4
			    wend
			    
			    // ***** OpTypeVector *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeVector
			    result.Append "TypeVector "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeVoid *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeVoid
			    result.Append "TypeVoid"
			    
			    // ***** OpVariable *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVariable
			    result.Append "Variable "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    if WordCount > 4 then
			      break // todo: optional initializer
			    end if
			    
			  case else
			    result.Append "Unknown"
			    
			  end select
			  
			  return Join(result, "")
			End Get
		#tag EndGetter
		InstructionText As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mResultType As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Offset As UInt32
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim result As UInt32
			  
			  result = 0
			  
			  select case Type
			    
			  case SPIRVOpcodeTypeEnum.OpConstant
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			  case SPIRVOpcodeTypeEnum.OpConstantComposite
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			  case SPIRVOpcodeTypeEnum.OpCompositeExtract
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			  case SPIRVOpcodeTypeEnum.OpExtInstImport
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpFunction
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			  case SPIRVOpcodeTypeEnum.OpFunctionParameter
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			  case SPIRVOpcodeTypeEnum.OpIAdd
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			  case SPIRVOpcodeTypeEnum.OpInBoundsAccessChain
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			  case SPIRVOpcodeTypeEnum.OpLabel
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpLoad
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			  case SPIRVOpcodeTypeEnum.OpTypeArray
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpTypeBool
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpTypeFloat
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpTypeFunction
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpTypeInt
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpTypePointer
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpTypeStruct
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpTypeVector
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpTypeVoid
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  case SPIRVOpcodeTypeEnum.OpVariable
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
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

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Dim result As String
			  
			  result = ""
			  
			  select case Type
			    
			  case SPIRVOpcodeTypeEnum.OpConstant, SPIRVOpcodeTypeEnum.OpConstantComposite, _
			    SPIRVOpcodeTypeEnum.OpCompositeExtract, SPIRVOpcodeTypeEnum.OpFunction, _
			    SPIRVOpcodeTypeEnum.OpFunctionParameter, SPIRVOpcodeTypeEnum.OpIAdd, _
			    SPIRVOpcodeTypeEnum.OpInBoundsAccessChain, SPIRVOpcodeTypeEnum.OpLoad, _
			    SPIRVOpcodeTypeEnum.OpVariable
			    
			    result = compose_type(Offset + 4)
			    
			  end select
			  
			  return result
			  
			End Get
		#tag EndGetter
		ResultType As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Type As SPIRVOpcodeTypeEnum
	#tag EndProperty

	#tag Property, Flags = &h0
		VM As ZocleeShade.SPIRVVirtualMachine
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return VM.ModuleBinary.UInt16Value(Offset + 2)
			End Get
		#tag EndGetter
		WordCount As UInt32
	#tag EndComputedProperty


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
			Name="ResultType"
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
			Type="SPIRVOpcodeTypeEnum"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unknown"
				"1 - OpCompositeExtract"
				"2 - OpConstant"
				"3 - OpConstantComposite"
				"4 - OpDecorate"
				"5 - OpEntryPoint"
				"6 - OpExtInstImport"
				"7 - OpFunction"
				"8 - OpFunctionEnd"
				"9 - OpFunctionParameter"
				"10 - OpIAdd"
				"11 - OpInBoundsAccessChain"
				"12 - OpLabel"
				"13 - OpLoad"
				"14 - OpMemberName"
				"15 - OpMemoryModel"
				"16 - OpName"
				"17 - OpTypeArray"
				"18 - OpTypeBool"
				"19 - OpTypeFloat"
				"20 - OpTypeFunction"
				"21 - OpTypeInt"
				"22 - OpTypePointer"
				"23 - OpTypeStruct"
				"24 - OpTypeVector"
				"25 - OpTypeVoid"
				"26 - OpReturn"
				"27 - OpSource"
				"28 - OpStore"
				"29 - OpVariable"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
