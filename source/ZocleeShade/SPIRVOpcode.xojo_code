#tag Class
Protected Class SPIRVOpcode
	#tag Method, Flags = &h21
		Private Function compose_id(binOffset As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result() As String
		  
		  result.Append Str(VM.ModuleBinary.UInt32Value(binOffset))
		  if VM.Names.HasKey(VM.ModuleBinary.UInt32Value(binOffset)) then
		    if Trim(VM.Names.Value(VM.ModuleBinary.UInt32Value(binOffset))) <> "" then
		      result.Append "("
		      result.Append VM.Names.Value(VM.ModuleBinary.UInt32Value(binOffset))
		      result.Append ")"
		    end if
		  end if
		  
		  return Join(result, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function compose_type(binOffset As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
			  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			  ' www.zoclee.com/shade
			  
			  Dim result() As String
			  Dim typ As ZocleeShade.SPIRVType
			  Dim i As UInt32
			  Dim ub As UInt32
			  
			  select case Type
			    
			    // ***** OpAccessChain *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAccessChain
			    result.Append "AccessChain "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    ub = offset + WordCount * 4
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpAll *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAll
			    result.Append "All "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpAny *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAny
			    result.Append "Any "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpArrayLength *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpArrayLength
			    result.Append "ArrayLength "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpAtomicAnd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicAnd
			    result.Append "AtomicAnd "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicCompareExchange *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicCompareExchange
			    result.Append "AtomicCompareExchange "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    result.Append " "
			    result.Append compose_id(Offset + 28)
			    
			    // ***** OpAtomicCompareExchangeWeak *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicCompareExchangeWeak
			    result.Append "AtomicCompareExchangeWeak "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    result.Append " "
			    result.Append compose_id(Offset + 28)
			    
			    // ***** OpAtomicExchange *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicExchange
			    result.Append "AtomicExchange "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIAdd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicIAdd
			    result.Append "AtomicIAdd "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicIDecrement *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicIDecrement
			    result.Append "AtomicIDecrement "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIIncrement *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicIIncrement
			    result.Append "AtomicIIncrement "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicISub *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicISub
			    result.Append "AtomicISub "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicInit *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicInit
			    result.Append "AtomicInit "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpAtomicLoad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicLoad
			    result.Append "AtomicLoad "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicOr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicOr
			    result.Append "AtomicOr "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicStore *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicStore
			    result.Append "AtomicStore "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpAtomicUMax *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicUMax
			    result.Append "AtomicUMax "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicUMin *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicUMin
			    result.Append "AtomicUMin "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicXor *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicXor
			    result.Append "OpAtomicXor "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpBitcast *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBitcast
			    result.Append "Bitcast "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpBitwiseAnd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBitwiseAnd
			    result.Append "BitwiseAnd "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBitwiseOr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBitwiseOr
			    result.Append "BitwiseOr "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBitwiseXor *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBitwiseXor
			    result.Append "BitwiseXor "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBranch *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBranch
			    result.Append "Branch "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpBranchConditional *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBranchConditional
			    result.Append "BranchConditional "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    ub = offset + WordCount * 4
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpCompositeConstruct *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCompositeConstruct
			    result.Append "CompositeConstruct"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpCompositeExtract *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCompositeExtract
			    result.Append "CompositeExtract "
			    result.Append compose_id(Offset + 12)
			    ub = offset + WordCount * 4
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpCompositeInsert *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCompositeInsert
			    result.Append "CompositeInsert "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    ub = offset + WordCount * 4
			    i = Offset + 20
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
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpConstantFalse *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConstantFalse
			    result.Append "ConstantFalse"
			    
			    // ***** OpConstantNullObject *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConstantNullObject
			    result.Append "ConstantNullObject"
			    
			    // ***** OpConstantNullPointer *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConstantNullPointer
			    result.Append "ConstantNullPointer"
			    
			    // ***** OpConstantSampler *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConstantSampler
			    result.Append "ConstantSampler "
			    result.Append SPIRVDescribeSamplerAddressingMode(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeParam(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeSamplerFilterMode(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpConstantTrue *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConstantTrue
			    result.Append "ConstantTrue"
			    
			    // ***** OpControlBarrier *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpControlBarrier
			    result.Append "ControlBarrier "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    
			    // ***** OpConvertFToS *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertFToS
			    result.Append "ConvertFToS "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertFToU *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertFToU
			    result.Append "ConvertFToU "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertPtrToU *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertPtrToU
			    result.Append "ConvertPtrToU "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertSToF *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertSToF
			    result.Append "ConvertSToF "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertUToF *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertUToF
			    result.Append "ConvertUToF "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** ConvertUToPtr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertUToPtr
			    result.Append "ConvertUToPtr "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCopyMemory *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCopyMemory
			    result.Append "CopyMemory "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append SPIRVDescribeMemoryAccessMask(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpCopyMemorySized *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCopyMemorySized
			    result.Append "CopyMemorySized "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    ub = offset + WordCount * 4
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append SPIRVDescribeMemoryAccessMask(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpCopyObject *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCopyObject
			    result.Append "CopyObject "
			    result.Append compose_id(Offset + 12)
			    
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
			      result.Append SPIRVDescribeFunctionParameterAttribute(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 41 // FP Rounding Mode
			      result.Append " "
			      result.Append SPIRVDescribeFPRoundingMode(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 42 // FP Fast Math Mode
			      result.Append " "
			      result.Append SPIRVDescribeFPFastMathModeMask(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 43 // Linkage Type
			      result.Append " "
			      result.Append SPIRVDescribeLinkageType(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 44 // SpecId
			      break
			    end select
			    
			    // ***** OpDecorationGroup *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDecorationGroup
			    result.Append "DecorationGroup"
			    
			    // ***** OpDot *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDot
			    result.Append "Dot "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpDPdx *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdx
			    result.Append "DPdx "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdxCoarse *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdxCoarse
			    result.Append "DPdxCoarse "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdxFine *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdxFine
			    result.Append "DPdxFine "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdy *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdy
			    result.Append "DPdy "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdyCoarse *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdyCoarse
			    result.Append "DPdyCoarse "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdyFine *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdyFine
			    result.Append "DPdyFine "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpEmitStreamVertex *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEmitStreamVertex
			    result.Append "EmitStreamVertex "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpEndStreamPrimitive *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEndStreamPrimitive
			    result.Append "EndStreamPrimitive "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpEmitVertex *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEmitVertex
			    result.Append "EmitVertex"
			    
			    // ***** OpEndPrimitive *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEndPrimitive
			    result.Append "EndPrimitive"
			    
			    // ***** OpEntryPoint *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEntryPoint
			    result.Append "EntryPoint "
			    result.Append SPIRVDescribeExecutionModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpExecutionMode *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpExecutionMode
			    result.Append "ExecutionMode "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionMode(VM.ModuleBinary.UInt32Value(Offset + 8))
			    select case VM.ModuleBinary.UInt32Value(Offset + 8)
			    case 0 // Invocations
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 16 // LocalSize
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    case 17 // LocalSize
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    case 25 // OutputVertices
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 29 // VecTypeHint
			      result.Append " "
			      result.Append compose_type(Offset + 12)
			    end select
			    
			    // ***** OpExtension *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpExtension
			    result.Append "Extension """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpExtInst *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpExtInst
			    result.Append "ExtInst "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    ub = offset + WordCount * 4
			    i = Offset + 20
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpExtInstImport *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpExtInstImport
			    result.Append "ExtInstImport """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpFAdd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFAdd
			    result.Append "FAdd "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFConvert *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFConvert
			    result.Append "FConvert "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFDiv *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFDiv
			    result.Append "FDiv "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFMod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFMod
			    result.Append "FMod "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFMul *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFMul
			    result.Append "FMul "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFNegate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFNegate
			    result.Append "FNegate "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFOrdEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdEqual
			    result.Append "FOrdEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdGreaterThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdGreaterThan
			    result.Append "FOrdGreaterThan "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdGreaterThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdGreaterThanEqual
			    result.Append "FOrdGreaterThanEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    
			    // ***** OpFOrdLessThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdLessThan
			    result.Append "FOrdLessThan "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdLessThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdLessThanEqual
			    result.Append "FOrdLessThanEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdNotEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdNotEqual
			    result.Append "FOrdNotEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFRem *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFRem
			    result.Append "FRem "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFSub *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFSub
			    result.Append "FSub "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFunction *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunction
			    result.Append "Function "
			    result.Append SPIRVDescribeFunctionControlMask(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_type(Offset + 16)
			    
			    // ***** OpFunctionCall *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunctionCall
			    result.Append "FunctionCall "
			    result.Append compose_id(Offset + 12)
			    ub = offset + WordCount * 4
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpFunctionEnd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunctionEnd
			    result.Append "FunctionEnd"
			    
			    // ***** OpFunctionParameter *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunctionParameter
			    result.Append "FunctionParameter"
			    
			    // ***** OpFUnordEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordEqual
			    result.Append "FUnordEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordGreaterThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordGreaterThan
			    result.Append "FUnordGreaterThan "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordGreaterThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordGreaterThanEqual
			    result.Append "FUnordGreaterThanEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordLessThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordLessThan
			    result.Append "FUnordLessThan "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordLessThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordLessThanEqual
			    result.Append "FUnordLessThanEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordNotEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordNotEqual
			    result.Append "FUnordNotEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFwidth *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFwidth
			    result.Append "Fwidth "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFwidthCoarse *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFwidthCoarse
			    result.Append "FwidthCoarse "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFwidthFine *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFwidthFine
			    result.Append "FwidthFine "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGenericCastToPtr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGenericCastToPtr
			    result.Append "GenericCastToPtr "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupDecorate
			    result.Append "GroupDecorate "
			    result.Append compose_id(Offset + 4)
			    ub = offset + WordCount * 4
			    i = Offset + 8
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpGroupMemberDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupMemberDecorate
			    result.Append "GroupMemberDecorate "
			    result.Append compose_id(Offset + 4)
			    ub = offset + WordCount * 4
			    i = Offset + 8
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpIAdd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIAdd
			    result.Append "IAdd "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIEqual
			    result.Append "IEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpImagePointer *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpImagePointer
			    result.Append "ImagePointer "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpIMul *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIMul
			    result.Append "IMul "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpInBoundsAccessChain *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpInBoundsAccessChain
			    result.Append "InBoundsAccessChain "
			    result.Append compose_id(Offset + 12)
			    ub = offset + WordCount * 4
			    i = Offset + 16
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpINotEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpINotEqual
			    result.Append "INotEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIsFinite *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsFinite
			    result.Append "IsFinite "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsInf *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsInf
			    result.Append "IsInf "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsNan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsNan
			    result.Append "IsNan "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsNormal *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsNormal
			    result.Append "IsNormal "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpISub *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpISub
			    result.Append "ISub "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLabel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLabel
			    result.Append "Label"
			    
			    // ***** OpLessOrGreater *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLessOrGreater
			    result.Append "LessOrGreater "
			    result.Append compose_id(Offset + 12)
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLine *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLine
			    result.Append "Line "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpLoad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLoad
			    result.Append "Load "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpLogicalAnd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLogicalAnd
			    result.Append "LogicalAnd "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLogicalOr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLogicalOr
			    result.Append "LogicalOr "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLogicalXor *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLogicalXor
			    result.Append "LogicalXor "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLoopMerge *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLoopMerge
			    result.Append "LoopMerge "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeLoopControlMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpMatrixTimesMatrix *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMatrixTimesMatrix
			    result.Append "MatrixTimesMatrix "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMatrixTimesScalar *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMatrixTimesScalar
			    result.Append "MatrixTimesScalar "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMatrixTimesVector *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMatrixTimesVector
			    result.Append "MatrixTimesVector "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMemberDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMemberDecorate
			    result.Append "MemberDecorate "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append SPIRVDescribeDecoration(VM.ModuleBinary.UInt32Value(Offset + 12))
			    select case VM.ModuleBinary.UInt32Value(Offset + 12)
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
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    case 37 // XfbBuffer
			      break
			    case 38 // Stride
			      break
			    case 39 // Built-In
			      result.Append " "
			      result.Append SPIRVDescribeBuiltIn(VM.ModuleBinary.UInt32Value(Offset + 16))
			    case 40 // FuncParamAttr
			      result.Append " "
			      result.Append SPIRVDescribeFunctionParameterAttribute(VM.ModuleBinary.UInt32Value(Offset + 16))
			    case 41 // FP Rounding Mode
			      result.Append " "
			      result.Append SPIRVDescribeFPRoundingMode(VM.ModuleBinary.UInt32Value(Offset + 16))
			    case 42 // FP Fast Math Mode
			      result.Append " "
			      result.Append SPIRVDescribeFPFastMathModeMask(VM.ModuleBinary.UInt32Value(Offset + 16))
			    case 43 // Linkage Type
			      result.Append " "
			      result.Append SPIRVDescribeLinkageType(VM.ModuleBinary.UInt32Value(Offset + 16))
			    case 44 // SpecId
			      break
			    end select
			    
			    // ***** OpMemberName *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMemberName
			    result.Append "MemberName "
			    result.Append compose_type(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 12)
			    result.Append """"
			    
			    // ***** OpMemoryBarrier *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMemoryBarrier
			    result.Append "MemoryBarrier "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
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
			    
			    // ***** OpNop *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpNop
			    result.Append "Nop"
			    
			    // ***** OpNot *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpNot
			    result.Append "Not "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpOrdered *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpOrdered
			    result.Append "Ordered "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpOuterProduct *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpOuterProduct
			    result.Append "OuterProduct "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpPhi *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpPhi
			    result.Append "Phi "
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpPtrCastToGeneric *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpPtrCastToGeneric
			    result.Append "PtrCastToGeneric "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpReturn *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReturn
			    result.Append "Return"
			    
			    // ***** OpSampler *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSampler
			    result.Append "Sampler "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSConvert *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSConvert
			    result.Append "SConvert "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSDiv *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSDiv
			    result.Append "SDiv "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSelect *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSelect
			    result.Append "Select "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpSelectionMerge *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSelectionMerge
			    result.Append "SelectionMerge "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeSelectionControlMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSGreaterThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSGreaterThan
			    result.Append "SGreaterThan "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSGreaterThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSGreaterThanEqual
			    result.Append "SGreaterThanEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftLeftLogical *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpShiftLeftLogical
			    result.Append "ShiftLeftLogical "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftRightArithmetic *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpShiftRightArithmetic
			    result.Append "ShiftRightArithmetic "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftRightLogical *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpShiftRightLogical
			    result.Append "ShiftRightLogical "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSignBitSet *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSignBitSet
			    result.Append "SignBitSet "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSLessThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSLessThan
			    result.Append "SLessThan "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSLessThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSLessThanEqual
			    result.Append "SLessThanEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSMod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSMod
			    result.Append "SMod "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSNegate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSNegate
			    result.Append "SNegate "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSource *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSource
			    result.Append "Source "
			    result.Append SPIRVDescribeSourceLanguage(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSourceExtension *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSourceExtension
			    result.Append "SourceExtension """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpSpecConstant *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSpecConstant
			    result.Append "SpecConstant "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpSpecConstantComposite *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSpecConstantComposite
			    result.Append "SpecConstantComposite "
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpSpecConstantFalse *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSpecConstantFalse
			    result.Append "SpecConstantFalse"
			    
			    // ***** OpSpecConstantTrue *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSpecConstantTrue
			    result.Append "SpecConstantTrue"
			    
			    // ***** OpSRem *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSRem
			    result.Append "SRem "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpStore *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpStore
			    result.Append "Store "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append SPIRVDescribeMemoryAccessMask(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpString *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpString
			    result.Append "String """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpTextureFetchSample *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureFetchSample
			    result.Append "TextureFetchSample "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureFetchTexel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureFetchTexel
			    result.Append "TextureFetchTexel "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureFetchTexelLod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureFetchTexelLod
			    result.Append "TextureFetchTexelLod "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureFetchTexel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureFetchTexelOffset
			    result.Append "TextureFetchTexelOffset "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureGather *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureGather
			    result.Append "TextureGather "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpTextureGatherOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureGatherOffset
			    result.Append "TextureGatherOffset "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureGatherOffsets *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureGatherOffsets
			    result.Append "TextureGatherOffsets "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureQueryLevels *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQueryLevels
			    result.Append "TextureQueryLevels "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQueryLod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQueryLod
			    result.Append "TextureQueryLod "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureQuerySamples *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQuerySamples
			    result.Append "TextureQuerySamples "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQuerySize *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQuerySize
			    result.Append "TextureQuerySize "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQuerySizeLod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQuerySizeLod
			    result.Append "TextureQuerySizeLod "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureSample *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSample
			    result.Append "TextureSample "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    if WordCount = 6 then
			      result.Append " "
			      result.Append compose_id(Offset + 20)
			    end if
			    
			    // ***** OpTextureSampleDref *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleDref
			    result.Append "TextureSampleDref "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleGrad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleGrad
			    result.Append "TextureSampleGrad "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureSampleGradOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleGradOffset
			    result.Append "TextureSampleGradOffset "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    result.Append " "
			    result.Append compose_id(Offset + 28)
			    
			    // ***** OpTextureSampleLod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleLod
			    result.Append "TextureSampleLod "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleLodOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleLodOffset
			    result.Append "TextureSampleLodOffset "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureSampleOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleOffset
			    result.Append "TextureSampleOffset "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    if WordCount = 7 then
			      result.Append " "
			      result.Append compose_id(Offset + 24)
			    end if
			    
			    // ***** OpTextureSampleProj *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProj
			    result.Append "TextureSampleProj "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    if WordCount = 6 then
			      result.Append " "
			      result.Append compose_id(Offset + 20)
			    end if
			    
			    // ***** OpTextureSampleProjGrad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjGrad
			    result.Append "TextureSampleProjGrad "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureSampleProjGradOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjGradOffset
			    result.Append "TextureSampleProjGradOffset "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    result.Append " "
			    result.Append compose_id(Offset + 28)
			    
			    // ***** OpTextureSampleProjLod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjLod
			    result.Append "TextureSampleProjLod "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleProjLodOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjLodOffset
			    result.Append "TextureSampleProjLodOffset "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureSampleProjOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjOffset
			    result.Append "TextureSampleProjOffset "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    if WordCount = 7 then
			      result.Append " "
			      result.Append compose_id(Offset + 24)
			    end if
			    
			    // ***** OpTranspose *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTranspose
			    result.Append "Transpose "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTypeArray *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeArray
			    result.Append "TypeArray "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeBool *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeBool
			    result.Append "TypeBool"
			    
			    // ***** OpTypeDeviceEvent *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeDeviceEvent
			    result.Append "TypeDeviceEvent"
			    
			    // ***** OpTypeEvent *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeEvent
			    result.Append "TypeEvent"
			    
			    // ***** OpTypeFilter *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeFilter
			    result.Append "TypeFilter"
			    
			    // ***** OpTypeFloat *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeFloat
			    result.Append "TypeFloat "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpTypeFunction *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeFunction
			    result.Append "TypeFunction "
			    result.Append compose_type(Offset + 8)
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_type(i)
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
			    
			    // ***** OpTypeMatrix *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeMatrix
			    result.Append "TypeMatrix "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeOpaque *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeOpaque
			    result.Append "TypeOpaque """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpTypePipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypePipe
			    result.Append "TypePipe "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append SPIRVDescribeAccessQualifier(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypePointer *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypePointer
			    result.Append "TypePointer "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append compose_type(Offset + 12)
			    
			    // ***** OpTypeQueue *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeQueue
			    result.Append "TypeQueue"
			    
			    // ***** OpTypeReserveId *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeReserveId
			    result.Append "TypeReserveId"
			    
			    // ***** OpTypeRuntimeArray *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeRuntimeArray
			    result.Append "TypeRuntimeArray "
			    result.Append compose_type(Offset + 8)
			    
			    // ***** OpTypeSampler *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeSampler
			    result.Append "TypeSampler "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append SPIRVDescribeDimensionality(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeContent(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeArrayed(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append SPIRVDescribeCompare(VM.ModuleBinary.UInt32Value(Offset + 24))
			    result.Append " "
			    result.Append SPIRVDescribeMultisampled(VM.ModuleBinary.UInt32Value(Offset + 28))
			    result.Append " "
			    if WordCount >= 9 then
			      result.Append SPIRVDescribeAccessQualifier(VM.ModuleBinary.UInt32Value(Offset + 32))
			    else
			      result.Append SPIRVDescribeAccessQualifier(0)
			    end if
			    
			    // ***** OpTypeStruct *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeStruct
			    result.Append "TypeStruct "
			    ub = offset + WordCount * 4
			    i = Offset + 8
			    while i < ub
			      result.Append " "
			      result.Append compose_type(i)
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
			    
			    // ***** OpUConvert *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUConvert
			    result.Append "UConvert "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpUDiv *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUDiv
			    result.Append "UDiv "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUGreaterThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUGreaterThan
			    result.Append "UGreaterThan "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUGreaterThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUGreaterThanEqual
			    result.Append "UGreaterThanEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpULessThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpULessThan
			    result.Append "ULessThan "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpULessThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpULessThanEqual
			    result.Append "ULessThanEqual "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUMod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUMod
			    result.Append "UMod "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUndef *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUndef
			    result.Append "Undef"
			    
			    // ***** OpUnordered *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUnordered
			    result.Append "Unordered "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpVariable *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVariable
			    result.Append "Variable "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    if WordCount > 4 then
			      break // todo: optional initializer
			    end if
			    
			    // ***** OpVariableArray *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVariableArray
			    result.Append "VariableArray "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpVectorExtractDynamic *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorExtractDynamic
			    result.Append "VectorExtractDynamic "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpVectorInsertDynamic *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorInsertDynamic
			    result.Append "VectorInsertDynamic "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpVectorShuffle *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorShuffle
			    result.Append "VectorShuffle "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    ub = offset + WordCount * 4
			    i = Offset + 20
			    while i < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			    wend
			    
			    // ***** OpVectorTimesScalar *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorTimesScalar
			    result.Append "VectorTimesScalar "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpVectorTimesMatrix *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorTimesMatrix
			    result.Append "VectorTimesMatrix "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    
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
			  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			  ' www.zoclee.com/shade
			  
			  Dim result As UInt32
			  
			  result = 0
			  
			  select case Type
			    
			  case SPIRVOpcodeTypeEnum.OpAccessChain, SPIRVOpcodeTypeEnum.OpAll, _
			    SPIRVOpcodeTypeEnum.OpAny, _
			    SPIRVOpcodeTypeEnum.OpArrayLength, _
			    SPIRVOpcodeTypeEnum.OpAtomicAnd, _
			    SPIRVOpcodeTypeEnum.OpAtomicCompareExchange, SPIRVOpcodeTypeEnum.OpAtomicCompareExchangeWeak, _
			    SPIRVOpcodeTypeEnum.OpAtomicExchange, _
			    SPIRVOpcodeTypeEnum.OpAtomicIAdd, _
			    SPIRVOpcodeTypeEnum.OpAtomicIDecrement, SPIRVOpcodeTypeEnum.OpAtomicIIncrement, _
			    SPIRVOpcodeTypeEnum.OpAtomicISub, _
			    SPIRVOpcodeTypeEnum.OpAtomicLoad, _
			    SPIRVOpcodeTypeEnum.OpAtomicOr, _
			    SPIRVOpcodeTypeEnum.OpAtomicUMax, _
			    SPIRVOpcodeTypeEnum.OpAtomicUMin, _
			    SPIRVOpcodeTypeEnum.OpAtomicXor, _
			    SPIRVOpcodeTypeEnum.OpBitcast, _
			    SPIRVOpcodeTypeEnum.OpBitwiseAnd, _
			    SPIRVOpcodeTypeEnum.OpBitwiseOr, _
			    SPIRVOpcodeTypeEnum.OpBitwiseXor, _
			    SPIRVOpcodeTypeEnum.OpCompositeConstruct, _
			    SPIRVOpcodeTypeEnum.OpCompositeExtract, SPIRVOpcodeTypeEnum.OpCompositeInsert, _
			    SPIRVOpcodeTypeEnum.OpConstant, SPIRVOpcodeTypeEnum.OpConstantComposite, _
			    SPIRVOpcodeTypeEnum.OpConstantFalse, SPIRVOpcodeTypeEnum.OpConstantNullObject, _
			    SPIRVOpcodeTypeEnum.OpConstantNullPointer, _
			    SPIRVOpcodeTypeEnum.OpConstantSampler, SPIRVOpcodeTypeEnum.OpConstantTrue, _
			    SPIRVOpcodeTypeEnum.OpConvertFToS, _
			    SPIRVOpcodeTypeEnum.OpConvertFToU, _
			    SPIRVOpcodeTypeEnum.OpConvertPtrToU, _
			    SPIRVOpcodeTypeEnum.OpConvertSToF, _
			    SPIRVOpcodeTypeEnum.OpConvertUToF, _
			    SPIRVOpcodeTypeEnum.OpConvertUToPtr, _
			    SPIRVOpcodeTypeEnum.OpCopyObject, _
			    SPIRVOpcodeTypeEnum.OpDot, _
			    SPIRVOpcodeTypeEnum.OpDPdx, SPIRVOpcodeTypeEnum.OpDPdxCoarse, _
			    SPIRVOpcodeTypeEnum.OpDPdxFine, _
			    SPIRVOpcodeTypeEnum.OpDPdy, SPIRVOpcodeTypeEnum.OpDPdyCoarse, _
			    SPIRVOpcodeTypeEnum.OpDPdyFine, _
			    SPIRVOpcodeTypeEnum.OpExtInst, _
			    SPIRVOpcodeTypeEnum.OpFAdd, SPIRVOpcodeTypeEnum.OpFConvert, _
			    SPIRVOpcodeTypeEnum.OpFDiv, _
			    SPIRVOpcodeTypeEnum.OpFMod, _
			    SPIRVOpcodeTypeEnum.OpFMul, _
			    SPIRVOpcodeTypeEnum.OpFNegate, _
			    SPIRVOpcodeTypeEnum.OpFOrdEqual, _
			    SPIRVOpcodeTypeEnum.OpFOrdGreaterThan, _
			    SPIRVOpcodeTypeEnum.OpFOrdGreaterThanEqual, _
			    SPIRVOpcodeTypeEnum.OpFOrdLessThan, _
			    SPIRVOpcodeTypeEnum.OpFOrdLessThanEqual, _
			    SPIRVOpcodeTypeEnum.OpFOrdNotEqual, _
			    SPIRVOpcodeTypeEnum.OpFRem, _
			    SPIRVOpcodeTypeEnum.OpFSub, SPIRVOpcodeTypeEnum.OpFunction, _
			    SPIRVOpcodeTypeEnum.OpFunctionCall, SPIRVOpcodeTypeEnum.OpFunctionParameter, _
			    SPIRVOpcodeTypeEnum.OpFUnordEqual, _
			    SPIRVOpcodeTypeEnum.OpFUnordGreaterThan, _
			    SPIRVOpcodeTypeEnum.OpFUnordGreaterThanEqual, _
			    SPIRVOpcodeTypeEnum.OpFUnordLessThan, _
			    SPIRVOpcodeTypeEnum.OpFUnordLessThanEqual, _
			    SPIRVOpcodeTypeEnum.OpFUnordNotEqual, _
			    SPIRVOpcodeTypeEnum.OpFwidth, SPIRVOpcodeTypeEnum.OpFwidthCoarse, _
			    SPIRVOpcodeTypeEnum.OpFwidthFine, _
			    SPIRVOpcodeTypeEnum.OpGenericCastToPtr, _
			    SPIRVOpcodeTypeEnum.OpIAdd, _
			    SPIRVOpcodeTypeEnum.OpIEqual, _
			    SPIRVOpcodeTypeEnum.OpImagePointer, _
			    SPIRVOpcodeTypeEnum.OpIMul, _
			    SPIRVOpcodeTypeEnum.OpInBoundsAccessChain, _
			    SPIRVOpcodeTypeEnum.OpINotEqual, _
			    SPIRVOpcodeTypeEnum.OpIsFinite, _
			    SPIRVOpcodeTypeEnum.OpIsInf, _
			    SPIRVOpcodeTypeEnum.OpIsNan, _
			    SPIRVOpcodeTypeEnum.OpIsNormal, _
			    SPIRVOpcodeTypeEnum.OpISub, _
			    SPIRVOpcodeTypeEnum.OpLessOrGreater, _
			    SPIRVOpcodeTypeEnum.OpLoad, _
			    SPIRVOpcodeTypeEnum.OpLogicalAnd, _
			    SPIRVOpcodeTypeEnum.OpLogicalOr, _
			    SPIRVOpcodeTypeEnum.OpLogicalXor, _
			    SPIRVOpcodeTypeEnum.OpMatrixTimesMatrix, _
			    SPIRVOpcodeTypeEnum.OpMatrixTimesScalar, _
			    SPIRVOpcodeTypeEnum.OpMatrixTimesVector, _
			    SPIRVOpcodeTypeEnum.OpNot, _
			    SPIRVOpcodeTypeEnum.OpOrdered, _
			    SPIRVOpcodeTypeEnum.OpOuterProduct, _
			    SPIRVOpcodeTypeEnum.OpPhi, _
			    SPIRVOpcodeTypeEnum.OpPtrCastToGeneric, _
			    SPIRVOpcodeTypeEnum.OpSampler, SPIRVOpcodeTypeEnum.OpSConvert, _
			    SPIRVOpcodeTypeEnum.OpSDiv, _
			    SPIRVOpcodeTypeEnum.OpSelect, _
			    SPIRVOpcodeTypeEnum.OpShiftLeftLogical, _
			    SPIRVOpcodeTypeEnum.OpShiftRightArithmetic, _
			    SPIRVOpcodeTypeEnum.OpShiftRightLogical, _
			    SPIRVOpcodeTypeEnum.OpSignBitSet, _
			    SPIRVOpcodeTypeEnum.OpSGreaterThan, _
			    SPIRVOpcodeTypeEnum.OpSGreaterThanEqual, _
			    SPIRVOpcodeTypeEnum.OpSLessThan, _
			    SPIRVOpcodeTypeEnum.OpSLessThanEqual, _
			    SPIRVOpcodeTypeEnum.OpSMod, _
			    SPIRVOpcodeTypeEnum.OpSNegate, _
			    SPIRVOpcodeTypeEnum.OpSpecConstant, SPIRVOpcodeTypeEnum.OpSpecConstantFalse, _
			    SPIRVOpcodeTypeEnum.OpSpecConstantComposite, SPIRVOpcodeTypeEnum.OpSpecConstantTrue, _
			    SPIRVOpcodeTypeEnum.OpSRem, _
			    SPIRVOpcodeTypeEnum.OpTextureFetchSample, _
			    SPIRVOpcodeTypeEnum.OpTextureFetchTexel, _
			    SPIRVOpcodeTypeEnum.OpTextureFetchTexelLod, SPIRVOpcodeTypeEnum.OpTextureFetchTexelOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureGather, SPIRVOpcodeTypeEnum.OpTextureGatherOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureGatherOffsets, SPIRVOpcodeTypeEnum.OpTextureQueryLevels, _
			    SPIRVOpcodeTypeEnum.OpTextureQueryLod, SPIRVOpcodeTypeEnum.OpTextureQuerySamples, _
			    SPIRVOpcodeTypeEnum.OpTextureQuerySize, SPIRVOpcodeTypeEnum.OpTextureQuerySizeLod, _
			    SPIRVOpcodeTypeEnum.OpTextureSample, SPIRVOpcodeTypeEnum.OpTextureSampleDref, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleGrad, SPIRVOpcodeTypeEnum.OpTextureSampleGradOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleLod, SPIRVOpcodeTypeEnum.OpTextureSampleLodOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleOffset, SPIRVOpcodeTypeEnum.OpTextureSampleProj, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleProjGrad, SPIRVOpcodeTypeEnum.OpTextureSampleProjGradOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleProjLod, SPIRVOpcodeTypeEnum.OpTextureSampleProjLodOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleProjOffset, SPIRVOpcodeTypeEnum.OpTranspose, _
			    SPIRVOpcodeTypeEnum.OpUConvert, _
			    SPIRVOpcodeTypeEnum.OpUDiv, _
			    SPIRVOpcodeTypeEnum.OpUGreaterThan, _
			    SPIRVOpcodeTypeEnum.OpUGreaterThanEqual, _
			    SPIRVOpcodeTypeEnum.OpULessThan, _
			    SPIRVOpcodeTypeEnum.OpULessThanEqual, _
			    SPIRVOpcodeTypeEnum.OpUMod, _
			    SPIRVOpcodeTypeEnum.OpUndef, _
			    SPIRVOpcodeTypeEnum.OpUnordered, _
			    SPIRVOpcodeTypeEnum.OpVariable, SPIRVOpcodeTypeEnum.OpVariableArray, _
			    SPIRVOpcodeTypeEnum.OpVectorExtractDynamic, SPIRVOpcodeTypeEnum.OpVectorInsertDynamic, _
			    SPIRVOpcodeTypeEnum.OpVectorShuffle, _
			    SPIRVOpcodeTypeEnum.OpVectorTimesMatrix, _
			    SPIRVOpcodeTypeEnum.OpVectorTimesScalar
			    
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			    
			  case SPIRVOpcodeTypeEnum.OpDecorationGroup, SPIRVOpcodeTypeEnum.OpExtInstImport, _
			    SPIRVOpcodeTypeEnum.OpLabel, SPIRVOpcodeTypeEnum.OpString, _
			    SPIRVOpcodeTypeEnum.OpTypeArray, SPIRVOpcodeTypeEnum.OpTypeBool, _
			    SPIRVOpcodeTypeEnum.OpTypeDeviceEvent, SPIRVOpcodeTypeEnum.OpTypeEvent, _
			    SPIRVOpcodeTypeEnum.OpTypeFilter, SPIRVOpcodeTypeEnum.OpTypeFloat, _
			    SPIRVOpcodeTypeEnum.OpTypeFunction, SPIRVOpcodeTypeEnum.OpTypeInt, _
			    SPIRVOpcodeTypeEnum.OpTypeMatrix, SPIRVOpcodeTypeEnum.OpTypeOpaque, _
			    SPIRVOpcodeTypeEnum.OpTypePipe, SPIRVOpcodeTypeEnum.OpTypePointer, _
			    SPIRVOpcodeTypeEnum.OpTypeQueue, SPIRVOpcodeTypeEnum.OpTypeReserveId, _
			    SPIRVOpcodeTypeEnum.OpTypeRuntimeArray, SPIRVOpcodeTypeEnum.OpTypeSampler, _
			    SPIRVOpcodeTypeEnum.OpTypeStruct, SPIRVOpcodeTypeEnum.OpTypeVector, _
			    SPIRVOpcodeTypeEnum.OpTypeVoid
			    
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			    
			  end select
			  
			  return result
			  
			End Get
		#tag EndGetter
		ResultID As UInt32
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			  ' www.zoclee.com/shade
			  
			  Dim result As String
			  
			  result = ""
			  
			  select case Type
			    
			  case SPIRVOpcodeTypeEnum.OpAccessChain, SPIRVOpcodeTypeEnum.OpAll, _
			    SPIRVOpcodeTypeEnum.OpAny, _
			    SPIRVOpcodeTypeEnum.OpArrayLength, _
			    SPIRVOpcodeTypeEnum.OpAtomicAnd, _
			    SPIRVOpcodeTypeEnum.OpAtomicCompareExchange, SPIRVOpcodeTypeEnum.OpAtomicCompareExchangeWeak, _
			    SPIRVOpcodeTypeEnum.OpAtomicExchange, _
			    SPIRVOpcodeTypeEnum.OpAtomicIAdd, _
			    SPIRVOpcodeTypeEnum.OpAtomicIDecrement, SPIRVOpcodeTypeEnum.OpAtomicIIncrement, _
			    SPIRVOpcodeTypeEnum.OpAtomicISub, _
			    SPIRVOpcodeTypeEnum.OpAtomicLoad, _
			    SPIRVOpcodeTypeEnum.OpAtomicOr, _
			    SPIRVOpcodeTypeEnum.OpAtomicUMax, _
			    SPIRVOpcodeTypeEnum.OpAtomicUMin, _
			    SPIRVOpcodeTypeEnum.OpAtomicXor, _
			    SPIRVOpcodeTypeEnum.OpBitcast, _
			    SPIRVOpcodeTypeEnum.OpBitwiseAnd, _
			    SPIRVOpcodeTypeEnum.OpBitwiseOr, _
			    SPIRVOpcodeTypeEnum.OpBitwiseXor, _
			    SPIRVOpcodeTypeEnum.OpCompositeConstruct, SPIRVOpcodeTypeEnum.OpCompositeExtract, _
			    SPIRVOpcodeTypeEnum.OpCompositeInsert, _
			    SPIRVOpcodeTypeEnum.OpConstant, _
			    SPIRVOpcodeTypeEnum.OpConstantComposite, SPIRVOpcodeTypeEnum.OpConstantFalse, _
			    SPIRVOpcodeTypeEnum.OpConstantNullObject, SPIRVOpcodeTypeEnum.OpConstantNullPointer, _
			    SPIRVOpcodeTypeEnum.OpConstantSampler, SPIRVOpcodeTypeEnum.OpConstantTrue, _
			    SPIRVOpcodeTypeEnum.OpConvertFToS, _
			    SPIRVOpcodeTypeEnum.OpConvertFToU, _
			    SPIRVOpcodeTypeEnum.OpConvertPtrToU, _
			    SPIRVOpcodeTypeEnum.OpConvertSToF, _
			    SPIRVOpcodeTypeEnum.OpConvertUToF, _
			    SPIRVOpcodeTypeEnum.OpConvertUToPtr, _
			    SPIRVOpcodeTypeEnum.OpCopyObject, _
			    SPIRVOpcodeTypeEnum.OpDot, _
			    SPIRVOpcodeTypeEnum.OpDPdx, SPIRVOpcodeTypeEnum.OpDPdxCoarse, _
			    SPIRVOpcodeTypeEnum.OpDPdxFine, _
			    SPIRVOpcodeTypeEnum.OpDPdy, SPIRVOpcodeTypeEnum.OpDPdyCoarse, _
			    SPIRVOpcodeTypeEnum.OpDPdyFine, _
			    SPIRVOpcodeTypeEnum.OpExtInst, _
			    SPIRVOpcodeTypeEnum.OpFAdd, _
			    SPIRVOpcodeTypeEnum.OpFConvert, _
			    SPIRVOpcodeTypeEnum.OpFDiv, _
			    SPIRVOpcodeTypeEnum.OpFMod, _
			    SPIRVOpcodeTypeEnum.OpFMul, _
			    SPIRVOpcodeTypeEnum.OpFNegate, _
			    SPIRVOpcodeTypeEnum.OpFOrdEqual, _
			    SPIRVOpcodeTypeEnum.OpFOrdGreaterThan, _
			    SPIRVOpcodeTypeEnum.OpFOrdGreaterThanEqual, _
			    SPIRVOpcodeTypeEnum.OpFOrdLessThan, _
			    SPIRVOpcodeTypeEnum.OpFOrdLessThanEqual, _
			    SPIRVOpcodeTypeEnum.OpFOrdNotEqual, _
			    SPIRVOpcodeTypeEnum.OpFRem, _
			    SPIRVOpcodeTypeEnum.OpFSub, _
			    SPIRVOpcodeTypeEnum.OpFunction, SPIRVOpcodeTypeEnum.OpFunctionCall, _
			    SPIRVOpcodeTypeEnum.OpFunctionParameter, _
			    SPIRVOpcodeTypeEnum.OpFUnordEqual, _
			    SPIRVOpcodeTypeEnum.OpFUnordGreaterThan, _
			    SPIRVOpcodeTypeEnum.OpFUnordGreaterThanEqual, _
			    SPIRVOpcodeTypeEnum.OpFUnordLessThan, _
			    SPIRVOpcodeTypeEnum.OpFUnordLessThanEqual, _
			    SPIRVOpcodeTypeEnum.OpFUnordNotEqual, _
			    SPIRVOpcodeTypeEnum.OpFwidth, SPIRVOpcodeTypeEnum.OpFwidthCoarse, _
			    SPIRVOpcodeTypeEnum.OpFwidthFine, _
			    SPIRVOpcodeTypeEnum.OpGenericCastToPtr, _
			    SPIRVOpcodeTypeEnum.OpIAdd, _
			    SPIRVOpcodeTypeEnum.OpIEqual, _
			    SPIRVOpcodeTypeEnum.OpImagePointer, _
			    SPIRVOpcodeTypeEnum.OpIMul, _
			    SPIRVOpcodeTypeEnum.OpInBoundsAccessChain, _
			    SPIRVOpcodeTypeEnum.OpINotEqual, _
			    SPIRVOpcodeTypeEnum.OpIsFinite, _
			    SPIRVOpcodeTypeEnum.OpIsInf, _
			    SPIRVOpcodeTypeEnum.OpIsNan, _
			    SPIRVOpcodeTypeEnum.OpIsNormal, _
			    SPIRVOpcodeTypeEnum.OpISub, _
			    SPIRVOpcodeTypeEnum.OpLessOrGreater, _
			    SPIRVOpcodeTypeEnum.OpLoad, _
			    SPIRVOpcodeTypeEnum.OpLogicalAnd, _
			    SPIRVOpcodeTypeEnum.OpLogicalOr, _
			    SPIRVOpcodeTypeEnum.OpLogicalXor, _
			    SPIRVOpcodeTypeEnum.OpMatrixTimesMatrix, _
			    SPIRVOpcodeTypeEnum.OpMatrixTimesScalar, _
			    SPIRVOpcodeTypeEnum.OpMatrixTimesVector, _
			    SPIRVOpcodeTypeEnum.OpNot, _
			    SPIRVOpcodeTypeEnum.OpOrdered, _
			    SPIRVOpcodeTypeEnum.OpOuterProduct, _
			    SPIRVOpcodeTypeEnum.OpPhi, _
			    SPIRVOpcodeTypeEnum.OpPtrCastToGeneric, _
			    SPIRVOpcodeTypeEnum.OpSampler, _
			    SPIRVOpcodeTypeEnum.OpSConvert, _
			    SPIRVOpcodeTypeEnum.OpSDiv, _
			    SPIRVOpcodeTypeEnum.OpSelect, _
			    SPIRVOpcodeTypeEnum.OpShiftLeftLogical, _
			    SPIRVOpcodeTypeEnum.OpShiftRightArithmetic, _
			    SPIRVOpcodeTypeEnum.OpShiftRightLogical, _
			    SPIRVOpcodeTypeEnum.OpSignBitSet, _
			    SPIRVOpcodeTypeEnum.OpSGreaterThan, _
			    SPIRVOpcodeTypeEnum.OpSGreaterThanEqual, _
			    SPIRVOpcodeTypeEnum.OpSLessThan, _
			    SPIRVOpcodeTypeEnum.OpSLessThanEqual, _
			    SPIRVOpcodeTypeEnum.OpSMod, _
			    SPIRVOpcodeTypeEnum.OpSNegate, _
			    SPIRVOpcodeTypeEnum.OpSpecConstant, _
			    SPIRVOpcodeTypeEnum.OpSpecConstantComposite, SPIRVOpcodeTypeEnum.OpSpecConstantFalse, _
			    SPIRVOpcodeTypeEnum.OpSpecConstantTrue, _
			    SPIRVOpcodeTypeEnum.OpSRem, _
			    SPIRVOpcodeTypeEnum.OpTextureFetchSample, _
			    SPIRVOpcodeTypeEnum.OpTextureFetchTexel, _
			    SPIRVOpcodeTypeEnum.OpTextureFetchTexelLod, SPIRVOpcodeTypeEnum.OpTextureFetchTexelOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureGather, SPIRVOpcodeTypeEnum.OpTextureGatherOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureGatherOffsets, SPIRVOpcodeTypeEnum.OpTextureQueryLevels, _
			    SPIRVOpcodeTypeEnum.OpTextureQueryLod, SPIRVOpcodeTypeEnum.OpTextureQuerySamples, _
			    SPIRVOpcodeTypeEnum.OpTextureQuerySize, SPIRVOpcodeTypeEnum.OpTextureQuerySizeLod, _
			    SPIRVOpcodeTypeEnum.OpTextureSample, SPIRVOpcodeTypeEnum.OpTextureSampleDref, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleGrad, SPIRVOpcodeTypeEnum.OpTextureSampleGradOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleLod, SPIRVOpcodeTypeEnum.OpTextureSampleLodOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleProj, SPIRVOpcodeTypeEnum.OpTextureSampleProjGrad, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleProjGradOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleProjLod, SPIRVOpcodeTypeEnum.OpTextureSampleProjLodOffset, _
			    SPIRVOpcodeTypeEnum.OpTextureSampleProjOffset, _
			    SPIRVOpcodeTypeEnum.OpTranspose, _
			    SPIRVOpcodeTypeEnum.OpUConvert, _
			    SPIRVOpcodeTypeEnum.OpUDiv, _
			    SPIRVOpcodeTypeEnum.OpUGreaterThan, _
			    SPIRVOpcodeTypeEnum.OpUGreaterThanEqual, _
			    SPIRVOpcodeTypeEnum.OpULessThan, _
			    SPIRVOpcodeTypeEnum.OpULessThanEqual, _
			    SPIRVOpcodeTypeEnum.OpUMod, _
			    SPIRVOpcodeTypeEnum.OpUndef, _
			    SPIRVOpcodeTypeEnum.OpUnordered, _
			    SPIRVOpcodeTypeEnum.OpVariable, _
			    SPIRVOpcodeTypeEnum.OpVariableArray, SPIRVOpcodeTypeEnum.OpVectorExtractDynamic, _
			    SPIRVOpcodeTypeEnum.OpVectorInsertDynamic, SPIRVOpcodeTypeEnum.OpVectorShuffle, _
			    SPIRVOpcodeTypeEnum.OpVectorTimesMatrix, _
			    SPIRVOpcodeTypeEnum.OpVectorTimesScalar
			    
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
			  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			  ' www.zoclee.com/shade
			  
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
				"1 - OpAccessChain"
				"2 - OpAll"
				"3 - OpAny"
				"4 - OpArrayLength"
				"5 - OpAtomicExchange"
				"6 - OpAtomicInit"
				"7 - OpAtomicLoad"
				"8 - OpAtomicStore"
				"9 - OpBitcast"
				"10 - OpBitwiseAnd"
				"11 - OpBitwiseOr"
				"12 - OpBitwiseXor"
				"13 - OpBranch"
				"14 - OpBranchConditional"
				"15 - OpCompositeConstruct"
				"16 - OpCompositeExtract"
				"17 - OpCompositeInsert"
				"18 - OpConstant"
				"19 - OpConstantFalse"
				"20 - OpConstantNullObject"
				"21 - OpConstantNullPointer"
				"22 - OpConstantSampler"
				"23 - OpConstantTrue"
				"24 - OpConstantComposite"
				"25 - OpControlBarrier"
				"26 - OpConvertFToU"
				"27 - OpConvertFToS"
				"28 - OpConvertPtrToU"
				"29 - OpConvertSToF"
				"30 - OpConvertUToF"
				"31 - OpConvertUToPtr"
				"32 - OpCopyMemory"
				"33 - OpCopyMemorySized"
				"34 - OpCopyObject"
				"35 - OpDecorate"
				"36 - OpDecorationGroup"
				"37 - OpDot"
				"38 - OpDPdx"
				"39 - OpDPdxCoarse"
				"40 - OpDPdxFine"
				"41 - OpDPdy"
				"42 - OpDPdyCoarse"
				"43 - OpDPdyFine"
				"44 - OpEmitStreamVertex"
				"45 - OpEmitVertex"
				"46 - OpEndPrimitive"
				"47 - OpEndStreamPrimitive"
				"48 - OpEntryPoint"
				"49 - OpExecutionMode"
				"50 - OpExtension"
				"51 - OpExtInst"
				"52 - OpExtInstImport"
				"53 - OpFAdd"
				"54 - OpFConvert"
				"55 - OpFDiv"
				"56 - OpFMod"
				"57 - OpFMul"
				"58 - OpFNegate"
				"59 - OpFOrdEqual"
				"60 - OpFOrdGreaterThan"
				"61 - OpFOrdGreaterThanEqual"
				"62 - OpFOrdLessThan"
				"63 - OpFOrdLessThanEqual"
				"64 - OpFOrdNotEqual"
				"65 - OpFRem"
				"66 - OpFSub"
				"67 - OpFunction"
				"68 - OpFunctionCall"
				"69 - OpFunctionEnd"
				"70 - OpFunctionParameter"
				"71 - OpFUnordEqual"
				"72 - OpFUnordGreaterThan"
				"73 - OpFUnordGreaterThanEqual"
				"74 - OpFUnordLessThan"
				"75 - OpFUnordLessThanEqual"
				"76 - OpFUnordNotEqual"
				"77 - OpFwidth"
				"78 - OpFwidthCoarse"
				"79 - OpFwidthFine"
				"80 - OpGenericCastToPtr"
				"81 - OpGroupDecorate"
				"82 - OpGroupMemberDecorate"
				"83 - OpIAdd"
				"84 - OpIEqual"
				"85 - OpImagePointer"
				"86 - OpIMul"
				"87 - OpINotEqual"
				"88 - OpInBoundsAccessChain"
				"89 - OpIsFinite"
				"90 - OpIsInf"
				"91 - OpIsNan"
				"92 - OpIsNormal"
				"93 - OpISub"
				"94 - OpLabel"
				"95 - OpLessOrGreater"
				"96 - OpLine"
				"97 - OpLoad"
				"98 - OpLogicalAnd"
				"99 - OpLogicalOr"
				"100 - OpLogicalXor"
				"101 - OpLoopMerge"
				"102 - OpMatrixTimesMatrix"
				"103 - OpMatrixTimesScalar"
				"104 - OpMatrixTimesVector"
				"105 - OpMemberDecorate"
				"106 - OpMemberName"
				"107 - OpMemoryBarrier"
				"108 - OpMemoryModel"
				"109 - OpName"
				"110 - OpNop"
				"111 - OpNot"
				"112 - OpOrdered"
				"113 - OpOuterProduct"
				"114 - OpPhi"
				"115 - OpPtrCastToGeneric"
				"116 - OpReturn"
				"117 - OpSampler"
				"118 - OpSConvert"
				"119 - OpSDiv"
				"120 - OpSelect"
				"121 - OpSelectionMerge"
				"122 - OpShiftLeftLogical"
				"123 - OpShiftRightArithmetic"
				"124 - OpShiftRightLogical"
				"125 - OpSignBitSet"
				"126 - OpSGreaterThan"
				"127 - OpSGreaterThanEqual"
				"128 - OpSLessThan"
				"129 - OpSLessThanEqual"
				"130 - OpSNegate"
				"131 - OpSMod"
				"132 - OpSource"
				"133 - OpSourceExtension"
				"134 - OpSpecConstant"
				"135 - OpSpecConstantComposite"
				"136 - OpSpecConstantFalse"
				"137 - OpSpecConstantTrue"
				"138 - OpSRem"
				"139 - OpStore"
				"140 - OpString"
				"141 - OpTextureFetchSample"
				"142 - OpTextureFetchTexel"
				"143 - OpTextureFetchTexelLod"
				"144 - OpTextureFetchTexelOffset"
				"145 - OpTextureGather"
				"146 - OpTextureGatherOffset"
				"147 - OpTextureGatherOffsets"
				"148 - OpTextureQueryLevels"
				"149 - OpTextureQueryLod"
				"150 - OpTextureQuerySamples"
				"151 - OpTextureQuerySize"
				"152 - OpTextureQuerySizeLod"
				"153 - OpTextureSample"
				"154 - OpTextureSampleDref"
				"155 - OpTextureSampleGrad"
				"156 - OpTextureSampleGradOffset"
				"157 - OpTextureSampleLod"
				"158 - OpTextureSampleLodOffset"
				"159 - OpTextureSampleOffset"
				"160 - OpTextureSampleProj"
				"161 - OpTextureSampleProjGrad"
				"162 - OpTextureSampleProjGradOffset"
				"163 - OpTextureSampleProjLod"
				"164 - OpTextureSampleProjLodOffset"
				"165 - OpTextureSampleProjOffset"
				"166 - OpTranspose"
				"167 - OpTypeArray"
				"168 - OpTypeBool"
				"169 - OpTypeDeviceEvent"
				"170 - OpTypeEvent"
				"171 - OpTypeFilter"
				"172 - OpTypeFloat"
				"173 - OpTypeFunction"
				"174 - OpTypeInt"
				"175 - OpTypeMatrix"
				"176 - OpTypeOpaque"
				"177 - OpTypePipe"
				"178 - OpTypePointer"
				"179 - OpTypeQueue"
				"180 - OpTypeReserveId"
				"181 - OpTypeRuntimeArray"
				"182 - OpTypeSampler"
				"183 - OpTypeStruct"
				"184 - OpTypeVector"
				"185 - OpTypeVoid"
				"186 - OpUConvert"
				"187 - OpUDiv"
				"188 - OpUGreaterThan"
				"189 - OpUGreaterThanEqual"
				"190 - OpULessThanEqual"
				"191 - OpULessThan"
				"192 - OpUMod"
				"193 - OpUndef"
				"194 - OpUnordered"
				"195 - OpVariable"
				"196 - OpVariableArray"
				"197 - OpVectorExtractDynamic"
				"198 - OpVectorInsertDynamic"
				"199 - OpVectorShuffle"
				"200 - OpVectorTimesMatrix"
				"201 - OpVectorTimesScalar"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
