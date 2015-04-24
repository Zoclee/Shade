#tag Class
Protected Class Opcode
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
		  Dim typ As SPIRV.Type
		  
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
		Sub Constructor(initVM As SPIRV.VirtualMachine, initType As OpcodeTypeEnum)
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
			  Dim typ As SPIRV.Type
			  Dim i As UInt32
			  Dim ub As UInt32
			  
			  select case Type
			    
			    // ***** OpAccessChain *************************************************
			    
			  case OpcodeTypeEnum.OpAccessChain
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
			    
			  case OpcodeTypeEnum.OpAll
			    result.Append "All"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpAny *************************************************
			    
			  case OpcodeTypeEnum.OpAny
			    result.Append "Any"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpArrayLength *************************************************
			    
			  case OpcodeTypeEnum.OpArrayLength
			    result.Append "ArrayLength"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpAsyncGroupCopy *************************************************
			    
			  case OpcodeTypeEnum.OpAsyncGroupCopy
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
			    
			  case OpcodeTypeEnum.OpAtomicAnd
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
			    
			  case OpcodeTypeEnum.OpAtomicCompareExchange
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
			    
			  case OpcodeTypeEnum.OpAtomicCompareExchangeWeak
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
			    
			  case OpcodeTypeEnum.OpAtomicExchange
			    result.Append "AtomicExchange"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIAdd *************************************************
			    
			  case OpcodeTypeEnum.OpAtomicIAdd
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
			    
			  case OpcodeTypeEnum.OpAtomicIDecrement
			    result.Append "AtomicIDecrement"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIIncrement *************************************************
			    
			  case OpcodeTypeEnum.OpAtomicIIncrement
			    result.Append "AtomicIIncrement"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIMax *************************************************
			    
			  case OpcodeTypeEnum.OpAtomicIMax
			    result.Append "AtomicIMax"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicIMin *************************************************
			    
			  case OpcodeTypeEnum.OpAtomicIMin
			    result.Append "AtomicIMin"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    result.Append " "
			    result.Append compose_id(Offset + 24)
			    
			    // ***** OpAtomicISub *************************************************
			    
			  case OpcodeTypeEnum.OpAtomicISub
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
			    
			  case OpcodeTypeEnum.OpAtomicInit
			    result.Append "AtomicInit"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpAtomicLoad *************************************************
			    
			  case OpcodeTypeEnum.OpAtomicLoad
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
			    
			  case OpcodeTypeEnum.OpAtomicOr
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
			    
			  case OpcodeTypeEnum.OpAtomicStore
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
			    
			  case OpcodeTypeEnum.OpAtomicUMax
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
			    
			  case OpcodeTypeEnum.OpAtomicUMin
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
			    
			  case OpcodeTypeEnum.OpAtomicXor
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
			    
			  case OpcodeTypeEnum.OpBitcast
			    result.Append "Bitcast"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpBitwiseAnd *************************************************
			    
			  case OpcodeTypeEnum.OpBitwiseAnd
			    result.Append "BitwiseAnd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBitwiseOr *************************************************
			    
			  case OpcodeTypeEnum.OpBitwiseOr
			    result.Append "BitwiseOr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBitwiseXor *************************************************
			    
			  case OpcodeTypeEnum.OpBitwiseXor
			    result.Append "BitwiseXor"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBranch *************************************************
			    
			  case OpcodeTypeEnum.OpBranch
			    result.Append "Branch"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpBranchConditional *************************************************
			    
			  case OpcodeTypeEnum.OpBranchConditional
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
			    
			    // ***** OpBuildNDRange *************************************************
			    
			  case OpcodeTypeEnum.OpBuildNDRange
			    result.Append "BuildNDRange"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpCaptureEventProfilingInfo *************************************************
			    
			  case OpcodeTypeEnum.OpCaptureEventProfilingInfo
			    result.Append "CaptureEventProfilingInfo"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeKernelProfilingInfoMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCommitReadPipe *************************************************
			    
			  case OpcodeTypeEnum.OpCommitReadPipe
			    result.Append "CommitReadPipe"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpCommitWritePipe *************************************************
			    
			  case OpcodeTypeEnum.OpCommitWritePipe
			    result.Append "CommitWritePipe"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpCompileFlag ************************************************
			    
			  case OpcodeTypeEnum.OpCompileFlag
			    result.Append "CompileFlag"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpCompositeConstruct *************************************************
			    
			  case OpcodeTypeEnum.OpCompositeConstruct
			    result.Append "CompositeConstruct"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpCompositeExtract *************************************************
			    
			  case OpcodeTypeEnum.OpCompositeExtract
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
			    
			  case OpcodeTypeEnum.OpCompositeInsert
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
			    
			  case OpcodeTypeEnum.OpConstant
			    result.Append "Constant"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpConstantComposite *************************************************
			    
			  case OpcodeTypeEnum.OpConstantComposite
			    result.Append "ConstantComposite"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpConstantFalse *************************************************
			    
			  case OpcodeTypeEnum.OpConstantFalse
			    result.Append "ConstantFalse"
			    
			    // ***** OpConstantNullObject *************************************************
			    
			  case OpcodeTypeEnum.OpConstantNullObject
			    result.Append "ConstantNullObject"
			    
			    // ***** OpConstantNullPointer *************************************************
			    
			  case OpcodeTypeEnum.OpConstantNullPointer
			    result.Append "ConstantNullPointer"
			    
			    // ***** OpConstantSampler *************************************************
			    
			  case OpcodeTypeEnum.OpConstantSampler
			    result.Append "ConstantSampler"
			    result.Append " "
			    result.Append SPIRVDescribeSamplerAddressingMode(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeParam(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeSamplerFilterMode(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpConstantTrue *************************************************
			    
			  case OpcodeTypeEnum.OpConstantTrue
			    result.Append "ConstantTrue"
			    
			    // ***** OpControlBarrier *************************************************
			    
			  case OpcodeTypeEnum.OpControlBarrier
			    result.Append "ControlBarrier"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    
			    // ***** OpConvertFToS *************************************************
			    
			  case OpcodeTypeEnum.OpConvertFToS
			    result.Append "ConvertFToS"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertFToU *************************************************
			    
			  case OpcodeTypeEnum.OpConvertFToU
			    result.Append "ConvertFToU"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertPtrToU *************************************************
			    
			  case OpcodeTypeEnum.OpConvertPtrToU
			    result.Append "ConvertPtrToU"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertSToF *************************************************
			    
			  case OpcodeTypeEnum.OpConvertSToF
			    result.Append "ConvertSToF"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertUToF *************************************************
			    
			  case OpcodeTypeEnum.OpConvertUToF
			    result.Append "ConvertUToF"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** ConvertUToPtr *************************************************
			    
			  case OpcodeTypeEnum.OpConvertUToPtr
			    result.Append "ConvertUToPtr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCopyMemory *************************************************
			    
			  case OpcodeTypeEnum.OpCopyMemory
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
			    
			  case OpcodeTypeEnum.OpCopyMemorySized
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
			    
			  case OpcodeTypeEnum.OpCopyObject
			    result.Append "CopyObject"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCreateUserEvent *************************************************
			    
			  case OpcodeTypeEnum.OpCreateUserEvent
			    result.Append "CreateUserEvent"
			    
			    // ***** OpDecorate *************************************************
			    
			  case OpcodeTypeEnum.OpDecorate
			    result.Append "Decorate"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeDecoration(VM.ModuleBinary.UInt32Value(Offset + 8))
			    select case VM.ModuleBinary.UInt32Value(Offset + 8)
			    case 29 // Stream
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 30 // Location
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 31 // Component
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 32 // Index
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 33 // Binding
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 34 // DescriptorSet
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 35 // Offset
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 36 // Alignment
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 37 // XfbBuffer
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    case 38 // Stride
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
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
			      result.Append " "
			      result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    end select
			    
			    // ***** OpDecorationGroup *************************************************
			    
			  case OpcodeTypeEnum.OpDecorationGroup
			    result.Append "DecorationGroup"
			    
			    // ***** OpDot *************************************************
			    
			  case OpcodeTypeEnum.OpDot
			    result.Append "Dot"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpDPdx *************************************************
			    
			  case OpcodeTypeEnum.OpDPdx
			    result.Append "DPdx"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdxCoarse *************************************************
			    
			  case OpcodeTypeEnum.OpDPdxCoarse
			    result.Append "DPdxCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdxFine *************************************************
			    
			  case OpcodeTypeEnum.OpDPdxFine
			    result.Append "DPdxFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdy *************************************************
			    
			  case OpcodeTypeEnum.OpDPdy
			    result.Append "DPdy"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdyCoarse *************************************************
			    
			  case OpcodeTypeEnum.OpDPdyCoarse
			    result.Append "DPdyCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdyFine *************************************************
			    
			  case OpcodeTypeEnum.OpDPdyFine
			    result.Append "DPdyFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpEmitStreamVertex *************************************************
			    
			  case OpcodeTypeEnum.OpEmitStreamVertex
			    result.Append "EmitStreamVertex"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpEndStreamPrimitive *************************************************
			    
			  case OpcodeTypeEnum.OpEndStreamPrimitive
			    result.Append "EndStreamPrimitive"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpEmitVertex *************************************************
			    
			  case OpcodeTypeEnum.OpEmitVertex
			    result.Append "EmitVertex"
			    
			    // ***** OpEndPrimitive *************************************************
			    
			  case OpcodeTypeEnum.OpEndPrimitive
			    result.Append "EndPrimitive"
			    
			    // ***** OpEnqueueKernel *************************************************
			    
			  case OpcodeTypeEnum.OpEnqueueKernel
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
			    
			  case OpcodeTypeEnum.OpEnqueueMarker
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
			    
			  case OpcodeTypeEnum.OpEntryPoint
			    result.Append "EntryPoint"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpExecutionMode *************************************************
			    
			  case OpcodeTypeEnum.OpExecutionMode
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
			    
			  case OpcodeTypeEnum.OpExtension
			    result.Append "Extension"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpExtInst *************************************************
			    
			  case OpcodeTypeEnum.OpExtInst
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
			    
			  case OpcodeTypeEnum.OpExtInstImport
			    result.Append "ExtInstImport"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpFAdd *************************************************
			    
			  case OpcodeTypeEnum.OpFAdd
			    result.Append "FAdd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFConvert *************************************************
			    
			  case OpcodeTypeEnum.OpFConvert
			    result.Append "FConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFDiv *************************************************
			    
			  case OpcodeTypeEnum.OpFDiv
			    result.Append "FDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFMod *************************************************
			    
			  case OpcodeTypeEnum.OpFMod
			    result.Append "FMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFMul *************************************************
			    
			  case OpcodeTypeEnum.OpFMul
			    result.Append "FMul"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFNegate *************************************************
			    
			  case OpcodeTypeEnum.OpFNegate
			    result.Append "FNegate"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFOrdEqual *************************************************
			    
			  case OpcodeTypeEnum.OpFOrdEqual
			    result.Append "FOrdEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdGreaterThan *************************************************
			    
			  case OpcodeTypeEnum.OpFOrdGreaterThan
			    result.Append "FOrdGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdGreaterThanEqual *************************************************
			    
			  case OpcodeTypeEnum.OpFOrdGreaterThanEqual
			    result.Append "FOrdGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    
			    // ***** OpFOrdLessThan *************************************************
			    
			  case OpcodeTypeEnum.OpFOrdLessThan
			    result.Append "FOrdLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdLessThanEqual *************************************************
			    
			  case OpcodeTypeEnum.OpFOrdLessThanEqual
			    result.Append "FOrdLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdNotEqual *************************************************
			    
			  case OpcodeTypeEnum.OpFOrdNotEqual
			    result.Append "FOrdNotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFRem *************************************************
			    
			  case OpcodeTypeEnum.OpFRem
			    result.Append "FRem"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFSub *************************************************
			    
			  case OpcodeTypeEnum.OpFSub
			    result.Append "FSub"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFunction *************************************************
			    
			  case OpcodeTypeEnum.OpFunction
			    result.Append "Function"
			    result.Append " "
			    result.Append SPIRVDescribeFunctionControlMask(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_type(Offset + 16)
			    
			    // ***** OpFunctionCall *************************************************
			    
			  case OpcodeTypeEnum.OpFunctionCall
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
			    
			  case OpcodeTypeEnum.OpFunctionEnd
			    result.Append "FunctionEnd"
			    
			    // ***** OpFunctionParameter *************************************************
			    
			  case OpcodeTypeEnum.OpFunctionParameter
			    result.Append "FunctionParameter"
			    
			    // ***** OpFUnordEqual *************************************************
			    
			  case OpcodeTypeEnum.OpFUnordEqual
			    result.Append "FUnordEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordGreaterThan *************************************************
			    
			  case OpcodeTypeEnum.OpFUnordGreaterThan
			    result.Append "FUnordGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordGreaterThanEqual *************************************************
			    
			  case OpcodeTypeEnum.OpFUnordGreaterThanEqual
			    result.Append "FUnordGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordLessThan *************************************************
			    
			  case OpcodeTypeEnum.OpFUnordLessThan
			    result.Append "FUnordLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordLessThanEqual *************************************************
			    
			  case OpcodeTypeEnum.OpFUnordLessThanEqual
			    result.Append "FUnordLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordNotEqual *************************************************
			    
			  case OpcodeTypeEnum.OpFUnordNotEqual
			    result.Append "FUnordNotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFwidth *************************************************
			    
			  case OpcodeTypeEnum.OpFwidth
			    result.Append "Fwidth"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFwidthCoarse *************************************************
			    
			  case OpcodeTypeEnum.OpFwidthCoarse
			    result.Append "FwidthCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFwidthFine *************************************************
			    
			  case OpcodeTypeEnum.OpFwidthFine
			    result.Append "FwidthFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGenericCastToPtr *************************************************
			    
			  case OpcodeTypeEnum.OpGenericCastToPtr
			    result.Append "GenericCastToPtr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGenericCastToPtrExplicit *************************************************
			    
			  case OpcodeTypeEnum.OpGenericCastToPtrExplicit
			    result.Append "GenericCastToPtrExplicit"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpGenericPtrMemSemantics *************************************************
			    
			  case OpcodeTypeEnum.OpGenericPtrMemSemantics
			    result.Append "GenericPtrMemSemantics"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetDefaultQueue *************************************************
			    
			  case OpcodeTypeEnum.OpGetDefaultQueue
			    result.Append "GetDefaultQueue"
			    
			    // ***** OpGetKernelNDrangeMaxSubGroupSize *************************************************
			    
			  case OpcodeTypeEnum.OpGetKernelNDrangeMaxSubGroupSize
			    result.Append "GetKernelNDrangeMaxSubGroupSize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGetKernelNDrangeSubGroupCount *************************************************
			    
			  case OpcodeTypeEnum.OpGetKernelNDrangeSubGroupCount
			    result.Append "GetKernelNDrangeSubGroupCount"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGetKernelPreferredWorkGroupSizeMultiple *************************************************
			    
			  case OpcodeTypeEnum.OpGetKernelPreferredWorkGroupSizeMultiple
			    result.Append "GetKernelPreferredWorkGroupSizeMultiple"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetKernelWorkGroupSize *************************************************
			    
			  case OpcodeTypeEnum.OpGetKernelWorkGroupSize
			    result.Append "GetKernelWorkGroupSize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetMaxPipePackets *************************************************
			    
			  case OpcodeTypeEnum.OpGetMaxPipePackets
			    result.Append "GetMaxPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetNumPipePackets *************************************************
			    
			  case OpcodeTypeEnum.OpGetNumPipePackets
			    result.Append "GetNumPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupAll *************************************************
			    
			  case OpcodeTypeEnum.OpGroupAll
			    result.Append "GroupAll"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGroupAll *************************************************
			    
			  case OpcodeTypeEnum.OpGroupAny
			    result.Append "GroupAny"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGroupBroadcast *************************************************
			    
			  case OpcodeTypeEnum.OpGroupBroadcast
			    result.Append "GroupBroadcast"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupCommitReadPipe *************************************************
			    
			  case OpcodeTypeEnum.OpGroupCommitReadPipe
			    result.Append "GroupCommitReadPipe"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupCommitWritePipe *************************************************
			    
			  case OpcodeTypeEnum.OpGroupCommitWritePipe
			    result.Append "GroupCommitWritePipe"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupDecorate *************************************************
			    
			  case OpcodeTypeEnum.OpGroupDecorate
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
			    
			  case OpcodeTypeEnum.OpGroupFAdd
			    result.Append "GroupFAdd"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupFMax *************************************************
			    
			  case OpcodeTypeEnum.OpGroupFMax
			    result.Append "GroupFMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupFMin *************************************************
			    
			  case OpcodeTypeEnum.OpGroupFMin
			    result.Append "GroupFMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupIAdd *************************************************
			    
			  case OpcodeTypeEnum.OpGroupIAdd
			    result.Append "GroupIAdd"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupReserveReadPipePackets *************************************************
			    
			  case OpcodeTypeEnum.OpGroupReserveReadPipePackets
			    result.Append "GroupReserveReadPipePackets"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupReserveWritePipePackets *************************************************
			    
			  case OpcodeTypeEnum.OpGroupReserveWritePipePackets
			    result.Append "GroupReserveWritePipePackets"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupSMax *************************************************
			    
			  case OpcodeTypeEnum.OpGroupSMax
			    result.Append "GroupSMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupSMin *************************************************
			    
			  case OpcodeTypeEnum.OpGroupSMin
			    result.Append "GroupSMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    // todo: X and Result Type must be a 32 or 64 bits wide OpTypeInt data type.
			    
			    // ***** OpGroupUMax *************************************************
			    
			  case OpcodeTypeEnum.OpGroupUMax
			    result.Append "GroupUMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupUMin *************************************************
			    
			  case OpcodeTypeEnum.OpGroupUMin
			    result.Append "GroupUMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupMemberDecorate *************************************************
			    
			  case OpcodeTypeEnum.OpGroupMemberDecorate
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
			    
			  case OpcodeTypeEnum.OpIAdd
			    result.Append "IAdd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIEqual *************************************************
			    
			  case OpcodeTypeEnum.OpIEqual
			    result.Append "IEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpImagePointer *************************************************
			    
			  case OpcodeTypeEnum.OpImagePointer
			    result.Append "ImagePointer"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpIMul *************************************************
			    
			  case OpcodeTypeEnum.OpIMul
			    result.Append "IMul"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpInBoundsAccessChain *************************************************
			    
			  case OpcodeTypeEnum.OpInBoundsAccessChain
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
			    
			  case OpcodeTypeEnum.OpINotEqual
			    result.Append "INotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIsFinite *************************************************
			    
			  case OpcodeTypeEnum.OpIsFinite
			    result.Append "IsFinite"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsInf *************************************************
			    
			  case OpcodeTypeEnum.OpIsInf
			    result.Append "IsInf"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsNan *************************************************
			    
			  case OpcodeTypeEnum.OpIsNan
			    result.Append "IsNan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsNormal *************************************************
			    
			  case OpcodeTypeEnum.OpIsNormal
			    result.Append "IsNormal"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpISub *************************************************
			    
			  case OpcodeTypeEnum.OpISub
			    result.Append "ISub"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIsValidEvent *************************************************
			    
			  case OpcodeTypeEnum.OpIsValidEvent
			    result.Append "IsValidEvent"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsValidReserveId *************************************************
			    
			  case OpcodeTypeEnum.OpIsValidReserveId
			    result.Append "IsValidReserveId"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpKill *************************************************
			    
			  case OpcodeTypeEnum.OpKill
			    result.Append "Kill"
			    
			    // ***** OpLabel *************************************************
			    
			  case OpcodeTypeEnum.OpLabel
			    result.Append "Label"
			    
			    // ***** OpLessOrGreater *************************************************
			    
			  case OpcodeTypeEnum.OpLessOrGreater
			    result.Append "LessOrGreater"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLifetimeStart *************************************************
			    
			  case OpcodeTypeEnum.OpLifetimeStart
			    result.Append "LifetimeStart"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpLifetimeStop *************************************************
			    
			  case OpcodeTypeEnum.OpLifetimeStop
			    result.Append "LifetimeStop"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpLine *************************************************
			    
			  case OpcodeTypeEnum.OpLine
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
			    
			  case OpcodeTypeEnum.OpLoad
			    result.Append "Load"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpLogicalAnd *************************************************
			    
			  case OpcodeTypeEnum.OpLogicalAnd
			    result.Append "LogicalAnd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLogicalOr *************************************************
			    
			  case OpcodeTypeEnum.OpLogicalOr
			    result.Append "LogicalOr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLogicalXor *************************************************
			    
			  case OpcodeTypeEnum.OpLogicalXor
			    result.Append "LogicalXor"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLoopMerge *************************************************
			    
			  case OpcodeTypeEnum.OpLoopMerge
			    result.Append "LoopMerge"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeLoopControlMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpMatrixTimesMatrix *************************************************
			    
			  case OpcodeTypeEnum.OpMatrixTimesMatrix
			    result.Append "MatrixTimesMatrix"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMatrixTimesScalar *************************************************
			    
			  case OpcodeTypeEnum.OpMatrixTimesScalar
			    result.Append "MatrixTimesScalar"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMatrixTimesVector *************************************************
			    
			  case OpcodeTypeEnum.OpMatrixTimesVector
			    result.Append "MatrixTimesVector"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMemberDecorate *************************************************
			    
			  case OpcodeTypeEnum.OpMemberDecorate
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
			    
			  case OpcodeTypeEnum.OpMemberName
			    result.Append "MemberName"
			    result.Append " "
			    result.Append compose_type(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 12)
			    result.Append """"
			    
			    // ***** OpMemoryBarrier *************************************************
			    
			  case OpcodeTypeEnum.OpMemoryBarrier
			    result.Append "MemoryBarrier"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpMemoryModel *************************************************
			    
			  case OpcodeTypeEnum.OpMemoryModel
			    result.Append "MemoryModel"
			    result.Append " "
			    result.Append SPIRVDescribeAddressingModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemoryModel(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpName *************************************************
			    
			  case OpcodeTypeEnum.OpName
			    result.Append "Name"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpNop *************************************************
			    
			  case OpcodeTypeEnum.OpNop
			    result.Append "Nop"
			    
			    // ***** OpNot *************************************************
			    
			  case OpcodeTypeEnum.OpNot
			    result.Append "Not "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpOrdered *************************************************
			    
			  case OpcodeTypeEnum.OpOrdered
			    result.Append "Ordered"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpOuterProduct *************************************************
			    
			  case OpcodeTypeEnum.OpOuterProduct
			    result.Append "OuterProduct"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpPhi *************************************************
			    
			  case OpcodeTypeEnum.OpPhi
			    result.Append "Phi"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpPtrCastToGeneric *************************************************
			    
			  case OpcodeTypeEnum.OpPtrCastToGeneric
			    result.Append "PtrCastToGeneric"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpReadPipe *************************************************
			    
			  case OpcodeTypeEnum.OpReadPipe
			    result.Append "ReadPipe"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpReleaseEvent *************************************************
			    
			  case OpcodeTypeEnum.OpReleaseEvent
			    result.Append "ReleaseEvent"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpReservedReadPipe *************************************************
			    
			  case OpcodeTypeEnum.OpReservedReadPipe
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
			    
			  case OpcodeTypeEnum.OpReservedWritePipe
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
			    
			  case OpcodeTypeEnum.OpReserveReadPipePackets
			    result.Append "ReserveReadPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpReserveWritePipePackets *************************************************
			    
			  case OpcodeTypeEnum.OpReserveWritePipePackets
			    result.Append "ReserveWritePipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpRetainEvent *************************************************
			    
			  case OpcodeTypeEnum.OpRetainEvent
			    result.Append "RetainEvent"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpReturn *************************************************
			    
			  case OpcodeTypeEnum.OpReturn
			    result.Append "Return"
			    
			    // ***** OpReturnValue *************************************************
			    
			  case OpcodeTypeEnum.OpReturnValue
			    result.Append "ReturnValue"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpSampler *************************************************
			    
			  case OpcodeTypeEnum.OpSampler
			    result.Append "Sampler"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSatConvertSToU *************************************************
			    
			  case OpcodeTypeEnum.OpSatConvertSToU
			    result.Append "SatConvertSToU"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSatConvertUToS *************************************************
			    
			  case OpcodeTypeEnum.OpSatConvertUToS
			    result.Append "SatConvertUToS"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSConvert *************************************************
			    
			  case OpcodeTypeEnum.OpSConvert
			    result.Append "SConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSDiv *************************************************
			    
			  case OpcodeTypeEnum.OpSDiv
			    result.Append "SDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSelect *************************************************
			    
			  case OpcodeTypeEnum.OpSelect
			    result.Append "Select"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpSelectionMerge *************************************************
			    
			  case OpcodeTypeEnum.OpSelectionMerge
			    result.Append "SelectionMerge"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeSelectionControlMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSetUserEventStatus *************************************************
			    
			  case OpcodeTypeEnum.OpSetUserEventStatus
			    result.Append "SetUserEventStatus"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpSGreaterThan *************************************************
			    
			  case OpcodeTypeEnum.OpSGreaterThan
			    result.Append "SGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSGreaterThanEqual *************************************************
			    
			  case OpcodeTypeEnum.OpSGreaterThanEqual
			    result.Append "SGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftLeftLogical *************************************************
			    
			  case OpcodeTypeEnum.OpShiftLeftLogical
			    result.Append "ShiftLeftLogical"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftRightArithmetic *************************************************
			    
			  case OpcodeTypeEnum.OpShiftRightArithmetic
			    result.Append "ShiftRightArithmetic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftRightLogical *************************************************
			    
			  case OpcodeTypeEnum.OpShiftRightLogical
			    result.Append "ShiftRightLogical"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSignBitSet *************************************************
			    
			  case OpcodeTypeEnum.OpSignBitSet
			    result.Append "SignBitSet"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSLessThan *************************************************
			    
			  case OpcodeTypeEnum.OpSLessThan
			    result.Append "SLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSLessThanEqual *************************************************
			    
			  case OpcodeTypeEnum.OpSLessThanEqual
			    result.Append "SLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSMod *************************************************
			    
			  case OpcodeTypeEnum.OpSMod
			    result.Append "SMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSNegate *************************************************
			    
			  case OpcodeTypeEnum.OpSNegate
			    result.Append "SNegate"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSource *************************************************
			    
			  case OpcodeTypeEnum.OpSource
			    result.Append "Source"
			    result.Append " "
			    result.Append SPIRVDescribeSourceLanguage(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSourceExtension *************************************************
			    
			  case OpcodeTypeEnum.OpSourceExtension
			    result.Append "SourceExtension"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpSpecConstant *************************************************
			    
			  case OpcodeTypeEnum.OpSpecConstant
			    result.Append "SpecConstant"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpSpecConstantComposite *************************************************
			    
			  case OpcodeTypeEnum.OpSpecConstantComposite
			    result.Append "SpecConstantComposite"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpSpecConstantFalse *************************************************
			    
			  case OpcodeTypeEnum.OpSpecConstantFalse
			    result.Append "SpecConstantFalse"
			    
			    // ***** OpSpecConstantTrue *************************************************
			    
			  case OpcodeTypeEnum.OpSpecConstantTrue
			    result.Append "SpecConstantTrue"
			    
			    // ***** OpSRem *************************************************
			    
			  case OpcodeTypeEnum.OpSRem
			    result.Append "SRem"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpStore *************************************************
			    
			  case OpcodeTypeEnum.OpStore
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
			    
			  case OpcodeTypeEnum.OpString
			    result.Append "String"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpSwitch *************************************************
			    
			  case OpcodeTypeEnum.OpSwitch
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
			    
			  case OpcodeTypeEnum.OpTextureFetchSample
			    result.Append "TextureFetchSample"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureFetchTexel *************************************************
			    
			  case OpcodeTypeEnum.OpTextureFetchTexel
			    result.Append "TextureFetchTexel"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureFetchTexelLod *************************************************
			    
			  case OpcodeTypeEnum.OpTextureFetchTexelLod
			    result.Append "TextureFetchTexelLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureFetchTexel *************************************************
			    
			  case OpcodeTypeEnum.OpTextureFetchTexelOffset
			    result.Append "TextureFetchTexelOffset"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureGather *************************************************
			    
			  case OpcodeTypeEnum.OpTextureGather
			    result.Append "TextureGather"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpTextureGatherOffset *************************************************
			    
			  case OpcodeTypeEnum.OpTextureGatherOffset
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
			    
			  case OpcodeTypeEnum.OpTextureGatherOffsets
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
			    
			  case OpcodeTypeEnum.OpTextureQueryLevels
			    result.Append "TextureQueryLevels"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQueryLod *************************************************
			    
			  case OpcodeTypeEnum.OpTextureQueryLod
			    result.Append "TextureQueryLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureQuerySamples *************************************************
			    
			  case OpcodeTypeEnum.OpTextureQuerySamples
			    result.Append "TextureQuerySamples"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQuerySize *************************************************
			    
			  case OpcodeTypeEnum.OpTextureQuerySize
			    result.Append "TextureQuerySize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQuerySizeLod *************************************************
			    
			  case OpcodeTypeEnum.OpTextureQuerySizeLod
			    result.Append "TextureQuerySizeLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureSample *************************************************
			    
			  case OpcodeTypeEnum.OpTextureSample
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
			    
			  case OpcodeTypeEnum.OpTextureSampleDref
			    result.Append "TextureSampleDref"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleGrad *************************************************
			    
			  case OpcodeTypeEnum.OpTextureSampleGrad
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
			    
			  case OpcodeTypeEnum.OpTextureSampleGradOffset
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
			    
			  case OpcodeTypeEnum.OpTextureSampleLod
			    result.Append "TextureSampleLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleLodOffset *************************************************
			    
			  case OpcodeTypeEnum.OpTextureSampleLodOffset
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
			    
			  case OpcodeTypeEnum.OpTextureSampleOffset
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
			    
			  case OpcodeTypeEnum.OpTextureSampleProj
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
			    
			  case OpcodeTypeEnum.OpTextureSampleProjGrad
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
			    
			  case OpcodeTypeEnum.OpTextureSampleProjGradOffset
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
			    
			  case OpcodeTypeEnum.OpTextureSampleProjLod
			    result.Append "TextureSampleProjLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleProjLodOffset *************************************************
			    
			  case OpcodeTypeEnum.OpTextureSampleProjLodOffset
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
			    
			  case OpcodeTypeEnum.OpTextureSampleProjOffset
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
			    
			  case OpcodeTypeEnum.OpTranspose
			    result.Append "Transpose"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTypeArray *************************************************
			    
			  case OpcodeTypeEnum.OpTypeArray
			    result.Append "TypeArray"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeBool *************************************************
			    
			  case OpcodeTypeEnum.OpTypeBool
			    result.Append "TypeBool"
			    
			    // ***** OpTypeDeviceEvent *************************************************
			    
			  case OpcodeTypeEnum.OpTypeDeviceEvent
			    result.Append "TypeDeviceEvent"
			    
			    // ***** OpTypeEvent *************************************************
			    
			  case OpcodeTypeEnum.OpTypeEvent
			    result.Append "TypeEvent"
			    
			    // ***** OpTypeFilter *************************************************
			    
			  case OpcodeTypeEnum.OpTypeFilter
			    result.Append "TypeFilter"
			    
			    // ***** OpTypeFloat *************************************************
			    
			  case OpcodeTypeEnum.OpTypeFloat
			    result.Append "TypeFloat"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpTypeFunction *************************************************
			    
			  case OpcodeTypeEnum.OpTypeFunction
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
			    
			  case OpcodeTypeEnum.OpTypeInt
			    result.Append "TypeInt"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    if VM.ModuleBinary.UInt32Value(Offset + 12) = 0 then
			      result.Append " Unsigned"
			    else
			      result.Append " Signed"
			    end if
			    
			    // ***** OpTypeMatrix *************************************************
			    
			  case OpcodeTypeEnum.OpTypeMatrix
			    result.Append "TypeMatrix"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeOpaque *************************************************
			    
			  case OpcodeTypeEnum.OpTypeOpaque
			    result.Append "TypeOpaque"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpTypePipe *************************************************
			    
			  case OpcodeTypeEnum.OpTypePipe
			    result.Append "TypePipe"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append SPIRVDescribeAccessQualifier(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypePointer *************************************************
			    
			  case OpcodeTypeEnum.OpTypePointer
			    result.Append "TypePointer"
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append compose_type(Offset + 12)
			    
			    // ***** OpTypeQueue *************************************************
			    
			  case OpcodeTypeEnum.OpTypeQueue
			    result.Append "TypeQueue"
			    
			    // ***** OpTypeReserveId *************************************************
			    
			  case OpcodeTypeEnum.OpTypeReserveId
			    result.Append "TypeReserveId"
			    
			    // ***** OpTypeRuntimeArray *************************************************
			    
			  case OpcodeTypeEnum.OpTypeRuntimeArray
			    result.Append "TypeRuntimeArray"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    
			    // ***** OpTypeSampler *************************************************
			    
			  case OpcodeTypeEnum.OpTypeSampler
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
			    
			  case OpcodeTypeEnum.OpTypeStruct
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
			    
			  case OpcodeTypeEnum.OpTypeVector
			    result.Append "TypeVector"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeVoid *************************************************
			    
			  case OpcodeTypeEnum.OpTypeVoid
			    result.Append "TypeVoid"
			    
			    // ***** OpUConvert *************************************************
			    
			  case OpcodeTypeEnum.OpUConvert
			    result.Append "UConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpUDiv *************************************************
			    
			  case OpcodeTypeEnum.OpUDiv
			    result.Append "UDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUGreaterThan *************************************************
			    
			  case OpcodeTypeEnum.OpUGreaterThan
			    result.Append "UGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUGreaterThanEqual *************************************************
			    
			  case OpcodeTypeEnum.OpUGreaterThanEqual
			    result.Append "UGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpULessThan *************************************************
			    
			  case OpcodeTypeEnum.OpULessThan
			    result.Append "ULessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpULessThanEqual *************************************************
			    
			  case OpcodeTypeEnum.OpULessThanEqual
			    result.Append "ULessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUMod *************************************************
			    
			  case OpcodeTypeEnum.OpUMod
			    result.Append "UMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUndef *************************************************
			    
			  case OpcodeTypeEnum.OpUndef
			    result.Append "Undef"
			    
			    // ***** OpUnordered *************************************************
			    
			  case OpcodeTypeEnum.OpUnordered
			    result.Append "Unordered"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUnreachable *************************************************
			    
			  case OpcodeTypeEnum.OpUnreachable
			    result.Append "Unreachable"
			    
			    // ***** OpVariable *************************************************
			    
			  case OpcodeTypeEnum.OpVariable
			    result.Append "Variable"
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    if WordCount > 4 then
			      break // todo: optional initializer
			    end if
			    
			    // ***** OpVariableArray *************************************************
			    
			  case OpcodeTypeEnum.OpVariableArray
			    result.Append "VariableArray"
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpVectorExtractDynamic *************************************************
			    
			  case OpcodeTypeEnum.OpVectorExtractDynamic
			    result.Append "VectorExtractDynamic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpVectorInsertDynamic *************************************************
			    
			  case OpcodeTypeEnum.OpVectorInsertDynamic
			    result.Append "VectorInsertDynamic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpVectorShuffle *************************************************
			    
			  case OpcodeTypeEnum.OpVectorShuffle
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
			    
			  case OpcodeTypeEnum.OpVectorTimesScalar
			    result.Append "VectorTimesScalar"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpVectorTimesMatrix *************************************************
			    
			  case OpcodeTypeEnum.OpVectorTimesMatrix
			    result.Append "VectorTimesMatrix"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpWaitGroupEvents *************************************************
			    
			  case OpcodeTypeEnum.OpWaitGroupEvents
			    result.Append "WaitGroupEvents"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpWritePipe *************************************************
			    
			  case OpcodeTypeEnum.OpWritePipe
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
			    
			  case OpcodeTypeEnum.OpAccessChain, OpcodeTypeEnum.OpAll, _
			    OpcodeTypeEnum.OpAny, _
			    OpcodeTypeEnum.OpArrayLength, _
			    OpcodeTypeEnum.OpAsyncGroupCopy, _
			    OpcodeTypeEnum.OpAtomicAnd, _
			    OpcodeTypeEnum.OpAtomicCompareExchange, OpcodeTypeEnum.OpAtomicCompareExchangeWeak, _
			    OpcodeTypeEnum.OpAtomicExchange, _
			    OpcodeTypeEnum.OpAtomicIAdd, _
			    OpcodeTypeEnum.OpAtomicIDecrement, OpcodeTypeEnum.OpAtomicIIncrement, _
			    OpcodeTypeEnum.OpAtomicIMax, _
			    OpcodeTypeEnum.OpAtomicIMin, _
			    OpcodeTypeEnum.OpAtomicISub, _
			    OpcodeTypeEnum.OpAtomicLoad, _
			    OpcodeTypeEnum.OpAtomicOr, _
			    OpcodeTypeEnum.OpAtomicUMax, _
			    OpcodeTypeEnum.OpAtomicUMin, _
			    OpcodeTypeEnum.OpAtomicXor, _
			    OpcodeTypeEnum.OpBitcast, _
			    OpcodeTypeEnum.OpBitwiseAnd, _
			    OpcodeTypeEnum.OpBitwiseOr, _
			    OpcodeTypeEnum.OpBitwiseXor, _
			    OpcodeTypeEnum.OpBuildNDRange, _
			    OpcodeTypeEnum.OpCompositeConstruct, _
			    OpcodeTypeEnum.OpCompositeExtract, OpcodeTypeEnum.OpCompositeInsert, _
			    OpcodeTypeEnum.OpConstant, OpcodeTypeEnum.OpConstantComposite, _
			    OpcodeTypeEnum.OpConstantFalse, OpcodeTypeEnum.OpConstantNullObject, _
			    OpcodeTypeEnum.OpConstantNullPointer, _
			    OpcodeTypeEnum.OpConstantSampler, OpcodeTypeEnum.OpConstantTrue, _
			    OpcodeTypeEnum.OpConvertFToS, _
			    OpcodeTypeEnum.OpConvertFToU, _
			    OpcodeTypeEnum.OpConvertPtrToU, _
			    OpcodeTypeEnum.OpConvertSToF, _
			    OpcodeTypeEnum.OpConvertUToF, _
			    OpcodeTypeEnum.OpConvertUToPtr, _
			    OpcodeTypeEnum.OpCopyObject, _
			    OpcodeTypeEnum.OpCreateUserEvent, _
			    OpcodeTypeEnum.OpDot, _
			    OpcodeTypeEnum.OpDPdx, OpcodeTypeEnum.OpDPdxCoarse, _
			    OpcodeTypeEnum.OpDPdxFine, _
			    OpcodeTypeEnum.OpDPdy, OpcodeTypeEnum.OpDPdyCoarse, _
			    OpcodeTypeEnum.OpDPdyFine, _
			    OpcodeTypeEnum.OpEnqueueKernel, _
			    OpcodeTypeEnum.OpEnqueueMarker, _
			    OpcodeTypeEnum.OpExtInst, _
			    OpcodeTypeEnum.OpFAdd, OpcodeTypeEnum.OpFConvert, _
			    OpcodeTypeEnum.OpFDiv, _
			    OpcodeTypeEnum.OpFMod, _
			    OpcodeTypeEnum.OpFMul, _
			    OpcodeTypeEnum.OpFNegate, _
			    OpcodeTypeEnum.OpFOrdEqual, _
			    OpcodeTypeEnum.OpFOrdGreaterThan, _
			    OpcodeTypeEnum.OpFOrdGreaterThanEqual, _
			    OpcodeTypeEnum.OpFOrdLessThan, _
			    OpcodeTypeEnum.OpFOrdLessThanEqual, _
			    OpcodeTypeEnum.OpFOrdNotEqual, _
			    OpcodeTypeEnum.OpFRem, _
			    OpcodeTypeEnum.OpFSub, OpcodeTypeEnum.OpFunction, _
			    OpcodeTypeEnum.OpFunctionCall, OpcodeTypeEnum.OpFunctionParameter, _
			    OpcodeTypeEnum.OpFUnordEqual, _
			    OpcodeTypeEnum.OpFUnordGreaterThan, _
			    OpcodeTypeEnum.OpFUnordGreaterThanEqual, _
			    OpcodeTypeEnum.OpFUnordLessThan, _
			    OpcodeTypeEnum.OpFUnordLessThanEqual, _
			    OpcodeTypeEnum.OpFUnordNotEqual, _
			    OpcodeTypeEnum.OpFwidth, OpcodeTypeEnum.OpFwidthCoarse, _
			    OpcodeTypeEnum.OpFwidthFine, _
			    OpcodeTypeEnum.OpGenericCastToPtr, _
			    OpcodeTypeEnum.OpGenericCastToPtrExplicit, _
			    OpcodeTypeEnum.OpGenericPtrMemSemantics, _
			    OpcodeTypeEnum.OpGetDefaultQueue, _
			    OpcodeTypeEnum.OpGetKernelNDrangeMaxSubGroupSize, _
			    OpcodeTypeEnum.OpGetKernelNDrangeSubGroupCount, _
			    OpcodeTypeEnum.OpGetKernelPreferredWorkGroupSizeMultiple, _
			    OpcodeTypeEnum.OpGetKernelWorkGroupSize, _
			    OpcodeTypeEnum.OpGetMaxPipePackets, _
			    OpcodeTypeEnum.OpGetNumPipePackets, _
			    OpcodeTypeEnum.OpGroupAll, _
			    OpcodeTypeEnum.OpGroupAny, _
			    OpcodeTypeEnum.OpGroupBroadcast, _
			    OpcodeTypeEnum.OpGroupFAdd, _
			    OpcodeTypeEnum.OpGroupFMax, _
			    OpcodeTypeEnum.OpGroupFMin, _
			    OpcodeTypeEnum.OpGroupIAdd, _
			    OpcodeTypeEnum.OpGroupReserveReadPipePackets, _
			    OpcodeTypeEnum.OpGroupReserveWritePipePackets, _
			    OpcodeTypeEnum.OpGroupSMax, _
			    OpcodeTypeEnum.OpGroupSMin, _
			    OpcodeTypeEnum.OpGroupUMax, _
			    OpcodeTypeEnum.OpGroupUMin, _
			    OpcodeTypeEnum.OpIAdd, _
			    OpcodeTypeEnum.OpIEqual, _
			    OpcodeTypeEnum.OpImagePointer, _
			    OpcodeTypeEnum.OpIMul, _
			    OpcodeTypeEnum.OpInBoundsAccessChain, _
			    OpcodeTypeEnum.OpINotEqual, _
			    OpcodeTypeEnum.OpIsFinite, _
			    OpcodeTypeEnum.OpIsInf, _
			    OpcodeTypeEnum.OpIsNan, _
			    OpcodeTypeEnum.OpIsNormal, _
			    OpcodeTypeEnum.OpISub, _
			    OpcodeTypeEnum.OpIsValidEvent, _
			    OpcodeTypeEnum.OpIsValidReserveId, _
			    OpcodeTypeEnum.OpLessOrGreater, _
			    OpcodeTypeEnum.OpLoad, _
			    OpcodeTypeEnum.OpLogicalAnd, _
			    OpcodeTypeEnum.OpLogicalOr, _
			    OpcodeTypeEnum.OpLogicalXor, _
			    OpcodeTypeEnum.OpMatrixTimesMatrix, _
			    OpcodeTypeEnum.OpMatrixTimesScalar, _
			    OpcodeTypeEnum.OpMatrixTimesVector, _
			    OpcodeTypeEnum.OpNot, _
			    OpcodeTypeEnum.OpOrdered, _
			    OpcodeTypeEnum.OpOuterProduct, _
			    OpcodeTypeEnum.OpPhi, _
			    OpcodeTypeEnum.OpPtrCastToGeneric, _
			    OpcodeTypeEnum.OpReadPipe, _
			    OpcodeTypeEnum.OpReservedReadPipe, _
			    OpcodeTypeEnum.OpReservedWritePipe, _
			    OpcodeTypeEnum.OpReserveReadPipePackets, _
			    OpcodeTypeEnum.OpReserveWritePipePackets, _
			    OpcodeTypeEnum.OpSampler, _
			    OpcodeTypeEnum.OpSatConvertSToU, _
			    OpcodeTypeEnum.OpSatConvertUToS, _
			    OpcodeTypeEnum.OpSConvert, _
			    OpcodeTypeEnum.OpSDiv, _
			    OpcodeTypeEnum.OpSelect, _
			    OpcodeTypeEnum.OpShiftLeftLogical, _
			    OpcodeTypeEnum.OpShiftRightArithmetic, _
			    OpcodeTypeEnum.OpShiftRightLogical, _
			    OpcodeTypeEnum.OpSignBitSet, _
			    OpcodeTypeEnum.OpSGreaterThan, _
			    OpcodeTypeEnum.OpSGreaterThanEqual, _
			    OpcodeTypeEnum.OpSLessThan, _
			    OpcodeTypeEnum.OpSLessThanEqual, _
			    OpcodeTypeEnum.OpSMod, _
			    OpcodeTypeEnum.OpSNegate, _
			    OpcodeTypeEnum.OpSpecConstant, OpcodeTypeEnum.OpSpecConstantFalse, _
			    OpcodeTypeEnum.OpSpecConstantComposite, OpcodeTypeEnum.OpSpecConstantTrue, _
			    OpcodeTypeEnum.OpSRem, _
			    OpcodeTypeEnum.OpTextureFetchSample, _
			    OpcodeTypeEnum.OpTextureFetchTexel, _
			    OpcodeTypeEnum.OpTextureFetchTexelLod, OpcodeTypeEnum.OpTextureFetchTexelOffset, _
			    OpcodeTypeEnum.OpTextureGather, OpcodeTypeEnum.OpTextureGatherOffset, _
			    OpcodeTypeEnum.OpTextureGatherOffsets, OpcodeTypeEnum.OpTextureQueryLevels, _
			    OpcodeTypeEnum.OpTextureQueryLod, OpcodeTypeEnum.OpTextureQuerySamples, _
			    OpcodeTypeEnum.OpTextureQuerySize, OpcodeTypeEnum.OpTextureQuerySizeLod, _
			    OpcodeTypeEnum.OpTextureSample, OpcodeTypeEnum.OpTextureSampleDref, _
			    OpcodeTypeEnum.OpTextureSampleGrad, OpcodeTypeEnum.OpTextureSampleGradOffset, _
			    OpcodeTypeEnum.OpTextureSampleLod, OpcodeTypeEnum.OpTextureSampleLodOffset, _
			    OpcodeTypeEnum.OpTextureSampleOffset, OpcodeTypeEnum.OpTextureSampleProj, _
			    OpcodeTypeEnum.OpTextureSampleProjGrad, OpcodeTypeEnum.OpTextureSampleProjGradOffset, _
			    OpcodeTypeEnum.OpTextureSampleProjLod, OpcodeTypeEnum.OpTextureSampleProjLodOffset, _
			    OpcodeTypeEnum.OpTextureSampleProjOffset, OpcodeTypeEnum.OpTranspose, _
			    OpcodeTypeEnum.OpUConvert, _
			    OpcodeTypeEnum.OpUDiv, _
			    OpcodeTypeEnum.OpUGreaterThan, _
			    OpcodeTypeEnum.OpUGreaterThanEqual, _
			    OpcodeTypeEnum.OpULessThan, _
			    OpcodeTypeEnum.OpULessThanEqual, _
			    OpcodeTypeEnum.OpUMod, _
			    OpcodeTypeEnum.OpUndef, _
			    OpcodeTypeEnum.OpUnordered, _
			    OpcodeTypeEnum.OpVariable, OpcodeTypeEnum.OpVariableArray, _
			    OpcodeTypeEnum.OpVectorExtractDynamic, OpcodeTypeEnum.OpVectorInsertDynamic, _
			    OpcodeTypeEnum.OpVectorShuffle, _
			    OpcodeTypeEnum.OpVectorTimesMatrix, _
			    OpcodeTypeEnum.OpVectorTimesScalar, _
			    OpcodeTypeEnum.OpWaitGroupEvents, _
			    OpcodeTypeEnum.OpWritePipe
			    
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			    
			  case OpcodeTypeEnum.OpDecorationGroup, OpcodeTypeEnum.OpExtInstImport, _
			    OpcodeTypeEnum.OpLabel, OpcodeTypeEnum.OpString, _
			    OpcodeTypeEnum.OpTypeArray, OpcodeTypeEnum.OpTypeBool, _
			    OpcodeTypeEnum.OpTypeDeviceEvent, OpcodeTypeEnum.OpTypeEvent, _
			    OpcodeTypeEnum.OpTypeFilter, OpcodeTypeEnum.OpTypeFloat, _
			    OpcodeTypeEnum.OpTypeFunction, OpcodeTypeEnum.OpTypeInt, _
			    OpcodeTypeEnum.OpTypeMatrix, OpcodeTypeEnum.OpTypeOpaque, _
			    OpcodeTypeEnum.OpTypePipe, OpcodeTypeEnum.OpTypePointer, _
			    OpcodeTypeEnum.OpTypeQueue, OpcodeTypeEnum.OpTypeReserveId, _
			    OpcodeTypeEnum.OpTypeRuntimeArray, OpcodeTypeEnum.OpTypeSampler, _
			    OpcodeTypeEnum.OpTypeStruct, OpcodeTypeEnum.OpTypeVector, _
			    OpcodeTypeEnum.OpTypeVoid
			    
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
			    
			  case OpcodeTypeEnum.OpAccessChain, OpcodeTypeEnum.OpAll, _
			    OpcodeTypeEnum.OpAny, _
			    OpcodeTypeEnum.OpArrayLength, _
			    OpcodeTypeEnum.OpAsyncGroupCopy, _
			    OpcodeTypeEnum.OpAtomicAnd, _
			    OpcodeTypeEnum.OpAtomicCompareExchange, OpcodeTypeEnum.OpAtomicCompareExchangeWeak, _
			    OpcodeTypeEnum.OpAtomicExchange, _
			    OpcodeTypeEnum.OpAtomicIAdd, _
			    OpcodeTypeEnum.OpAtomicIDecrement, OpcodeTypeEnum.OpAtomicIIncrement, _
			    OpcodeTypeEnum.OpAtomicIMax, _
			    OpcodeTypeEnum.OpAtomicIMin, _
			    OpcodeTypeEnum.OpAtomicISub, _
			    OpcodeTypeEnum.OpAtomicLoad, _
			    OpcodeTypeEnum.OpAtomicOr, _
			    OpcodeTypeEnum.OpAtomicUMax, _
			    OpcodeTypeEnum.OpAtomicUMin, _
			    OpcodeTypeEnum.OpAtomicXor, _
			    OpcodeTypeEnum.OpBitcast, _
			    OpcodeTypeEnum.OpBitwiseAnd, _
			    OpcodeTypeEnum.OpBitwiseOr, _
			    OpcodeTypeEnum.OpBitwiseXor, _
			    OpcodeTypeEnum.OpBuildNDRange, _
			    OpcodeTypeEnum.OpCompositeConstruct, OpcodeTypeEnum.OpCompositeExtract, _
			    OpcodeTypeEnum.OpCompositeInsert, _
			    OpcodeTypeEnum.OpConstant, _
			    OpcodeTypeEnum.OpConstantComposite, OpcodeTypeEnum.OpConstantFalse, _
			    OpcodeTypeEnum.OpConstantNullObject, OpcodeTypeEnum.OpConstantNullPointer, _
			    OpcodeTypeEnum.OpConstantSampler, OpcodeTypeEnum.OpConstantTrue, _
			    OpcodeTypeEnum.OpConvertFToS, _
			    OpcodeTypeEnum.OpConvertFToU, _
			    OpcodeTypeEnum.OpConvertPtrToU, _
			    OpcodeTypeEnum.OpConvertSToF, _
			    OpcodeTypeEnum.OpConvertUToF, _
			    OpcodeTypeEnum.OpConvertUToPtr, _
			    OpcodeTypeEnum.OpCopyObject, _
			    OpcodeTypeEnum.OpCreateUserEvent, _
			    OpcodeTypeEnum.OpDot, _
			    OpcodeTypeEnum.OpDPdx, OpcodeTypeEnum.OpDPdxCoarse, _
			    OpcodeTypeEnum.OpDPdxFine, _
			    OpcodeTypeEnum.OpDPdy, OpcodeTypeEnum.OpDPdyCoarse, _
			    OpcodeTypeEnum.OpDPdyFine, _
			    OpcodeTypeEnum.OpEnqueueKernel, _
			    OpcodeTypeEnum.OpEnqueueMarker, _
			    OpcodeTypeEnum.OpExtInst, _
			    OpcodeTypeEnum.OpFAdd, _
			    OpcodeTypeEnum.OpFConvert, _
			    OpcodeTypeEnum.OpFDiv, _
			    OpcodeTypeEnum.OpFMod, _
			    OpcodeTypeEnum.OpFMul, _
			    OpcodeTypeEnum.OpFNegate, _
			    OpcodeTypeEnum.OpFOrdEqual, _
			    OpcodeTypeEnum.OpFOrdGreaterThan, _
			    OpcodeTypeEnum.OpFOrdGreaterThanEqual, _
			    OpcodeTypeEnum.OpFOrdLessThan, _
			    OpcodeTypeEnum.OpFOrdLessThanEqual, _
			    OpcodeTypeEnum.OpFOrdNotEqual, _
			    OpcodeTypeEnum.OpFRem, _
			    OpcodeTypeEnum.OpFSub, _
			    OpcodeTypeEnum.OpFunction, OpcodeTypeEnum.OpFunctionCall, _
			    OpcodeTypeEnum.OpFunctionParameter, _
			    OpcodeTypeEnum.OpFUnordEqual, _
			    OpcodeTypeEnum.OpFUnordGreaterThan, _
			    OpcodeTypeEnum.OpFUnordGreaterThanEqual, _
			    OpcodeTypeEnum.OpFUnordLessThan, _
			    OpcodeTypeEnum.OpFUnordLessThanEqual, _
			    OpcodeTypeEnum.OpFUnordNotEqual, _
			    OpcodeTypeEnum.OpFwidth, OpcodeTypeEnum.OpFwidthCoarse, _
			    OpcodeTypeEnum.OpFwidthFine, _
			    OpcodeTypeEnum.OpGenericCastToPtr, _
			    OpcodeTypeEnum.OpGenericCastToPtrExplicit, _
			    OpcodeTypeEnum.OpGenericPtrMemSemantics, _
			    OpcodeTypeEnum.OpGetDefaultQueue, _
			    OpcodeTypeEnum.OpGetKernelNDrangeSubGroupCount, _
			    OpcodeTypeEnum.OpGetKernelNDrangeMaxSubGroupSize, _
			    OpcodeTypeEnum.OpGetKernelPreferredWorkGroupSizeMultiple, _
			    OpcodeTypeEnum.OpGetKernelWorkGroupSize, _
			    OpcodeTypeEnum.OpGetMaxPipePackets, _
			    OpcodeTypeEnum.OpGetNumPipePackets, _
			    OpcodeTypeEnum.OpGroupAll, _
			    OpcodeTypeEnum.OpGroupAny, _
			    OpcodeTypeEnum.OpGroupBroadcast, _
			    OpcodeTypeEnum.OpGroupFAdd, _
			    OpcodeTypeEnum.OpGroupFMax, _
			    OpcodeTypeEnum.OpGroupFMin, _
			    OpcodeTypeEnum.OpGroupIAdd, _
			    OpcodeTypeEnum.OpGroupReserveReadPipePackets, _
			    OpcodeTypeEnum.OpGroupReserveWritePipePackets, _
			    OpcodeTypeEnum.OpGroupSMax, _
			    OpcodeTypeEnum.OpGroupSMin, _
			    OpcodeTypeEnum.OpGroupUMax, _
			    OpcodeTypeEnum.OpGroupUMin, _
			    OpcodeTypeEnum.OpIAdd, _
			    OpcodeTypeEnum.OpIEqual, _
			    OpcodeTypeEnum.OpImagePointer, _
			    OpcodeTypeEnum.OpIMul, _
			    OpcodeTypeEnum.OpInBoundsAccessChain, _
			    OpcodeTypeEnum.OpINotEqual, _
			    OpcodeTypeEnum.OpIsFinite, _
			    OpcodeTypeEnum.OpIsInf, _
			    OpcodeTypeEnum.OpIsNan, _
			    OpcodeTypeEnum.OpIsNormal, _
			    OpcodeTypeEnum.OpISub, _
			    OpcodeTypeEnum.OpIsValidEvent, _
			    OpcodeTypeEnum.OpIsValidReserveId, _
			    OpcodeTypeEnum.OpLessOrGreater, _
			    OpcodeTypeEnum.OpLoad, _
			    OpcodeTypeEnum.OpLogicalAnd, _
			    OpcodeTypeEnum.OpLogicalOr, _
			    OpcodeTypeEnum.OpLogicalXor, _
			    OpcodeTypeEnum.OpMatrixTimesMatrix, _
			    OpcodeTypeEnum.OpMatrixTimesScalar, _
			    OpcodeTypeEnum.OpMatrixTimesVector, _
			    OpcodeTypeEnum.OpNot, _
			    OpcodeTypeEnum.OpOrdered, _
			    OpcodeTypeEnum.OpOuterProduct, _
			    OpcodeTypeEnum.OpPhi, _
			    OpcodeTypeEnum.OpPtrCastToGeneric, _
			    OpcodeTypeEnum.OpReadPipe, _
			    OpcodeTypeEnum.OpReservedReadPipe, _
			    OpcodeTypeEnum.OpReservedWritePipe, _
			    OpcodeTypeEnum.OpReserveReadPipePackets, _
			    OpcodeTypeEnum.OpReserveWritePipePackets, _
			    OpcodeTypeEnum.OpSampler, _
			    OpcodeTypeEnum.OpSatConvertSToU, _
			    OpcodeTypeEnum.OpSatConvertUToS, _
			    OpcodeTypeEnum.OpSConvert, _
			    OpcodeTypeEnum.OpSDiv, _
			    OpcodeTypeEnum.OpSelect, _
			    OpcodeTypeEnum.OpShiftLeftLogical, _
			    OpcodeTypeEnum.OpShiftRightArithmetic, _
			    OpcodeTypeEnum.OpShiftRightLogical, _
			    OpcodeTypeEnum.OpSignBitSet, _
			    OpcodeTypeEnum.OpSGreaterThan, _
			    OpcodeTypeEnum.OpSGreaterThanEqual, _
			    OpcodeTypeEnum.OpSLessThan, _
			    OpcodeTypeEnum.OpSLessThanEqual, _
			    OpcodeTypeEnum.OpSMod, _
			    OpcodeTypeEnum.OpSNegate, _
			    OpcodeTypeEnum.OpSpecConstant, _
			    OpcodeTypeEnum.OpSpecConstantComposite, OpcodeTypeEnum.OpSpecConstantFalse, _
			    OpcodeTypeEnum.OpSpecConstantTrue, _
			    OpcodeTypeEnum.OpSRem, _
			    OpcodeTypeEnum.OpTextureFetchSample, _
			    OpcodeTypeEnum.OpTextureFetchTexel, _
			    OpcodeTypeEnum.OpTextureFetchTexelLod, OpcodeTypeEnum.OpTextureFetchTexelOffset, _
			    OpcodeTypeEnum.OpTextureGather, OpcodeTypeEnum.OpTextureGatherOffset, _
			    OpcodeTypeEnum.OpTextureGatherOffsets, OpcodeTypeEnum.OpTextureQueryLevels, _
			    OpcodeTypeEnum.OpTextureQueryLod, OpcodeTypeEnum.OpTextureQuerySamples, _
			    OpcodeTypeEnum.OpTextureQuerySize, OpcodeTypeEnum.OpTextureQuerySizeLod, _
			    OpcodeTypeEnum.OpTextureSample, OpcodeTypeEnum.OpTextureSampleDref, _
			    OpcodeTypeEnum.OpTextureSampleGrad, OpcodeTypeEnum.OpTextureSampleGradOffset, _
			    OpcodeTypeEnum.OpTextureSampleLod, OpcodeTypeEnum.OpTextureSampleLodOffset, _
			    OpcodeTypeEnum.OpTextureSampleOffset, _
			    OpcodeTypeEnum.OpTextureSampleProj, OpcodeTypeEnum.OpTextureSampleProjGrad, _
			    OpcodeTypeEnum.OpTextureSampleProjGradOffset, _
			    OpcodeTypeEnum.OpTextureSampleProjLod, OpcodeTypeEnum.OpTextureSampleProjLodOffset, _
			    OpcodeTypeEnum.OpTextureSampleProjOffset, _
			    OpcodeTypeEnum.OpTranspose, _
			    OpcodeTypeEnum.OpUConvert, _
			    OpcodeTypeEnum.OpUDiv, _
			    OpcodeTypeEnum.OpUGreaterThan, _
			    OpcodeTypeEnum.OpUGreaterThanEqual, _
			    OpcodeTypeEnum.OpULessThan, _
			    OpcodeTypeEnum.OpULessThanEqual, _
			    OpcodeTypeEnum.OpUMod, _
			    OpcodeTypeEnum.OpUndef, _
			    OpcodeTypeEnum.OpUnordered, _
			    OpcodeTypeEnum.OpVariable, _
			    OpcodeTypeEnum.OpVariableArray, OpcodeTypeEnum.OpVectorExtractDynamic, _
			    OpcodeTypeEnum.OpVectorInsertDynamic, OpcodeTypeEnum.OpVectorShuffle, _
			    OpcodeTypeEnum.OpVectorTimesMatrix, _
			    OpcodeTypeEnum.OpVectorTimesScalar, _
			    OpcodeTypeEnum.OpWaitGroupEvents, _
			    OpcodeTypeEnum.OpWritePipe
			    
			    result = compose_type(Offset + 4)
			    
			  end select
			  
			  return result
			  
			End Get
		#tag EndGetter
		ResultType As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Type As OpcodeTypeEnum
	#tag EndProperty

	#tag Property, Flags = &h0
		VM As SPIRV.VirtualMachine
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
				"13 - OpAtomicIMax"
				"14 - OpAtomicIMin"
				"15 - OpAtomicISub"
				"16 - OpAtomicInit"
				"17 - OpAtomicLoad"
				"18 - OpAtomicOr"
				"19 - OpAtomicStore"
				"20 - OpAtomicUMax"
				"21 - OpAtomicUMin"
				"22 - OpAtomicXor"
				"23 - OpBitcast"
				"24 - OpBitwiseAnd"
				"25 - OpBitwiseOr"
				"26 - OpBitwiseXor"
				"27 - OpBranch"
				"28 - OpBranchConditional"
				"29 - OpBuildNDRange"
				"30 - OpCaptureEventProfilingInfo"
				"31 - OpCommitReadPipe"
				"32 - OpCommitWritePipe"
				"33 - OpCompileFlag"
				"34 - OpCompositeConstruct"
				"35 - OpCompositeExtract"
				"36 - OpCompositeInsert"
				"37 - OpConstant"
				"38 - OpConstantFalse"
				"39 - OpConstantNullObject"
				"40 - OpConstantNullPointer"
				"41 - OpConstantSampler"
				"42 - OpConstantTrue"
				"43 - OpConstantComposite"
				"44 - OpControlBarrier"
				"45 - OpConvertFToU"
				"46 - OpConvertFToS"
				"47 - OpConvertPtrToU"
				"48 - OpConvertSToF"
				"49 - OpConvertUToF"
				"50 - OpConvertUToPtr"
				"51 - OpCopyMemory"
				"52 - OpCopyMemorySized"
				"53 - OpCopyObject"
				"54 - OpCreateUserEvent"
				"55 - OpDecorate"
				"56 - OpDecorationGroup"
				"57 - OpDot"
				"58 - OpDPdx"
				"59 - OpDPdxCoarse"
				"60 - OpDPdxFine"
				"61 - OpDPdy"
				"62 - OpDPdyCoarse"
				"63 - OpDPdyFine"
				"64 - OpEmitStreamVertex"
				"65 - OpEmitVertex"
				"66 - OpEndPrimitive"
				"67 - OpEndStreamPrimitive"
				"68 - OpEnqueueKernel"
				"69 - OpEnqueueMarker"
				"70 - OpEntryPoint"
				"71 - OpExecutionMode"
				"72 - OpExtension"
				"73 - OpExtInst"
				"74 - OpExtInstImport"
				"75 - OpFAdd"
				"76 - OpFConvert"
				"77 - OpFDiv"
				"78 - OpFMod"
				"79 - OpFMul"
				"80 - OpFNegate"
				"81 - OpFOrdEqual"
				"82 - OpFOrdGreaterThan"
				"83 - OpFOrdGreaterThanEqual"
				"84 - OpFOrdLessThan"
				"85 - OpFOrdLessThanEqual"
				"86 - OpFOrdNotEqual"
				"87 - OpFRem"
				"88 - OpFSub"
				"89 - OpFunction"
				"90 - OpFunctionCall"
				"91 - OpFunctionEnd"
				"92 - OpFunctionParameter"
				"93 - OpFUnordEqual"
				"94 - OpFUnordGreaterThan"
				"95 - OpFUnordGreaterThanEqual"
				"96 - OpFUnordLessThan"
				"97 - OpFUnordLessThanEqual"
				"98 - OpFUnordNotEqual"
				"99 - OpFwidth"
				"100 - OpFwidthCoarse"
				"101 - OpFwidthFine"
				"102 - OpGenericCastToPtr"
				"103 - OpGenericCastToPtrExplicit"
				"104 - OpGenericPtrMemSemantics"
				"105 - OpGetDefaultQueue"
				"106 - OpGetKernelNDrangeMaxSubGroupSize"
				"107 - OpGetKernelNDrangeSubGroupCount"
				"108 - OpGetKernelPreferredWorkGroupSizeMultiple"
				"109 - OpGetKernelWorkGroupSize"
				"110 - OpGetMaxPipePackets"
				"111 - OpGetNumPipePackets"
				"112 - OpGroupAll"
				"113 - OpGroupAny"
				"114 - OpGroupBroadcast"
				"115 - OpGroupCommitReadPipe"
				"116 - OpGroupCommitWritePipe"
				"117 - OpGroupDecorate"
				"118 - OpGroupFAdd"
				"119 - OpGroupFMax"
				"120 - OpGroupFMin"
				"121 - OpGroupIAdd"
				"122 - OpGroupMemberDecorate"
				"123 - OpGroupReserveReadPipePackets"
				"124 - OpGroupReserveWritePipePackets"
				"125 - OpGroupSMax"
				"126 - OpGroupSMin"
				"127 - OpGroupUMax"
				"128 - OpGroupUMin"
				"129 - OpIAdd"
				"130 - OpIEqual"
				"131 - OpImagePointer"
				"132 - OpIMul"
				"133 - OpINotEqual"
				"134 - OpInBoundsAccessChain"
				"135 - OpIsFinite"
				"136 - OpIsInf"
				"137 - OpIsNan"
				"138 - OpIsNormal"
				"139 - OpISub"
				"140 - OpIsValidEvent"
				"141 - OpIsValidReserveId"
				"142 - OpKill"
				"143 - OpLabel"
				"144 - OpLessOrGreater"
				"145 - OpLifetimeStart"
				"146 - OpLifetimeStop"
				"147 - OpLine"
				"148 - OpLoad"
				"149 - OpLogicalAnd"
				"150 - OpLogicalOr"
				"151 - OpLogicalXor"
				"152 - OpLoopMerge"
				"153 - OpMatrixTimesMatrix"
				"154 - OpMatrixTimesScalar"
				"155 - OpMatrixTimesVector"
				"156 - OpMemberDecorate"
				"157 - OpMemberName"
				"158 - OpMemoryBarrier"
				"159 - OpMemoryModel"
				"160 - OpName"
				"161 - OpNop"
				"162 - OpNot"
				"163 - OpOrdered"
				"164 - OpOuterProduct"
				"165 - OpPhi"
				"166 - OpPtrCastToGeneric"
				"167 - OpReadPipe"
				"168 - OpReleaseEvent"
				"169 - OpReservedReadPipe"
				"170 - OpReservedWritePipe"
				"171 - OpReserveReadPipePackets"
				"172 - OpReserveWritePipePackets"
				"173 - OpRetainEvent"
				"174 - OpReturn"
				"175 - OpReturnValue"
				"176 - OpSampler"
				"177 - OpSatConvertSToU"
				"178 - OpSatConvertUToS"
				"179 - OpSConvert"
				"180 - OpSDiv"
				"181 - OpSelect"
				"182 - OpSelectionMerge"
				"183 - OpSetUserEventStatus"
				"184 - OpShiftLeftLogical"
				"185 - OpShiftRightArithmetic"
				"186 - OpShiftRightLogical"
				"187 - OpSignBitSet"
				"188 - OpSGreaterThan"
				"189 - OpSGreaterThanEqual"
				"190 - OpSLessThan"
				"191 - OpSLessThanEqual"
				"192 - OpSNegate"
				"193 - OpSMod"
				"194 - OpSource"
				"195 - OpSourceExtension"
				"196 - OpSpecConstant"
				"197 - OpSpecConstantComposite"
				"198 - OpSpecConstantFalse"
				"199 - OpSpecConstantTrue"
				"200 - OpSRem"
				"201 - OpStore"
				"202 - OpString"
				"203 - OpSwitch"
				"204 - OpTextureFetchSample"
				"205 - OpTextureFetchTexel"
				"206 - OpTextureFetchTexelLod"
				"207 - OpTextureFetchTexelOffset"
				"208 - OpTextureGather"
				"209 - OpTextureGatherOffset"
				"210 - OpTextureGatherOffsets"
				"211 - OpTextureQueryLevels"
				"212 - OpTextureQueryLod"
				"213 - OpTextureQuerySamples"
				"214 - OpTextureQuerySize"
				"215 - OpTextureQuerySizeLod"
				"216 - OpTextureSample"
				"217 - OpTextureSampleDref"
				"218 - OpTextureSampleGrad"
				"219 - OpTextureSampleGradOffset"
				"220 - OpTextureSampleLod"
				"221 - OpTextureSampleLodOffset"
				"222 - OpTextureSampleOffset"
				"223 - OpTextureSampleProj"
				"224 - OpTextureSampleProjGrad"
				"225 - OpTextureSampleProjGradOffset"
				"226 - OpTextureSampleProjLod"
				"227 - OpTextureSampleProjLodOffset"
				"228 - OpTextureSampleProjOffset"
				"229 - OpTranspose"
				"230 - OpTypeArray"
				"231 - OpTypeBool"
				"232 - OpTypeDeviceEvent"
				"233 - OpTypeEvent"
				"234 - OpTypeFilter"
				"235 - OpTypeFloat"
				"236 - OpTypeFunction"
				"237 - OpTypeInt"
				"238 - OpTypeMatrix"
				"239 - OpTypeOpaque"
				"240 - OpTypePipe"
				"241 - OpTypePointer"
				"242 - OpTypeQueue"
				"243 - OpTypeReserveId"
				"244 - OpTypeRuntimeArray"
				"245 - OpTypeSampler"
				"246 - OpTypeStruct"
				"247 - OpTypeVector"
				"248 - OpTypeVoid"
				"249 - OpUConvert"
				"250 - OpUDiv"
				"251 - OpUGreaterThan"
				"252 - OpUGreaterThanEqual"
				"253 - OpULessThanEqual"
				"254 - OpULessThan"
				"255 - OpUMod"
				"256 - OpUndef"
				"257 - OpUnordered"
				"258 - OpUnreachable"
				"259 - OpVariable"
				"260 - OpVariableArray"
				"261 - OpVectorExtractDynamic"
				"262 - OpVectorInsertDynamic"
				"263 - OpVectorShuffle"
				"264 - OpVectorTimesMatrix"
				"265 - OpVectorTimesScalar"
				"266 - OpWaitGroupEvents"
				"267 - OpWritePipe"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
