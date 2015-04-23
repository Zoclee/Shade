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
			    result.Append "AccessChain"
			    result.Append " "
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
			    result.Append "All"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpAny *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAny
			    result.Append "Any"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpArrayLength *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpArrayLength
			    result.Append "ArrayLength"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpAsyncGroupCopy *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAsyncGroupCopy
			    result.Append "AsyncGroupCopy"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    result.Append " "
			    result.Append compose_id(Offset + 28)
			    result.Append " "
			    result.Append compose_id(Offset + 32)
			    
			    // ***** OpAtomicAnd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicAnd
			    result.Append "AtomicAnd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicCompareExchange *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicCompareExchange
			    result.Append "AtomicCompareExchange"
			    result.Append " "
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
			    result.Append "AtomicCompareExchangeWeak"
			    result.Append " "
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
			    result.Append "AtomicExchange"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIAdd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicIAdd
			    result.Append "AtomicIAdd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicIDecrement *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicIDecrement
			    result.Append "AtomicIDecrement"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIIncrement *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicIIncrement
			    result.Append "AtomicIIncrement"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicISub *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicISub
			    result.Append "AtomicISub"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicInit *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicInit
			    result.Append "AtomicInit"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpAtomicLoad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicLoad
			    result.Append "AtomicLoad"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicOr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicOr
			    result.Append "AtomicOr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicStore *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicStore
			    result.Append "AtomicStore"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpAtomicUMax *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicUMax
			    result.Append "AtomicUMax"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicUMin *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicUMin
			    result.Append "AtomicUMin"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicXor *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpAtomicXor
			    result.Append "OpAtomicXor"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpBitcast *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBitcast
			    result.Append "Bitcast"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpBitwiseAnd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBitwiseAnd
			    result.Append "BitwiseAnd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBitwiseOr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBitwiseOr
			    result.Append "BitwiseOr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBitwiseXor *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBitwiseXor
			    result.Append "BitwiseXor"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBranch *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBranch
			    result.Append "Branch"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpBranchConditional *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpBranchConditional
			    result.Append "BranchConditional"
			    result.Append " "
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
			    
			    // ***** OpCommitReadPipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCommitReadPipe
			    result.Append "CommitReadPipe"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpCommitWritePipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCommitWritePipe
			    result.Append "CommitWritePipe"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpCompileFlag ************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCompileFlag
			    result.Append "CompileFlag"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
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
			    result.Append "CompositeExtract"
			    result.Append " "
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
			    result.Append "CompositeInsert"
			    result.Append " "
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
			    result.Append "Constant"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpConstantComposite *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConstantComposite
			    result.Append "ConstantComposite"
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
			    result.Append "ConstantSampler"
			    result.Append " "
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
			    result.Append "ControlBarrier"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    
			    // ***** OpConvertFToS *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertFToS
			    result.Append "ConvertFToS"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertFToU *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertFToU
			    result.Append "ConvertFToU"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertPtrToU *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertPtrToU
			    result.Append "ConvertPtrToU"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertSToF *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertSToF
			    result.Append "ConvertSToF"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertUToF *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertUToF
			    result.Append "ConvertUToF"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** ConvertUToPtr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpConvertUToPtr
			    result.Append "ConvertUToPtr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCopyMemory *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCopyMemory
			    result.Append "CopyMemory"
			    result.Append " "
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
			    result.Append "CopyMemorySized"
			    result.Append " "
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
			    result.Append "CopyObject"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCreateUserEvent *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpCreateUserEvent
			    result.Append "CreateUserEvent"
			    
			    // ***** OpDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDecorate
			    result.Append "Decorate"
			    result.Append " "
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
			    result.Append "Dot"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpDPdx *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdx
			    result.Append "DPdx"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdxCoarse *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdxCoarse
			    result.Append "DPdxCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdxFine *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdxFine
			    result.Append "DPdxFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdy *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdy
			    result.Append "DPdy"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdyCoarse *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdyCoarse
			    result.Append "DPdyCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdyFine *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpDPdyFine
			    result.Append "DPdyFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpEmitStreamVertex *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEmitStreamVertex
			    result.Append "EmitStreamVertex"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpEndStreamPrimitive *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEndStreamPrimitive
			    result.Append "EndStreamPrimitive"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpEmitVertex *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEmitVertex
			    result.Append "EmitVertex"
			    
			    // ***** OpEndPrimitive *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEndPrimitive
			    result.Append "EndPrimitive"
			    
			    // ***** OpEnqueueKernel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEnqueueKernel
			    result.Append "EnqueueKernel"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionModel(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    result.Append " "
			    result.Append compose_id(Offset + 28)
			    result.Append " "
			    result.Append compose_id(Offset + 32)
			    result.Append " "
			    result.Append compose_id(Offset + 36)
			    result.Append " "
			    result.Append compose_id(Offset + 40)
			    result.Append " "
			    result.Append compose_id(Offset + 44)
			    result.Append " "
			    result.Append compose_id(Offset + 48)
			    ub = offset + WordCount * 4
			    i = Offset + 52
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpEnqueueMarker *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEnqueueMarker
			    result.Append "EnqueueMarker"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpEntryPoint *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpEntryPoint
			    result.Append "EntryPoint"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpExecutionMode *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpExecutionMode
			    result.Append "ExecutionMode"
			    result.Append " "
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
			    result.Append "Extension"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpExtInst *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpExtInst
			    result.Append "ExtInst"
			    result.Append " "
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
			    result.Append "ExtInstImport"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpFAdd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFAdd
			    result.Append "FAdd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFConvert *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFConvert
			    result.Append "FConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFDiv *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFDiv
			    result.Append "FDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFMod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFMod
			    result.Append "FMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFMul *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFMul
			    result.Append "FMul"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFNegate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFNegate
			    result.Append "FNegate"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFOrdEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdEqual
			    result.Append "FOrdEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdGreaterThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdGreaterThan
			    result.Append "FOrdGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdGreaterThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdGreaterThanEqual
			    result.Append "FOrdGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    
			    // ***** OpFOrdLessThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdLessThan
			    result.Append "FOrdLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdLessThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdLessThanEqual
			    result.Append "FOrdLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdNotEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFOrdNotEqual
			    result.Append "FOrdNotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFRem *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFRem
			    result.Append "FRem"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFSub *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFSub
			    result.Append "FSub"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFunction *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunction
			    result.Append "Function"
			    result.Append " "
			    result.Append SPIRVDescribeFunctionControlMask(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_type(Offset + 16)
			    
			    // ***** OpFunctionCall *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFunctionCall
			    result.Append "FunctionCall"
			    result.Append " "
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
			    result.Append "FUnordEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordGreaterThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordGreaterThan
			    result.Append "FUnordGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordGreaterThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordGreaterThanEqual
			    result.Append "FUnordGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordLessThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordLessThan
			    result.Append "FUnordLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordLessThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordLessThanEqual
			    result.Append "FUnordLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordNotEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFUnordNotEqual
			    result.Append "FUnordNotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFwidth *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFwidth
			    result.Append "Fwidth"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFwidthCoarse *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFwidthCoarse
			    result.Append "FwidthCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFwidthFine *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpFwidthFine
			    result.Append "FwidthFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGenericCastToPtr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGenericCastToPtr
			    result.Append "GenericCastToPtr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGenericCastToPtrExplicit *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGenericCastToPtrExplicit
			    result.Append "GenericCastToPtrExplicit"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpGenericPtrMemSemantics *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGenericPtrMemSemantics
			    result.Append "GenericPtrMemSemantics"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetKernelNDrangeMaxSubGroupSize *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGetKernelNDrangeMaxSubGroupSize
			    result.Append "GetKernelNDrangeMaxSubGroupSize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGetKernelNDrangeSubGroupCount *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGetKernelNDrangeSubGroupCount
			    result.Append "GetKernelNDrangeSubGroupCount"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGetKernelPreferredWorkGroupSizeMultiple *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGetKernelPreferredWorkGroupSizeMultiple
			    result.Append "GetKernelPreferredWorkGroupSizeMultiple"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetKernelWorkGroupSize *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGetKernelWorkGroupSize
			    result.Append "GetKernelWorkGroupSize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetMaxPipePackets *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGetMaxPipePackets
			    result.Append "GetMaxPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetNumPipePackets *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGetNumPipePackets
			    result.Append "GetNumPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupAll *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupAll
			    result.Append "GroupAll"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGroupAll *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupAny
			    result.Append "GroupAny"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGroupBroadcast *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupBroadcast
			    result.Append "GroupBroadcast"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupCommitReadPipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupCommitReadPipe
			    result.Append "GroupCommitReadPipe"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupCommitWritePipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupCommitWritePipe
			    result.Append "GroupCommitWritePipe"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupDecorate
			    result.Append "GroupDecorate"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    ub = offset + WordCount * 4
			    i = Offset + 8
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpGroupFAdd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupFAdd
			    result.Append "GroupFAdd"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupFMax *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupFMax
			    result.Append "GroupFMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupFMin *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupFMin
			    result.Append "GroupFMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupIAdd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupIAdd
			    result.Append "GroupIAdd"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupReserveReadPipePackets *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupReserveReadPipePackets
			    result.Append "GroupReserveReadPipePackets"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupReserveWritePipePackets *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupReserveWritePipePackets
			    result.Append "GroupReserveWritePipePackets"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupSMax *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupSMax
			    result.Append "GroupSMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupSMin *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupSMin
			    result.Append "GroupSMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    // todo: X and Result Type must be a 32 or 64 bits wide OpTypeInt data type.
			    
			    // ***** OpGroupUMax *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupUMax
			    result.Append "GroupUMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupUMin *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupUMin
			    result.Append "GroupUMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupMemberDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpGroupMemberDecorate
			    result.Append "GroupMemberDecorate"
			    result.Append " "
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
			    result.Append "IAdd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIEqual
			    result.Append "IEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpImagePointer *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpImagePointer
			    result.Append "ImagePointer"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpIMul *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIMul
			    result.Append "IMul"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpInBoundsAccessChain *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpInBoundsAccessChain
			    result.Append "InBoundsAccessChain"
			    result.Append " "
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
			    result.Append "INotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIsFinite *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsFinite
			    result.Append "IsFinite"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsInf *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsInf
			    result.Append "IsInf"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsNan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsNan
			    result.Append "IsNan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsNormal *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsNormal
			    result.Append "IsNormal"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpISub *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpISub
			    result.Append "ISub"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIsValidReserveId *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpIsValidReserveId
			    result.Append "IsValidReserveId"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpKill *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpKill
			    result.Append "Kill"
			    
			    // ***** OpLabel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLabel
			    result.Append "Label"
			    
			    // ***** OpLessOrGreater *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLessOrGreater
			    result.Append "LessOrGreater"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLifetimeStart *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLifetimeStart
			    result.Append "LifetimeStart"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpLifetimeStop *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLifetimeStop
			    result.Append "LifetimeStop"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpLine *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLine
			    result.Append "Line"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpLoad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLoad
			    result.Append "Load"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpLogicalAnd *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLogicalAnd
			    result.Append "LogicalAnd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLogicalOr *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLogicalOr
			    result.Append "LogicalOr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLogicalXor *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLogicalXor
			    result.Append "LogicalXor"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLoopMerge *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpLoopMerge
			    result.Append "LoopMerge"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeLoopControlMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpMatrixTimesMatrix *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMatrixTimesMatrix
			    result.Append "MatrixTimesMatrix"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMatrixTimesScalar *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMatrixTimesScalar
			    result.Append "MatrixTimesScalar"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMatrixTimesVector *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMatrixTimesVector
			    result.Append "MatrixTimesVector"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMemberDecorate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMemberDecorate
			    result.Append "MemberDecorate"
			    result.Append " "
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
			    result.Append "MemberName"
			    result.Append " "
			    result.Append compose_type(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 12)
			    result.Append """"
			    
			    // ***** OpMemoryBarrier *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMemoryBarrier
			    result.Append "MemoryBarrier"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpMemoryModel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpMemoryModel
			    result.Append "MemoryModel"
			    result.Append " "
			    result.Append SPIRVDescribeAddressingModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemoryModel(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpName *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpName
			    result.Append "Name"
			    result.Append " "
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
			    result.Append "Ordered"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpOuterProduct *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpOuterProduct
			    result.Append "OuterProduct"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpPhi *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpPhi
			    result.Append "Phi"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpPtrCastToGeneric *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpPtrCastToGeneric
			    result.Append "PtrCastToGeneric"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpReadPipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReadPipe
			    result.Append "ReadPipe"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpReleaseEvent *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReleaseEvent
			    result.Append "ReleaseEvent"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpReservedReadPipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReservedReadPipe
			    result.Append "ReservedReadPipe"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpReservedWritePipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReservedWritePipe
			    result.Append "ReservedWritePipe"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpReserveReadPipePackets *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReserveReadPipePackets
			    result.Append "ReserveReadPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpReserveWritePipePackets *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReserveWritePipePackets
			    result.Append "ReserveWritePipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpRetainEvent *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpRetainEvent
			    result.Append "RetainEvent"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpReturn *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReturn
			    result.Append "Return"
			    
			    // ***** OpReturnValue *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpReturnValue
			    result.Append "ReturnValue"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpSampler *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSampler
			    result.Append "Sampler"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSConvert *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSConvert
			    result.Append "SConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSDiv *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSDiv
			    result.Append "SDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSelect *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSelect
			    result.Append "Select"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpSelectionMerge *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSelectionMerge
			    result.Append "SelectionMerge"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeSelectionControlMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSGreaterThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSGreaterThan
			    result.Append "SGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSGreaterThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSGreaterThanEqual
			    result.Append "SGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftLeftLogical *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpShiftLeftLogical
			    result.Append "ShiftLeftLogical"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftRightArithmetic *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpShiftRightArithmetic
			    result.Append "ShiftRightArithmetic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftRightLogical *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpShiftRightLogical
			    result.Append "ShiftRightLogical"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSignBitSet *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSignBitSet
			    result.Append "SignBitSet"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSLessThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSLessThan
			    result.Append "SLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSLessThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSLessThanEqual
			    result.Append "SLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSMod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSMod
			    result.Append "SMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSNegate *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSNegate
			    result.Append "SNegate"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSource *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSource
			    result.Append "Source"
			    result.Append " "
			    result.Append SPIRVDescribeSourceLanguage(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSourceExtension *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSourceExtension
			    result.Append "SourceExtension"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpSpecConstant *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSpecConstant
			    result.Append "SpecConstant"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpSpecConstantComposite *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSpecConstantComposite
			    result.Append "SpecConstantComposite"
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
			    result.Append "SRem"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpStore *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpStore
			    result.Append "Store"
			    result.Append " "
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
			    result.Append "String"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpSwitch *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpSwitch
			    result.Append "Switch"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while (i + 4) < ub
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(i))
			      i = i + 4
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpTextureFetchSample *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureFetchSample
			    result.Append "TextureFetchSample"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureFetchTexel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureFetchTexel
			    result.Append "TextureFetchTexel"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureFetchTexelLod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureFetchTexelLod
			    result.Append "TextureFetchTexelLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureFetchTexel *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureFetchTexelOffset
			    result.Append "TextureFetchTexelOffset"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureGather *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureGather
			    result.Append "TextureGather"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpTextureGatherOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureGatherOffset
			    result.Append "TextureGatherOffset"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureGatherOffsets *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureGatherOffsets
			    result.Append "TextureGatherOffsets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureQueryLevels *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQueryLevels
			    result.Append "TextureQueryLevels"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQueryLod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQueryLod
			    result.Append "TextureQueryLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureQuerySamples *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQuerySamples
			    result.Append "TextureQuerySamples"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQuerySize *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQuerySize
			    result.Append "TextureQuerySize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQuerySizeLod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureQuerySizeLod
			    result.Append "TextureQuerySizeLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureSample *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSample
			    result.Append "TextureSample"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    if WordCount = 6 then
			      result.Append " "
			      result.Append compose_id(Offset + 20)
			    end if
			    
			    // ***** OpTextureSampleDref *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleDref
			    result.Append "TextureSampleDref"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleGrad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleGrad
			    result.Append "TextureSampleGrad"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureSampleGradOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleGradOffset
			    result.Append "TextureSampleGradOffset"
			    result.Append " "
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
			    result.Append "TextureSampleLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleLodOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleLodOffset
			    result.Append "TextureSampleLodOffset"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureSampleOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleOffset
			    result.Append "TextureSampleOffset"
			    result.Append " "
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
			    result.Append "TextureSampleProj"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    if WordCount = 6 then
			      result.Append " "
			      result.Append compose_id(Offset + 20)
			    end if
			    
			    // ***** OpTextureSampleProjGrad *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjGrad
			    result.Append "TextureSampleProjGrad"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureSampleProjGradOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjGradOffset
			    result.Append "TextureSampleProjGradOffset"
			    result.Append " "
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
			    result.Append "TextureSampleProjLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleProjLodOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjLodOffset
			    result.Append "TextureSampleProjLodOffset"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpTextureSampleProjOffset *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTextureSampleProjOffset
			    result.Append "TextureSampleProjOffset"
			    result.Append " "
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
			    result.Append "Transpose"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTypeArray *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeArray
			    result.Append "TypeArray"
			    result.Append " "
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
			    result.Append "TypeFloat"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpTypeFunction *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeFunction
			    result.Append "TypeFunction"
			    result.Append " "
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
			    result.Append "TypeInt"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    if VM.ModuleBinary.UInt32Value(Offset + 12) = 0 then
			      result.Append " Unsigned"
			    else
			      result.Append " Signed"
			    end if
			    
			    // ***** OpTypeMatrix *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeMatrix
			    result.Append "TypeMatrix"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeOpaque *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeOpaque
			    result.Append "TypeOpaque"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpTypePipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypePipe
			    result.Append "TypePipe"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append SPIRVDescribeAccessQualifier(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypePointer *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypePointer
			    result.Append "TypePointer"
			    result.Append " "
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
			    result.Append "TypeRuntimeArray"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    
			    // ***** OpTypeSampler *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeSampler
			    result.Append "TypeSampler"
			    result.Append " "
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
			    result.Append "TypeStruct"
			    result.Append " "
			    ub = offset + WordCount * 4
			    i = Offset + 8
			    while i < ub
			      result.Append " "
			      result.Append compose_type(i)
			      i = i + 4
			    wend
			    
			    // ***** OpTypeVector *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeVector
			    result.Append "TypeVector"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeVoid *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpTypeVoid
			    result.Append "TypeVoid"
			    
			    // ***** OpUConvert *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUConvert
			    result.Append "UConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpUDiv *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUDiv
			    result.Append "UDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUGreaterThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUGreaterThan
			    result.Append "UGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUGreaterThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUGreaterThanEqual
			    result.Append "UGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpULessThan *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpULessThan
			    result.Append "ULessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpULessThanEqual *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpULessThanEqual
			    result.Append "ULessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUMod *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUMod
			    result.Append "UMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUndef *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUndef
			    result.Append "Undef"
			    
			    // ***** OpUnordered *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUnordered
			    result.Append "Unordered"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUnreachable *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpUnreachable
			    result.Append "Unreachable"
			    
			    // ***** OpVariable *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVariable
			    result.Append "Variable"
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    if WordCount > 4 then
			      break // todo: optional initializer
			    end if
			    
			    // ***** OpVariableArray *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVariableArray
			    result.Append "VariableArray"
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpVectorExtractDynamic *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorExtractDynamic
			    result.Append "VectorExtractDynamic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpVectorInsertDynamic *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorInsertDynamic
			    result.Append "VectorInsertDynamic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpVectorShuffle *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorShuffle
			    result.Append "VectorShuffle"
			    result.Append " "
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
			    result.Append "VectorTimesScalar"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpVectorTimesMatrix *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpVectorTimesMatrix
			    result.Append "VectorTimesMatrix"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpWaitGroupEvents *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpWaitGroupEvents
			    result.Append "WaitGroupEvents"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpWritePipe *************************************************
			    
			  case SPIRVOpcodeTypeEnum.OpWritePipe
			    result.Append "WritePipe"
			    result.Append " "
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
			    SPIRVOpcodeTypeEnum.OpAsyncGroupCopy, _
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
			    SPIRVOpcodeTypeEnum.OpCreateUserEvent, _
			    SPIRVOpcodeTypeEnum.OpDot, _
			    SPIRVOpcodeTypeEnum.OpDPdx, SPIRVOpcodeTypeEnum.OpDPdxCoarse, _
			    SPIRVOpcodeTypeEnum.OpDPdxFine, _
			    SPIRVOpcodeTypeEnum.OpDPdy, SPIRVOpcodeTypeEnum.OpDPdyCoarse, _
			    SPIRVOpcodeTypeEnum.OpDPdyFine, _
			    SPIRVOpcodeTypeEnum.OpEnqueueKernel, _
			    SPIRVOpcodeTypeEnum.OpEnqueueMarker, _
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
			    SPIRVOpcodeTypeEnum.OpGenericCastToPtrExplicit, _
			    SPIRVOpcodeTypeEnum.OpGenericPtrMemSemantics, _
			    SPIRVOpcodeTypeEnum.OpGetKernelNDrangeMaxSubGroupSize, _
			    SPIRVOpcodeTypeEnum.OpGetKernelNDrangeSubGroupCount, _
			    SPIRVOpcodeTypeEnum.OpGetKernelPreferredWorkGroupSizeMultiple, _
			    SPIRVOpcodeTypeEnum.OpGetKernelWorkGroupSize, _
			    SPIRVOpcodeTypeEnum.OpGetMaxPipePackets, _
			    SPIRVOpcodeTypeEnum.OpGetNumPipePackets, _
			    SPIRVOpcodeTypeEnum.OpGroupAll, _
			    SPIRVOpcodeTypeEnum.OpGroupAny, _
			    SPIRVOpcodeTypeEnum.OpGroupBroadcast, _
			    SPIRVOpcodeTypeEnum.OpGroupFAdd, _
			    SPIRVOpcodeTypeEnum.OpGroupFMax, _
			    SPIRVOpcodeTypeEnum.OpGroupFMin, _
			    SPIRVOpcodeTypeEnum.OpGroupIAdd, _
			    SPIRVOpcodeTypeEnum.OpGroupReserveReadPipePackets, _
			    SPIRVOpcodeTypeEnum.OpGroupReserveWritePipePackets, _
			    SPIRVOpcodeTypeEnum.OpGroupSMax, _
			    SPIRVOpcodeTypeEnum.OpGroupSMin, _
			    SPIRVOpcodeTypeEnum.OpGroupUMax, _
			    SPIRVOpcodeTypeEnum.OpGroupUMin, _
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
			    SPIRVOpcodeTypeEnum.OpIsValidReserveId, _
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
			    SPIRVOpcodeTypeEnum.OpReadPipe, _
			    SPIRVOpcodeTypeEnum.OpReservedReadPipe, _
			    SPIRVOpcodeTypeEnum.OpReservedWritePipe, _
			    SPIRVOpcodeTypeEnum.OpReserveReadPipePackets, _
			    SPIRVOpcodeTypeEnum.OpReserveWritePipePackets, _
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
			    SPIRVOpcodeTypeEnum.OpVectorTimesScalar, _
			    SPIRVOpcodeTypeEnum.OpWaitGroupEvents, _
			    SPIRVOpcodeTypeEnum.OpWritePipe
			    
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
			    SPIRVOpcodeTypeEnum.OpAsyncGroupCopy, _
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
			    SPIRVOpcodeTypeEnum.OpCreateUserEvent, _
			    SPIRVOpcodeTypeEnum.OpDot, _
			    SPIRVOpcodeTypeEnum.OpDPdx, SPIRVOpcodeTypeEnum.OpDPdxCoarse, _
			    SPIRVOpcodeTypeEnum.OpDPdxFine, _
			    SPIRVOpcodeTypeEnum.OpDPdy, SPIRVOpcodeTypeEnum.OpDPdyCoarse, _
			    SPIRVOpcodeTypeEnum.OpDPdyFine, _
			    SPIRVOpcodeTypeEnum.OpEnqueueKernel, _
			    SPIRVOpcodeTypeEnum.OpEnqueueMarker, _
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
			    SPIRVOpcodeTypeEnum.OpGenericCastToPtrExplicit, _
			    SPIRVOpcodeTypeEnum.OpGenericPtrMemSemantics, _
			    SPIRVOpcodeTypeEnum.OpGetKernelNDrangeSubGroupCount, _
			    SPIRVOpcodeTypeEnum.OpGetKernelNDrangeMaxSubGroupSize, _
			    SPIRVOpcodeTypeEnum.OpGetKernelPreferredWorkGroupSizeMultiple, _
			    SPIRVOpcodeTypeEnum.OpGetKernelWorkGroupSize, _
			    SPIRVOpcodeTypeEnum.OpGetMaxPipePackets, _
			    SPIRVOpcodeTypeEnum.OpGetNumPipePackets, _
			    SPIRVOpcodeTypeEnum.OpGroupAll, _
			    SPIRVOpcodeTypeEnum.OpGroupAny, _
			    SPIRVOpcodeTypeEnum.OpGroupBroadcast, _
			    SPIRVOpcodeTypeEnum.OpGroupFAdd, _
			    SPIRVOpcodeTypeEnum.OpGroupFMax, _
			    SPIRVOpcodeTypeEnum.OpGroupFMin, _
			    SPIRVOpcodeTypeEnum.OpGroupIAdd, _
			    SPIRVOpcodeTypeEnum.OpGroupReserveReadPipePackets, _
			    SPIRVOpcodeTypeEnum.OpGroupReserveWritePipePackets, _
			    SPIRVOpcodeTypeEnum.OpGroupSMax, _
			    SPIRVOpcodeTypeEnum.OpGroupSMin, _
			    SPIRVOpcodeTypeEnum.OpGroupUMax, _
			    SPIRVOpcodeTypeEnum.OpGroupUMin, _
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
			    SPIRVOpcodeTypeEnum.OpIsValidReserveId, _
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
			    SPIRVOpcodeTypeEnum.OpReadPipe, _
			    SPIRVOpcodeTypeEnum.OpReservedReadPipe, _
			    SPIRVOpcodeTypeEnum.OpReservedWritePipe, _
			    SPIRVOpcodeTypeEnum.OpReserveReadPipePackets, _
			    SPIRVOpcodeTypeEnum.OpReserveWritePipePackets, _
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
			    SPIRVOpcodeTypeEnum.OpVectorTimesScalar, _
			    SPIRVOpcodeTypeEnum.OpWaitGroupEvents, _
			    SPIRVOpcodeTypeEnum.OpWritePipe
			    
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
				"5 - OpAsyncGroupCopy"
				"6 - OpAtomicAnd"
				"7 - OpAtomicCompareExchange"
				"8 - OpAtomicCompareExchangeWeak"
				"9 - OpAtomicExchange"
				"10 - OpAtomicIAdd"
				"11 - OpAtomicIDecrement"
				"12 - OpAtomicIIncrement"
				"13 - OpAtomicISub"
				"14 - OpAtomicInit"
				"15 - OpAtomicLoad"
				"16 - OpAtomicOr"
				"17 - OpAtomicStore"
				"18 - OpAtomicUMax"
				"19 - OpAtomicUMin"
				"20 - OpAtomicXor"
				"21 - OpBitcast"
				"22 - OpBitwiseAnd"
				"23 - OpBitwiseOr"
				"24 - OpBitwiseXor"
				"25 - OpBranch"
				"26 - OpBranchConditional"
				"27 - OpCommitReadPipe"
				"28 - OpCommitWritePipe"
				"29 - OpCompileFlag"
				"30 - OpCompositeConstruct"
				"31 - OpCompositeExtract"
				"32 - OpCompositeInsert"
				"33 - OpConstant"
				"34 - OpConstantFalse"
				"35 - OpConstantNullObject"
				"36 - OpConstantNullPointer"
				"37 - OpConstantSampler"
				"38 - OpConstantTrue"
				"39 - OpConstantComposite"
				"40 - OpControlBarrier"
				"41 - OpConvertFToU"
				"42 - OpConvertFToS"
				"43 - OpConvertPtrToU"
				"44 - OpConvertSToF"
				"45 - OpConvertUToF"
				"46 - OpConvertUToPtr"
				"47 - OpCopyMemory"
				"48 - OpCopyMemorySized"
				"49 - OpCopyObject"
				"50 - OpDecorate"
				"51 - OpDecorationGroup"
				"52 - OpDot"
				"53 - OpDPdx"
				"54 - OpDPdxCoarse"
				"55 - OpDPdxFine"
				"56 - OpDPdy"
				"57 - OpDPdyCoarse"
				"58 - OpDPdyFine"
				"59 - OpEmitStreamVertex"
				"60 - OpEmitVertex"
				"61 - OpEndPrimitive"
				"62 - OpEndStreamPrimitive"
				"63 - OpEnqueueKernel"
				"64 - OpEnqueueMarker"
				"65 - OpEntryPoint"
				"66 - OpExecutionMode"
				"67 - OpExtension"
				"68 - OpExtInst"
				"69 - OpExtInstImport"
				"70 - OpFAdd"
				"71 - OpFConvert"
				"72 - OpFDiv"
				"73 - OpFMod"
				"74 - OpFMul"
				"75 - OpFNegate"
				"76 - OpFOrdEqual"
				"77 - OpFOrdGreaterThan"
				"78 - OpFOrdGreaterThanEqual"
				"79 - OpFOrdLessThan"
				"80 - OpFOrdLessThanEqual"
				"81 - OpFOrdNotEqual"
				"82 - OpFRem"
				"83 - OpFSub"
				"84 - OpFunction"
				"85 - OpFunctionCall"
				"86 - OpFunctionEnd"
				"87 - OpFunctionParameter"
				"88 - OpFUnordEqual"
				"89 - OpFUnordGreaterThan"
				"90 - OpFUnordGreaterThanEqual"
				"91 - OpFUnordLessThan"
				"92 - OpFUnordLessThanEqual"
				"93 - OpFUnordNotEqual"
				"94 - OpFwidth"
				"95 - OpFwidthCoarse"
				"96 - OpFwidthFine"
				"97 - OpGenericCastToPtr"
				"98 - OpGenericCastToPtrExplicit"
				"99 - OpGenericPtrMemSemantics"
				"100 - OpGetMaxPipePackets"
				"101 - OpGetNumPipePackets"
				"102 - OpGroupAll"
				"103 - OpGroupAny"
				"104 - OpGroupBroadcast"
				"105 - OpGroupCommitReadPipe"
				"106 - OpGroupCommitWritePipe"
				"107 - OpGroupDecorate"
				"108 - OpGroupFAdd"
				"109 - OpGroupFMax"
				"110 - OpGroupFMin"
				"111 - OpGroupIAdd"
				"112 - OpGroupMemberDecorate"
				"113 - OpGroupReserveReadPipePackets"
				"114 - OpGroupReserveWritePipePackets"
				"115 - OpGroupSMax"
				"116 - OpGroupSMin"
				"117 - OpGroupUMax"
				"118 - OpGroupUMin"
				"119 - OpIAdd"
				"120 - OpIEqual"
				"121 - OpImagePointer"
				"122 - OpIMul"
				"123 - OpINotEqual"
				"124 - OpInBoundsAccessChain"
				"125 - OpIsFinite"
				"126 - OpIsInf"
				"127 - OpIsNan"
				"128 - OpIsNormal"
				"129 - OpISub"
				"130 - OpIsValidReserveId"
				"131 - OpKill"
				"132 - OpLabel"
				"133 - OpLessOrGreater"
				"134 - OpLifetimeStart"
				"135 - OpLifetimeStop"
				"136 - OpLine"
				"137 - OpLoad"
				"138 - OpLogicalAnd"
				"139 - OpLogicalOr"
				"140 - OpLogicalXor"
				"141 - OpLoopMerge"
				"142 - OpMatrixTimesMatrix"
				"143 - OpMatrixTimesScalar"
				"144 - OpMatrixTimesVector"
				"145 - OpMemberDecorate"
				"146 - OpMemberName"
				"147 - OpMemoryBarrier"
				"148 - OpMemoryModel"
				"149 - OpName"
				"150 - OpNop"
				"151 - OpNot"
				"152 - OpOrdered"
				"153 - OpOuterProduct"
				"154 - OpPhi"
				"155 - OpPtrCastToGeneric"
				"156 - OpReadPipe"
				"157 - OpReservedReadPipe"
				"158 - OpReservedWritePipe"
				"159 - OpReserveReadPipePackets"
				"160 - OpReserveWritePipePackets"
				"161 - OpReturn"
				"162 - OpReturnValue"
				"163 - OpSampler"
				"164 - OpSConvert"
				"165 - OpSDiv"
				"166 - OpSelect"
				"167 - OpSelectionMerge"
				"168 - OpShiftLeftLogical"
				"169 - OpShiftRightArithmetic"
				"170 - OpShiftRightLogical"
				"171 - OpSignBitSet"
				"172 - OpSGreaterThan"
				"173 - OpSGreaterThanEqual"
				"174 - OpSLessThan"
				"175 - OpSLessThanEqual"
				"176 - OpSNegate"
				"177 - OpSMod"
				"178 - OpSource"
				"179 - OpSourceExtension"
				"180 - OpSpecConstant"
				"181 - OpSpecConstantComposite"
				"182 - OpSpecConstantFalse"
				"183 - OpSpecConstantTrue"
				"184 - OpSRem"
				"185 - OpStore"
				"186 - OpString"
				"187 - OpSwitch"
				"188 - OpTextureFetchSample"
				"189 - OpTextureFetchTexel"
				"190 - OpTextureFetchTexelLod"
				"191 - OpTextureFetchTexelOffset"
				"192 - OpTextureGather"
				"193 - OpTextureGatherOffset"
				"194 - OpTextureGatherOffsets"
				"195 - OpTextureQueryLevels"
				"196 - OpTextureQueryLod"
				"197 - OpTextureQuerySamples"
				"198 - OpTextureQuerySize"
				"199 - OpTextureQuerySizeLod"
				"200 - OpTextureSample"
				"201 - OpTextureSampleDref"
				"202 - OpTextureSampleGrad"
				"203 - OpTextureSampleGradOffset"
				"204 - OpTextureSampleLod"
				"205 - OpTextureSampleLodOffset"
				"206 - OpTextureSampleOffset"
				"207 - OpTextureSampleProj"
				"208 - OpTextureSampleProjGrad"
				"209 - OpTextureSampleProjGradOffset"
				"210 - OpTextureSampleProjLod"
				"211 - OpTextureSampleProjLodOffset"
				"212 - OpTextureSampleProjOffset"
				"213 - OpTranspose"
				"214 - OpTypeArray"
				"215 - OpTypeBool"
				"216 - OpTypeDeviceEvent"
				"217 - OpTypeEvent"
				"218 - OpTypeFilter"
				"219 - OpTypeFloat"
				"220 - OpTypeFunction"
				"221 - OpTypeInt"
				"222 - OpTypeMatrix"
				"223 - OpTypeOpaque"
				"224 - OpTypePipe"
				"225 - OpTypePointer"
				"226 - OpTypeQueue"
				"227 - OpTypeReserveId"
				"228 - OpTypeRuntimeArray"
				"229 - OpTypeSampler"
				"230 - OpTypeStruct"
				"231 - OpTypeVector"
				"232 - OpTypeVoid"
				"233 - OpUConvert"
				"234 - OpUDiv"
				"235 - OpUGreaterThan"
				"236 - OpUGreaterThanEqual"
				"237 - OpULessThanEqual"
				"238 - OpULessThan"
				"239 - OpUMod"
				"240 - OpUndef"
				"241 - OpUnordered"
				"242 - OpUnreachable"
				"243 - OpVariable"
				"244 - OpVariableArray"
				"245 - OpVectorExtractDynamic"
				"246 - OpVectorInsertDynamic"
				"247 - OpVectorShuffle"
				"248 - OpVectorTimesMatrix"
				"249 - OpVectorTimesScalar"
				"250 - OpWaitGroupEvents"
				"251 - OpWritePipe"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
