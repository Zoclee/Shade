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
		Sub Constructor(initVM As SPIRV.VirtualMachine, initType As OpcodeEnum)
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

	#tag Property, Flags = &h0
		Index As UInt32
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			  ' www.zoclee.com/shade
			  
			  Dim result() As String
			  Dim i As UInt32
			  Dim ub As UInt32
			  
			  select case Type
			    
			    // ***** OpAccessChain *************************************************
			    
			  case OpcodeEnum.OpAccessChain
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
			    
			  case OpcodeEnum.OpAll
			    result.Append "All"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpAny *************************************************
			    
			  case OpcodeEnum.OpAny
			    result.Append "Any"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpArrayLength *************************************************
			    
			  case OpcodeEnum.OpArrayLength
			    result.Append "ArrayLength"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpAsyncGroupCopy *************************************************
			    
			  case OpcodeEnum.OpAsyncGroupCopy
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
			    
			  case OpcodeEnum.OpAtomicAnd
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
			    
			  case OpcodeEnum.OpAtomicCompareExchange
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
			    
			  case OpcodeEnum.OpAtomicCompareExchangeWeak
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
			    
			  case OpcodeEnum.OpAtomicExchange
			    result.Append "AtomicExchange"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIAdd *************************************************
			    
			  case OpcodeEnum.OpAtomicIAdd
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
			    
			  case OpcodeEnum.OpAtomicIDecrement
			    result.Append "AtomicIDecrement"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIIncrement *************************************************
			    
			  case OpcodeEnum.OpAtomicIIncrement
			    result.Append "AtomicIIncrement"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpAtomicIMax *************************************************
			    
			  case OpcodeEnum.OpAtomicIMax
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
			    
			  case OpcodeEnum.OpAtomicIMin
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
			    
			  case OpcodeEnum.OpAtomicISub
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
			    
			  case OpcodeEnum.OpAtomicInit
			    result.Append "AtomicInit"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpAtomicLoad *************************************************
			    
			  case OpcodeEnum.OpAtomicLoad
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
			    
			  case OpcodeEnum.OpAtomicOr
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
			    
			  case OpcodeEnum.OpAtomicStore
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
			    
			  case OpcodeEnum.OpAtomicUMax
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
			    
			  case OpcodeEnum.OpAtomicUMin
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
			    
			  case OpcodeEnum.OpAtomicXor
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
			    
			  case OpcodeEnum.OpBitcast
			    result.Append "Bitcast"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpBitwiseAnd *************************************************
			    
			  case OpcodeEnum.OpBitwiseAnd
			    result.Append "BitwiseAnd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBitwiseOr *************************************************
			    
			  case OpcodeEnum.OpBitwiseOr
			    result.Append "BitwiseOr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBitwiseXor *************************************************
			    
			  case OpcodeEnum.OpBitwiseXor
			    result.Append "BitwiseXor"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpBranch *************************************************
			    
			  case OpcodeEnum.OpBranch
			    result.Append "Branch"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpBranchConditional *************************************************
			    
			  case OpcodeEnum.OpBranchConditional
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
			    
			  case OpcodeEnum.OpBuildNDRange
			    result.Append "BuildNDRange"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpCaptureEventProfilingInfo *************************************************
			    
			  case OpcodeEnum.OpCaptureEventProfilingInfo
			    result.Append "CaptureEventProfilingInfo"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeKernelProfilingInfoMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCommitReadPipe *************************************************
			    
			  case OpcodeEnum.OpCommitReadPipe
			    result.Append "CommitReadPipe"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpCommitWritePipe *************************************************
			    
			  case OpcodeEnum.OpCommitWritePipe
			    result.Append "CommitWritePipe"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpCompileFlag ************************************************
			    
			  case OpcodeEnum.OpCompileFlag
			    result.Append "CompileFlag"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpCompositeConstruct *************************************************
			    
			  case OpcodeEnum.OpCompositeConstruct
			    result.Append "CompositeConstruct"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpCompositeExtract *************************************************
			    
			  case OpcodeEnum.OpCompositeExtract
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
			    
			  case OpcodeEnum.OpCompositeInsert
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
			    
			  case OpcodeEnum.OpConstant
			    result.Append "Constant"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpConstantComposite *************************************************
			    
			  case OpcodeEnum.OpConstantComposite
			    result.Append "ConstantComposite"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpConstantFalse *************************************************
			    
			  case OpcodeEnum.OpConstantFalse
			    result.Append "ConstantFalse"
			    
			    // ***** OpConstantNullObject *************************************************
			    
			  case OpcodeEnum.OpConstantNullObject
			    result.Append "ConstantNullObject"
			    
			    // ***** OpConstantNullPointer *************************************************
			    
			  case OpcodeEnum.OpConstantNullPointer
			    result.Append "ConstantNullPointer"
			    
			    // ***** OpConstantSampler *************************************************
			    
			  case OpcodeEnum.OpConstantSampler
			    result.Append "ConstantSampler"
			    result.Append " "
			    result.Append SPIRVDescribeSamplerAddressingMode(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeParam(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append SPIRVDescribeSamplerFilterMode(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpConstantTrue *************************************************
			    
			  case OpcodeEnum.OpConstantTrue
			    result.Append "ConstantTrue"
			    
			    // ***** OpControlBarrier *************************************************
			    
			  case OpcodeEnum.OpControlBarrier
			    result.Append "ControlBarrier"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    
			    // ***** OpConvertFToS *************************************************
			    
			  case OpcodeEnum.OpConvertFToS
			    result.Append "ConvertFToS"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertFToU *************************************************
			    
			  case OpcodeEnum.OpConvertFToU
			    result.Append "ConvertFToU"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertPtrToU *************************************************
			    
			  case OpcodeEnum.OpConvertPtrToU
			    result.Append "ConvertPtrToU"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertSToF *************************************************
			    
			  case OpcodeEnum.OpConvertSToF
			    result.Append "ConvertSToF"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpConvertUToF *************************************************
			    
			  case OpcodeEnum.OpConvertUToF
			    result.Append "ConvertUToF"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** ConvertUToPtr *************************************************
			    
			  case OpcodeEnum.OpConvertUToPtr
			    result.Append "ConvertUToPtr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCopyMemory *************************************************
			    
			  case OpcodeEnum.OpCopyMemory
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
			    
			  case OpcodeEnum.OpCopyMemorySized
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
			    
			  case OpcodeEnum.OpCopyObject
			    result.Append "CopyObject"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpCreateUserEvent *************************************************
			    
			  case OpcodeEnum.OpCreateUserEvent
			    result.Append "CreateUserEvent"
			    
			    // ***** OpDecorate *************************************************
			    
			  case OpcodeEnum.OpDecorate
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
			    
			  case OpcodeEnum.OpDecorationGroup
			    result.Append "DecorationGroup"
			    
			    // ***** OpDot *************************************************
			    
			  case OpcodeEnum.OpDot
			    result.Append "Dot"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpDPdx *************************************************
			    
			  case OpcodeEnum.OpDPdx
			    result.Append "DPdx"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdxCoarse *************************************************
			    
			  case OpcodeEnum.OpDPdxCoarse
			    result.Append "DPdxCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdxFine *************************************************
			    
			  case OpcodeEnum.OpDPdxFine
			    result.Append "DPdxFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdy *************************************************
			    
			  case OpcodeEnum.OpDPdy
			    result.Append "DPdy"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdyCoarse *************************************************
			    
			  case OpcodeEnum.OpDPdyCoarse
			    result.Append "DPdyCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpDPdyFine *************************************************
			    
			  case OpcodeEnum.OpDPdyFine
			    result.Append "DPdyFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpEmitStreamVertex *************************************************
			    
			  case OpcodeEnum.OpEmitStreamVertex
			    result.Append "EmitStreamVertex"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpEndStreamPrimitive *************************************************
			    
			  case OpcodeEnum.OpEndStreamPrimitive
			    result.Append "EndStreamPrimitive"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpEmitVertex *************************************************
			    
			  case OpcodeEnum.OpEmitVertex
			    result.Append "EmitVertex"
			    
			    // ***** OpEndPrimitive *************************************************
			    
			  case OpcodeEnum.OpEndPrimitive
			    result.Append "EndPrimitive"
			    
			    // ***** OpEnqueueKernel *************************************************
			    
			  case OpcodeEnum.OpEnqueueKernel
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
			    
			  case OpcodeEnum.OpEnqueueMarker
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
			    
			  case OpcodeEnum.OpEntryPoint
			    result.Append "EntryPoint"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpExecutionMode *************************************************
			    
			  case OpcodeEnum.OpExecutionMode
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
			    
			  case OpcodeEnum.OpExtension
			    result.Append "Extension"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpExtInst *************************************************
			    
			  case OpcodeEnum.OpExtInst
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
			    
			  case OpcodeEnum.OpExtInstImport
			    result.Append "ExtInstImport"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpFAdd *************************************************
			    
			  case OpcodeEnum.OpFAdd
			    result.Append "FAdd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFConvert *************************************************
			    
			  case OpcodeEnum.OpFConvert
			    result.Append "FConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFDiv *************************************************
			    
			  case OpcodeEnum.OpFDiv
			    result.Append "FDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFMod *************************************************
			    
			  case OpcodeEnum.OpFMod
			    result.Append "FMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFMul *************************************************
			    
			  case OpcodeEnum.OpFMul
			    result.Append "FMul"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFNegate *************************************************
			    
			  case OpcodeEnum.OpFNegate
			    result.Append "FNegate"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFOrdEqual *************************************************
			    
			  case OpcodeEnum.OpFOrdEqual
			    result.Append "FOrdEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdGreaterThan *************************************************
			    
			  case OpcodeEnum.OpFOrdGreaterThan
			    result.Append "FOrdGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdGreaterThanEqual *************************************************
			    
			  case OpcodeEnum.OpFOrdGreaterThanEqual
			    result.Append "FOrdGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    
			    // ***** OpFOrdLessThan *************************************************
			    
			  case OpcodeEnum.OpFOrdLessThan
			    result.Append "FOrdLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdLessThanEqual *************************************************
			    
			  case OpcodeEnum.OpFOrdLessThanEqual
			    result.Append "FOrdLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFOrdNotEqual *************************************************
			    
			  case OpcodeEnum.OpFOrdNotEqual
			    result.Append "FOrdNotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFRem *************************************************
			    
			  case OpcodeEnum.OpFRem
			    result.Append "FRem"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFSub *************************************************
			    
			  case OpcodeEnum.OpFSub
			    result.Append "FSub"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFunction *************************************************
			    
			  case OpcodeEnum.OpFunction
			    result.Append "Function"
			    result.Append " "
			    result.Append SPIRVDescribeFunctionControlMask(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_type(Offset + 16)
			    
			    // ***** OpFunctionCall *************************************************
			    
			  case OpcodeEnum.OpFunctionCall
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
			    
			  case OpcodeEnum.OpFunctionEnd
			    result.Append "FunctionEnd"
			    
			    // ***** OpFunctionParameter *************************************************
			    
			  case OpcodeEnum.OpFunctionParameter
			    result.Append "FunctionParameter"
			    
			    // ***** OpFUnordEqual *************************************************
			    
			  case OpcodeEnum.OpFUnordEqual
			    result.Append "FUnordEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordGreaterThan *************************************************
			    
			  case OpcodeEnum.OpFUnordGreaterThan
			    result.Append "FUnordGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordGreaterThanEqual *************************************************
			    
			  case OpcodeEnum.OpFUnordGreaterThanEqual
			    result.Append "FUnordGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordLessThan *************************************************
			    
			  case OpcodeEnum.OpFUnordLessThan
			    result.Append "FUnordLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordLessThanEqual *************************************************
			    
			  case OpcodeEnum.OpFUnordLessThanEqual
			    result.Append "FUnordLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFUnordNotEqual *************************************************
			    
			  case OpcodeEnum.OpFUnordNotEqual
			    result.Append "FUnordNotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpFwidth *************************************************
			    
			  case OpcodeEnum.OpFwidth
			    result.Append "Fwidth"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFwidthCoarse *************************************************
			    
			  case OpcodeEnum.OpFwidthCoarse
			    result.Append "FwidthCoarse"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpFwidthFine *************************************************
			    
			  case OpcodeEnum.OpFwidthFine
			    result.Append "FwidthFine"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGenericCastToPtr *************************************************
			    
			  case OpcodeEnum.OpGenericCastToPtr
			    result.Append "GenericCastToPtr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGenericCastToPtrExplicit *************************************************
			    
			  case OpcodeEnum.OpGenericCastToPtrExplicit
			    result.Append "GenericCastToPtrExplicit"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpGenericPtrMemSemantics *************************************************
			    
			  case OpcodeEnum.OpGenericPtrMemSemantics
			    result.Append "GenericPtrMemSemantics"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetDefaultQueue *************************************************
			    
			  case OpcodeEnum.OpGetDefaultQueue
			    result.Append "GetDefaultQueue"
			    
			    // ***** OpGetKernelNDrangeMaxSubGroupSize *************************************************
			    
			  case OpcodeEnum.OpGetKernelNDrangeMaxSubGroupSize
			    result.Append "GetKernelNDrangeMaxSubGroupSize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGetKernelNDrangeSubGroupCount *************************************************
			    
			  case OpcodeEnum.OpGetKernelNDrangeSubGroupCount
			    result.Append "GetKernelNDrangeSubGroupCount"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGetKernelPreferredWorkGroupSizeMultiple *************************************************
			    
			  case OpcodeEnum.OpGetKernelPreferredWorkGroupSizeMultiple
			    result.Append "GetKernelPreferredWorkGroupSizeMultiple"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetKernelWorkGroupSize *************************************************
			    
			  case OpcodeEnum.OpGetKernelWorkGroupSize
			    result.Append "GetKernelWorkGroupSize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetMaxPipePackets *************************************************
			    
			  case OpcodeEnum.OpGetMaxPipePackets
			    result.Append "GetMaxPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGetNumPipePackets *************************************************
			    
			  case OpcodeEnum.OpGetNumPipePackets
			    result.Append "GetNumPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupAll *************************************************
			    
			  case OpcodeEnum.OpGroupAll
			    result.Append "GroupAll"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGroupAll *************************************************
			    
			  case OpcodeEnum.OpGroupAny
			    result.Append "GroupAny"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpGroupBroadcast *************************************************
			    
			  case OpcodeEnum.OpGroupBroadcast
			    result.Append "GroupBroadcast"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupCommitReadPipe *************************************************
			    
			  case OpcodeEnum.OpGroupCommitReadPipe
			    result.Append "GroupCommitReadPipe"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupCommitWritePipe *************************************************
			    
			  case OpcodeEnum.OpGroupCommitWritePipe
			    result.Append "GroupCommitWritePipe"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpGroupDecorate *************************************************
			    
			  case OpcodeEnum.OpGroupDecorate
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
			    
			  case OpcodeEnum.OpGroupFAdd
			    result.Append "GroupFAdd"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupFMax *************************************************
			    
			  case OpcodeEnum.OpGroupFMax
			    result.Append "GroupFMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupFMin *************************************************
			    
			  case OpcodeEnum.OpGroupFMin
			    result.Append "GroupFMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupIAdd *************************************************
			    
			  case OpcodeEnum.OpGroupIAdd
			    result.Append "GroupIAdd"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupReserveReadPipePackets *************************************************
			    
			  case OpcodeEnum.OpGroupReserveReadPipePackets
			    result.Append "GroupReserveReadPipePackets"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupReserveWritePipePackets *************************************************
			    
			  case OpcodeEnum.OpGroupReserveWritePipePackets
			    result.Append "GroupReserveWritePipePackets"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupSMax *************************************************
			    
			  case OpcodeEnum.OpGroupSMax
			    result.Append "GroupSMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupSMin *************************************************
			    
			  case OpcodeEnum.OpGroupSMin
			    result.Append "GroupSMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    // todo: X and Result Type must be a 32 or 64 bits wide OpTypeInt data type.
			    
			    // ***** OpGroupUMax *************************************************
			    
			  case OpcodeEnum.OpGroupUMax
			    result.Append "GroupUMax"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupUMin *************************************************
			    
			  case OpcodeEnum.OpGroupUMin
			    result.Append "GroupUMin"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append SPIRVDescribeGroupOperation(VM.ModuleBinary.UInt32Value(Offset + 16))
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpGroupMemberDecorate *************************************************
			    
			  case OpcodeEnum.OpGroupMemberDecorate
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
			    
			  case OpcodeEnum.OpIAdd
			    result.Append "IAdd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIEqual *************************************************
			    
			  case OpcodeEnum.OpIEqual
			    result.Append "IEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpImagePointer *************************************************
			    
			  case OpcodeEnum.OpImagePointer
			    result.Append "ImagePointer"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpIMul *************************************************
			    
			  case OpcodeEnum.OpIMul
			    result.Append "IMul"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpInBoundsAccessChain *************************************************
			    
			  case OpcodeEnum.OpInBoundsAccessChain
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
			    
			  case OpcodeEnum.OpINotEqual
			    result.Append "INotEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIsFinite *************************************************
			    
			  case OpcodeEnum.OpIsFinite
			    result.Append "IsFinite"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsInf *************************************************
			    
			  case OpcodeEnum.OpIsInf
			    result.Append "IsInf"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsNan *************************************************
			    
			  case OpcodeEnum.OpIsNan
			    result.Append "IsNan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsNormal *************************************************
			    
			  case OpcodeEnum.OpIsNormal
			    result.Append "IsNormal"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpISub *************************************************
			    
			  case OpcodeEnum.OpISub
			    result.Append "ISub"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpIsValidEvent *************************************************
			    
			  case OpcodeEnum.OpIsValidEvent
			    result.Append "IsValidEvent"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpIsValidReserveId *************************************************
			    
			  case OpcodeEnum.OpIsValidReserveId
			    result.Append "IsValidReserveId"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpKill *************************************************
			    
			  case OpcodeEnum.OpKill
			    result.Append "Kill"
			    
			    // ***** OpLabel *************************************************
			    
			  case OpcodeEnum.OpLabel
			    result.Append "Label"
			    
			    // ***** OpLessOrGreater *************************************************
			    
			  case OpcodeEnum.OpLessOrGreater
			    result.Append "LessOrGreater"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLifetimeStart *************************************************
			    
			  case OpcodeEnum.OpLifetimeStart
			    result.Append "LifetimeStart"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpLifetimeStop *************************************************
			    
			  case OpcodeEnum.OpLifetimeStop
			    result.Append "LifetimeStop"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpLine *************************************************
			    
			  case OpcodeEnum.OpLine
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
			    
			  case OpcodeEnum.OpLoad
			    result.Append "Load"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpLogicalAnd *************************************************
			    
			  case OpcodeEnum.OpLogicalAnd
			    result.Append "LogicalAnd"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLogicalOr *************************************************
			    
			  case OpcodeEnum.OpLogicalOr
			    result.Append "LogicalOr"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLogicalXor *************************************************
			    
			  case OpcodeEnum.OpLogicalXor
			    result.Append "LogicalXor"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpLoopMerge *************************************************
			    
			  case OpcodeEnum.OpLoopMerge
			    result.Append "LoopMerge"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeLoopControlMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpMatrixTimesMatrix *************************************************
			    
			  case OpcodeEnum.OpMatrixTimesMatrix
			    result.Append "MatrixTimesMatrix"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMatrixTimesScalar *************************************************
			    
			  case OpcodeEnum.OpMatrixTimesScalar
			    result.Append "MatrixTimesScalar"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMatrixTimesVector *************************************************
			    
			  case OpcodeEnum.OpMatrixTimesVector
			    result.Append "MatrixTimesVector"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpMemberDecorate *************************************************
			    
			  case OpcodeEnum.OpMemberDecorate
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
			    
			  case OpcodeEnum.OpMemberName
			    result.Append "MemberName"
			    result.Append " "
			    result.Append compose_type(Offset + 4)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 12)
			    result.Append """"
			    
			    // ***** OpMemoryBarrier *************************************************
			    
			  case OpcodeEnum.OpMemoryBarrier
			    result.Append "MemoryBarrier"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemorySemantics(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpMemoryModel *************************************************
			    
			  case OpcodeEnum.OpMemoryModel
			    result.Append "MemoryModel"
			    result.Append " "
			    result.Append SPIRVDescribeAddressingModel(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append SPIRVDescribeMemoryModel(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpName *************************************************
			    
			  case OpcodeEnum.OpName
			    result.Append "Name"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpNop *************************************************
			    
			  case OpcodeEnum.OpNop
			    result.Append "Nop"
			    
			    // ***** OpNot *************************************************
			    
			  case OpcodeEnum.OpNot
			    result.Append "Not "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpOrdered *************************************************
			    
			  case OpcodeEnum.OpOrdered
			    result.Append "Ordered"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpOuterProduct *************************************************
			    
			  case OpcodeEnum.OpOuterProduct
			    result.Append "OuterProduct"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpPhi *************************************************
			    
			  case OpcodeEnum.OpPhi
			    result.Append "Phi"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpPtrCastToGeneric *************************************************
			    
			  case OpcodeEnum.OpPtrCastToGeneric
			    result.Append "PtrCastToGeneric"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpReadPipe *************************************************
			    
			  case OpcodeEnum.OpReadPipe
			    result.Append "ReadPipe"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpReleaseEvent *************************************************
			    
			  case OpcodeEnum.OpReleaseEvent
			    result.Append "ReleaseEvent"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpReservedReadPipe *************************************************
			    
			  case OpcodeEnum.OpReservedReadPipe
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
			    
			  case OpcodeEnum.OpReservedWritePipe
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
			    
			  case OpcodeEnum.OpReserveReadPipePackets
			    result.Append "ReserveReadPipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpReserveWritePipePackets *************************************************
			    
			  case OpcodeEnum.OpReserveWritePipePackets
			    result.Append "ReserveWritePipePackets"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpRetainEvent *************************************************
			    
			  case OpcodeEnum.OpRetainEvent
			    result.Append "RetainEvent"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpReturn *************************************************
			    
			  case OpcodeEnum.OpReturn
			    result.Append "Return"
			    
			    // ***** OpReturnValue *************************************************
			    
			  case OpcodeEnum.OpReturnValue
			    result.Append "ReturnValue"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    
			    // ***** OpSampler *************************************************
			    
			  case OpcodeEnum.OpSampler
			    result.Append "Sampler"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSatConvertSToU *************************************************
			    
			  case OpcodeEnum.OpSatConvertSToU
			    result.Append "SatConvertSToU"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSatConvertUToS *************************************************
			    
			  case OpcodeEnum.OpSatConvertUToS
			    result.Append "SatConvertUToS"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSConvert *************************************************
			    
			  case OpcodeEnum.OpSConvert
			    result.Append "SConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSDiv *************************************************
			    
			  case OpcodeEnum.OpSDiv
			    result.Append "SDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSelect *************************************************
			    
			  case OpcodeEnum.OpSelect
			    result.Append "Select"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpSelectionMerge *************************************************
			    
			  case OpcodeEnum.OpSelectionMerge
			    result.Append "SelectionMerge"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append SPIRVDescribeSelectionControlMask(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSetUserEventStatus *************************************************
			    
			  case OpcodeEnum.OpSetUserEventStatus
			    result.Append "SetUserEventStatus"
			    result.Append " "
			    result.Append compose_id(Offset + 4)
			    result.Append " "
			    result.Append compose_id(Offset + 8)
			    
			    // ***** OpSGreaterThan *************************************************
			    
			  case OpcodeEnum.OpSGreaterThan
			    result.Append "SGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSGreaterThanEqual *************************************************
			    
			  case OpcodeEnum.OpSGreaterThanEqual
			    result.Append "SGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftLeftLogical *************************************************
			    
			  case OpcodeEnum.OpShiftLeftLogical
			    result.Append "ShiftLeftLogical"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftRightArithmetic *************************************************
			    
			  case OpcodeEnum.OpShiftRightArithmetic
			    result.Append "ShiftRightArithmetic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpShiftRightLogical *************************************************
			    
			  case OpcodeEnum.OpShiftRightLogical
			    result.Append "ShiftRightLogical"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSignBitSet *************************************************
			    
			  case OpcodeEnum.OpSignBitSet
			    result.Append "SignBitSet"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSLessThan *************************************************
			    
			  case OpcodeEnum.OpSLessThan
			    result.Append "SLessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSLessThanEqual *************************************************
			    
			  case OpcodeEnum.OpSLessThanEqual
			    result.Append "SLessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSMod *************************************************
			    
			  case OpcodeEnum.OpSMod
			    result.Append "SMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpSNegate *************************************************
			    
			  case OpcodeEnum.OpSNegate
			    result.Append "SNegate"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpSource *************************************************
			    
			  case OpcodeEnum.OpSource
			    result.Append "Source"
			    result.Append " "
			    result.Append SPIRVDescribeSourceLanguage(VM.ModuleBinary.UInt32Value(Offset + 4))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpSourceExtension *************************************************
			    
			  case OpcodeEnum.OpSourceExtension
			    result.Append "SourceExtension"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 4)
			    result.Append """"
			    
			    // ***** OpSpecConstant *************************************************
			    
			  case OpcodeEnum.OpSpecConstant
			    result.Append "SpecConstant"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpSpecConstantComposite *************************************************
			    
			  case OpcodeEnum.OpSpecConstantComposite
			    result.Append "SpecConstantComposite"
			    ub = offset + WordCount * 4
			    i = Offset + 12
			    while i < ub
			      result.Append " "
			      result.Append compose_id(i)
			      i = i + 4
			    wend
			    
			    // ***** OpSpecConstantFalse *************************************************
			    
			  case OpcodeEnum.OpSpecConstantFalse
			    result.Append "SpecConstantFalse"
			    
			    // ***** OpSpecConstantTrue *************************************************
			    
			  case OpcodeEnum.OpSpecConstantTrue
			    result.Append "SpecConstantTrue"
			    
			    // ***** OpSRem *************************************************
			    
			  case OpcodeEnum.OpSRem
			    result.Append "SRem"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpStore *************************************************
			    
			  case OpcodeEnum.OpStore
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
			    
			  case OpcodeEnum.OpString
			    result.Append "String"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpSwitch *************************************************
			    
			  case OpcodeEnum.OpSwitch
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
			    
			  case OpcodeEnum.OpTextureFetchSample
			    result.Append "TextureFetchSample"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureFetchTexel *************************************************
			    
			  case OpcodeEnum.OpTextureFetchTexel
			    result.Append "TextureFetchTexel"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureFetchTexelLod *************************************************
			    
			  case OpcodeEnum.OpTextureFetchTexelLod
			    result.Append "TextureFetchTexelLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureFetchTexel *************************************************
			    
			  case OpcodeEnum.OpTextureFetchTexelOffset
			    result.Append "TextureFetchTexelOffset"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureGather *************************************************
			    
			  case OpcodeEnum.OpTextureGather
			    result.Append "TextureGather"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpTextureGatherOffset *************************************************
			    
			  case OpcodeEnum.OpTextureGatherOffset
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
			    
			  case OpcodeEnum.OpTextureGatherOffsets
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
			    
			  case OpcodeEnum.OpTextureQueryLevels
			    result.Append "TextureQueryLevels"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQueryLod *************************************************
			    
			  case OpcodeEnum.OpTextureQueryLod
			    result.Append "TextureQueryLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureQuerySamples *************************************************
			    
			  case OpcodeEnum.OpTextureQuerySamples
			    result.Append "TextureQuerySamples"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQuerySize *************************************************
			    
			  case OpcodeEnum.OpTextureQuerySize
			    result.Append "TextureQuerySize"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTextureQuerySizeLod *************************************************
			    
			  case OpcodeEnum.OpTextureQuerySizeLod
			    result.Append "TextureQuerySizeLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpTextureSample *************************************************
			    
			  case OpcodeEnum.OpTextureSample
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
			    
			  case OpcodeEnum.OpTextureSampleDref
			    result.Append "TextureSampleDref"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleGrad *************************************************
			    
			  case OpcodeEnum.OpTextureSampleGrad
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
			    
			  case OpcodeEnum.OpTextureSampleGradOffset
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
			    
			  case OpcodeEnum.OpTextureSampleLod
			    result.Append "TextureSampleLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleLodOffset *************************************************
			    
			  case OpcodeEnum.OpTextureSampleLodOffset
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
			    
			  case OpcodeEnum.OpTextureSampleOffset
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
			    
			  case OpcodeEnum.OpTextureSampleProj
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
			    
			  case OpcodeEnum.OpTextureSampleProjGrad
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
			    
			  case OpcodeEnum.OpTextureSampleProjGradOffset
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
			    
			  case OpcodeEnum.OpTextureSampleProjLod
			    result.Append "TextureSampleProjLod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpTextureSampleProjLodOffset *************************************************
			    
			  case OpcodeEnum.OpTextureSampleProjLodOffset
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
			    
			  case OpcodeEnum.OpTextureSampleProjOffset
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
			    
			  case OpcodeEnum.OpTranspose
			    result.Append "Transpose"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpTypeArray *************************************************
			    
			  case OpcodeEnum.OpTypeArray
			    result.Append "TypeArray"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeBool *************************************************
			    
			  case OpcodeEnum.OpTypeBool
			    result.Append "TypeBool"
			    
			    // ***** OpTypeDeviceEvent *************************************************
			    
			  case OpcodeEnum.OpTypeDeviceEvent
			    result.Append "TypeDeviceEvent"
			    
			    // ***** OpTypeEvent *************************************************
			    
			  case OpcodeEnum.OpTypeEvent
			    result.Append "TypeEvent"
			    
			    // ***** OpTypeFilter *************************************************
			    
			  case OpcodeEnum.OpTypeFilter
			    result.Append "TypeFilter"
			    
			    // ***** OpTypeFloat *************************************************
			    
			  case OpcodeEnum.OpTypeFloat
			    result.Append "TypeFloat"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    
			    // ***** OpTypeFunction *************************************************
			    
			  case OpcodeEnum.OpTypeFunction
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
			    
			  case OpcodeEnum.OpTypeInt
			    result.Append "TypeInt"
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 8))
			    if VM.ModuleBinary.UInt32Value(Offset + 12) = 0 then
			      result.Append " Unsigned"
			    else
			      result.Append " Signed"
			    end if
			    
			    // ***** OpTypeMatrix *************************************************
			    
			  case OpcodeEnum.OpTypeMatrix
			    result.Append "TypeMatrix"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeOpaque *************************************************
			    
			  case OpcodeEnum.OpTypeOpaque
			    result.Append "TypeOpaque"
			    result.Append " """
			    result.Append VM.ModuleBinary.CString(Offset + 8)
			    result.Append """"
			    
			    // ***** OpTypePipe *************************************************
			    
			  case OpcodeEnum.OpTypePipe
			    result.Append "TypePipe"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append SPIRVDescribeAccessQualifier(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypePointer *************************************************
			    
			  case OpcodeEnum.OpTypePointer
			    result.Append "TypePointer"
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 8))
			    result.Append " "
			    result.Append compose_type(Offset + 12)
			    
			    // ***** OpTypeQueue *************************************************
			    
			  case OpcodeEnum.OpTypeQueue
			    result.Append "TypeQueue"
			    
			    // ***** OpTypeReserveId *************************************************
			    
			  case OpcodeEnum.OpTypeReserveId
			    result.Append "TypeReserveId"
			    
			    // ***** OpTypeRuntimeArray *************************************************
			    
			  case OpcodeEnum.OpTypeRuntimeArray
			    result.Append "TypeRuntimeArray"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    
			    // ***** OpTypeSampler *************************************************
			    
			  case OpcodeEnum.OpTypeSampler
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
			    
			  case OpcodeEnum.OpTypeStruct
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
			    
			  case OpcodeEnum.OpTypeVector
			    result.Append "TypeVector"
			    result.Append " "
			    result.Append compose_type(Offset + 8)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 12))
			    
			    // ***** OpTypeVoid *************************************************
			    
			  case OpcodeEnum.OpTypeVoid
			    result.Append "TypeVoid"
			    
			    // ***** OpUConvert *************************************************
			    
			  case OpcodeEnum.OpUConvert
			    result.Append "UConvert"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    
			    // ***** OpUDiv *************************************************
			    
			  case OpcodeEnum.OpUDiv
			    result.Append "UDiv"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUGreaterThan *************************************************
			    
			  case OpcodeEnum.OpUGreaterThan
			    result.Append "UGreaterThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUGreaterThanEqual *************************************************
			    
			  case OpcodeEnum.OpUGreaterThanEqual
			    result.Append "UGreaterThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpULessThan *************************************************
			    
			  case OpcodeEnum.OpULessThan
			    result.Append "ULessThan"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpULessThanEqual *************************************************
			    
			  case OpcodeEnum.OpULessThanEqual
			    result.Append "ULessThanEqual"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUMod *************************************************
			    
			  case OpcodeEnum.OpUMod
			    result.Append "UMod"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUndef *************************************************
			    
			  case OpcodeEnum.OpUndef
			    result.Append "Undef"
			    
			    // ***** OpUnordered *************************************************
			    
			  case OpcodeEnum.OpUnordered
			    result.Append "Unordered"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpUnreachable *************************************************
			    
			  case OpcodeEnum.OpUnreachable
			    result.Append "Unreachable"
			    
			    // ***** OpVariable *************************************************
			    
			  case OpcodeEnum.OpVariable
			    result.Append "Variable"
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    if WordCount > 4 then
			      break // todo: optional initializer
			    end if
			    
			    // ***** OpVariableArray *************************************************
			    
			  case OpcodeEnum.OpVariableArray
			    result.Append "VariableArray"
			    result.Append " "
			    result.Append SPIRVDescribeStorageClass(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpVectorExtractDynamic *************************************************
			    
			  case OpcodeEnum.OpVectorExtractDynamic
			    result.Append "VectorExtractDynamic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 16))
			    
			    // ***** OpVectorInsertDynamic *************************************************
			    
			  case OpcodeEnum.OpVectorInsertDynamic
			    result.Append "VectorInsertDynamic"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append Str(VM.ModuleBinary.UInt32Value(Offset + 20))
			    
			    // ***** OpVectorShuffle *************************************************
			    
			  case OpcodeEnum.OpVectorShuffle
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
			    
			  case OpcodeEnum.OpVectorTimesScalar
			    result.Append "VectorTimesScalar"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpVectorTimesMatrix *************************************************
			    
			  case OpcodeEnum.OpVectorTimesMatrix
			    result.Append "VectorTimesMatrix"
			    result.Append " "
			    result.Append compose_id(Offset + 12)
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    
			    // ***** OpWaitGroupEvents *************************************************
			    
			  case OpcodeEnum.OpWaitGroupEvents
			    result.Append "WaitGroupEvents"
			    result.Append " "
			    result.Append SPIRVDescribeExecutionScope(VM.ModuleBinary.UInt32Value(Offset + 12))
			    result.Append " "
			    result.Append compose_id(Offset + 16)
			    result.Append " "
			    result.Append compose_id(Offset + 20)
			    
			    // ***** OpWritePipe *************************************************
			    
			  case OpcodeEnum.OpWritePipe
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
			    
			  case OpcodeEnum.OpAccessChain, OpcodeEnum.OpAll, _
			    OpcodeEnum.OpAny, _
			    OpcodeEnum.OpArrayLength, _
			    OpcodeEnum.OpAsyncGroupCopy, _
			    OpcodeEnum.OpAtomicAnd, _
			    OpcodeEnum.OpAtomicCompareExchange, OpcodeEnum.OpAtomicCompareExchangeWeak, _
			    OpcodeEnum.OpAtomicExchange, _
			    OpcodeEnum.OpAtomicIAdd, _
			    OpcodeEnum.OpAtomicIDecrement, OpcodeEnum.OpAtomicIIncrement, _
			    OpcodeEnum.OpAtomicIMax, _
			    OpcodeEnum.OpAtomicIMin, _
			    OpcodeEnum.OpAtomicISub, _
			    OpcodeEnum.OpAtomicLoad, _
			    OpcodeEnum.OpAtomicOr, _
			    OpcodeEnum.OpAtomicUMax, _
			    OpcodeEnum.OpAtomicUMin, _
			    OpcodeEnum.OpAtomicXor, _
			    OpcodeEnum.OpBitcast, _
			    OpcodeEnum.OpBitwiseAnd, _
			    OpcodeEnum.OpBitwiseOr, _
			    OpcodeEnum.OpBitwiseXor, _
			    OpcodeEnum.OpBuildNDRange, _
			    OpcodeEnum.OpCompositeConstruct, _
			    OpcodeEnum.OpCompositeExtract, OpcodeEnum.OpCompositeInsert, _
			    OpcodeEnum.OpConstant, OpcodeEnum.OpConstantComposite, _
			    OpcodeEnum.OpConstantFalse, OpcodeEnum.OpConstantNullObject, _
			    OpcodeEnum.OpConstantNullPointer, _
			    OpcodeEnum.OpConstantSampler, OpcodeEnum.OpConstantTrue, _
			    OpcodeEnum.OpConvertFToS, _
			    OpcodeEnum.OpConvertFToU, _
			    OpcodeEnum.OpConvertPtrToU, _
			    OpcodeEnum.OpConvertSToF, _
			    OpcodeEnum.OpConvertUToF, _
			    OpcodeEnum.OpConvertUToPtr, _
			    OpcodeEnum.OpCopyObject, _
			    OpcodeEnum.OpCreateUserEvent, _
			    OpcodeEnum.OpDot, _
			    OpcodeEnum.OpDPdx, OpcodeEnum.OpDPdxCoarse, _
			    OpcodeEnum.OpDPdxFine, _
			    OpcodeEnum.OpDPdy, OpcodeEnum.OpDPdyCoarse, _
			    OpcodeEnum.OpDPdyFine, _
			    OpcodeEnum.OpEnqueueKernel, _
			    OpcodeEnum.OpEnqueueMarker, _
			    OpcodeEnum.OpExtInst, _
			    OpcodeEnum.OpFAdd, OpcodeEnum.OpFConvert, _
			    OpcodeEnum.OpFDiv, _
			    OpcodeEnum.OpFMod, _
			    OpcodeEnum.OpFMul, _
			    OpcodeEnum.OpFNegate, _
			    OpcodeEnum.OpFOrdEqual, _
			    OpcodeEnum.OpFOrdGreaterThan, _
			    OpcodeEnum.OpFOrdGreaterThanEqual, _
			    OpcodeEnum.OpFOrdLessThan, _
			    OpcodeEnum.OpFOrdLessThanEqual, _
			    OpcodeEnum.OpFOrdNotEqual, _
			    OpcodeEnum.OpFRem, _
			    OpcodeEnum.OpFSub, OpcodeEnum.OpFunction, _
			    OpcodeEnum.OpFunctionCall, OpcodeEnum.OpFunctionParameter, _
			    OpcodeEnum.OpFUnordEqual, _
			    OpcodeEnum.OpFUnordGreaterThan, _
			    OpcodeEnum.OpFUnordGreaterThanEqual, _
			    OpcodeEnum.OpFUnordLessThan, _
			    OpcodeEnum.OpFUnordLessThanEqual, _
			    OpcodeEnum.OpFUnordNotEqual, _
			    OpcodeEnum.OpFwidth, OpcodeEnum.OpFwidthCoarse, _
			    OpcodeEnum.OpFwidthFine, _
			    OpcodeEnum.OpGenericCastToPtr, _
			    OpcodeEnum.OpGenericCastToPtrExplicit, _
			    OpcodeEnum.OpGenericPtrMemSemantics, _
			    OpcodeEnum.OpGetDefaultQueue, _
			    OpcodeEnum.OpGetKernelNDrangeMaxSubGroupSize, _
			    OpcodeEnum.OpGetKernelNDrangeSubGroupCount, _
			    OpcodeEnum.OpGetKernelPreferredWorkGroupSizeMultiple, _
			    OpcodeEnum.OpGetKernelWorkGroupSize, _
			    OpcodeEnum.OpGetMaxPipePackets, _
			    OpcodeEnum.OpGetNumPipePackets, _
			    OpcodeEnum.OpGroupAll, _
			    OpcodeEnum.OpGroupAny, _
			    OpcodeEnum.OpGroupBroadcast, _
			    OpcodeEnum.OpGroupFAdd, _
			    OpcodeEnum.OpGroupFMax, _
			    OpcodeEnum.OpGroupFMin, _
			    OpcodeEnum.OpGroupIAdd, _
			    OpcodeEnum.OpGroupReserveReadPipePackets, _
			    OpcodeEnum.OpGroupReserveWritePipePackets, _
			    OpcodeEnum.OpGroupSMax, _
			    OpcodeEnum.OpGroupSMin, _
			    OpcodeEnum.OpGroupUMax, _
			    OpcodeEnum.OpGroupUMin, _
			    OpcodeEnum.OpIAdd, _
			    OpcodeEnum.OpIEqual, _
			    OpcodeEnum.OpImagePointer, _
			    OpcodeEnum.OpIMul, _
			    OpcodeEnum.OpInBoundsAccessChain, _
			    OpcodeEnum.OpINotEqual, _
			    OpcodeEnum.OpIsFinite, _
			    OpcodeEnum.OpIsInf, _
			    OpcodeEnum.OpIsNan, _
			    OpcodeEnum.OpIsNormal, _
			    OpcodeEnum.OpISub, _
			    OpcodeEnum.OpIsValidEvent, _
			    OpcodeEnum.OpIsValidReserveId, _
			    OpcodeEnum.OpLessOrGreater, _
			    OpcodeEnum.OpLoad, _
			    OpcodeEnum.OpLogicalAnd, _
			    OpcodeEnum.OpLogicalOr, _
			    OpcodeEnum.OpLogicalXor, _
			    OpcodeEnum.OpMatrixTimesMatrix, _
			    OpcodeEnum.OpMatrixTimesScalar, _
			    OpcodeEnum.OpMatrixTimesVector, _
			    OpcodeEnum.OpNot, _
			    OpcodeEnum.OpOrdered, _
			    OpcodeEnum.OpOuterProduct, _
			    OpcodeEnum.OpPhi, _
			    OpcodeEnum.OpPtrCastToGeneric, _
			    OpcodeEnum.OpReadPipe, _
			    OpcodeEnum.OpReservedReadPipe, _
			    OpcodeEnum.OpReservedWritePipe, _
			    OpcodeEnum.OpReserveReadPipePackets, _
			    OpcodeEnum.OpReserveWritePipePackets, _
			    OpcodeEnum.OpSampler, _
			    OpcodeEnum.OpSatConvertSToU, _
			    OpcodeEnum.OpSatConvertUToS, _
			    OpcodeEnum.OpSConvert, _
			    OpcodeEnum.OpSDiv, _
			    OpcodeEnum.OpSelect, _
			    OpcodeEnum.OpShiftLeftLogical, _
			    OpcodeEnum.OpShiftRightArithmetic, _
			    OpcodeEnum.OpShiftRightLogical, _
			    OpcodeEnum.OpSignBitSet, _
			    OpcodeEnum.OpSGreaterThan, _
			    OpcodeEnum.OpSGreaterThanEqual, _
			    OpcodeEnum.OpSLessThan, _
			    OpcodeEnum.OpSLessThanEqual, _
			    OpcodeEnum.OpSMod, _
			    OpcodeEnum.OpSNegate, _
			    OpcodeEnum.OpSpecConstant, OpcodeEnum.OpSpecConstantFalse, _
			    OpcodeEnum.OpSpecConstantComposite, OpcodeEnum.OpSpecConstantTrue, _
			    OpcodeEnum.OpSRem, _
			    OpcodeEnum.OpTextureFetchSample, _
			    OpcodeEnum.OpTextureFetchTexel, _
			    OpcodeEnum.OpTextureFetchTexelLod, OpcodeEnum.OpTextureFetchTexelOffset, _
			    OpcodeEnum.OpTextureGather, OpcodeEnum.OpTextureGatherOffset, _
			    OpcodeEnum.OpTextureGatherOffsets, OpcodeEnum.OpTextureQueryLevels, _
			    OpcodeEnum.OpTextureQueryLod, OpcodeEnum.OpTextureQuerySamples, _
			    OpcodeEnum.OpTextureQuerySize, OpcodeEnum.OpTextureQuerySizeLod, _
			    OpcodeEnum.OpTextureSample, OpcodeEnum.OpTextureSampleDref, _
			    OpcodeEnum.OpTextureSampleGrad, OpcodeEnum.OpTextureSampleGradOffset, _
			    OpcodeEnum.OpTextureSampleLod, OpcodeEnum.OpTextureSampleLodOffset, _
			    OpcodeEnum.OpTextureSampleOffset, OpcodeEnum.OpTextureSampleProj, _
			    OpcodeEnum.OpTextureSampleProjGrad, OpcodeEnum.OpTextureSampleProjGradOffset, _
			    OpcodeEnum.OpTextureSampleProjLod, OpcodeEnum.OpTextureSampleProjLodOffset, _
			    OpcodeEnum.OpTextureSampleProjOffset, OpcodeEnum.OpTranspose, _
			    OpcodeEnum.OpUConvert, _
			    OpcodeEnum.OpUDiv, _
			    OpcodeEnum.OpUGreaterThan, _
			    OpcodeEnum.OpUGreaterThanEqual, _
			    OpcodeEnum.OpULessThan, _
			    OpcodeEnum.OpULessThanEqual, _
			    OpcodeEnum.OpUMod, _
			    OpcodeEnum.OpUndef, _
			    OpcodeEnum.OpUnordered, _
			    OpcodeEnum.OpVariable, OpcodeEnum.OpVariableArray, _
			    OpcodeEnum.OpVectorExtractDynamic, OpcodeEnum.OpVectorInsertDynamic, _
			    OpcodeEnum.OpVectorShuffle, _
			    OpcodeEnum.OpVectorTimesMatrix, _
			    OpcodeEnum.OpVectorTimesScalar, _
			    OpcodeEnum.OpWaitGroupEvents, _
			    OpcodeEnum.OpWritePipe
			    
			    result = VM.ModuleBinary.UInt32Value(Offset + 8)
			    
			    
			  case OpcodeEnum.OpDecorationGroup, OpcodeEnum.OpExtInstImport, _
			    OpcodeEnum.OpLabel, OpcodeEnum.OpString, _
			    OpcodeEnum.OpTypeArray, OpcodeEnum.OpTypeBool, _
			    OpcodeEnum.OpTypeDeviceEvent, OpcodeEnum.OpTypeEvent, _
			    OpcodeEnum.OpTypeFilter, OpcodeEnum.OpTypeFloat, _
			    OpcodeEnum.OpTypeFunction, OpcodeEnum.OpTypeInt, _
			    OpcodeEnum.OpTypeMatrix, OpcodeEnum.OpTypeOpaque, _
			    OpcodeEnum.OpTypePipe, OpcodeEnum.OpTypePointer, _
			    OpcodeEnum.OpTypeQueue, OpcodeEnum.OpTypeReserveId, _
			    OpcodeEnum.OpTypeRuntimeArray, OpcodeEnum.OpTypeSampler, _
			    OpcodeEnum.OpTypeStruct, OpcodeEnum.OpTypeVector, _
			    OpcodeEnum.OpTypeVoid
			    
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
			    
			  case OpcodeEnum.OpAccessChain, OpcodeEnum.OpAll, _
			    OpcodeEnum.OpAny, _
			    OpcodeEnum.OpArrayLength, _
			    OpcodeEnum.OpAsyncGroupCopy, _
			    OpcodeEnum.OpAtomicAnd, _
			    OpcodeEnum.OpAtomicCompareExchange, OpcodeEnum.OpAtomicCompareExchangeWeak, _
			    OpcodeEnum.OpAtomicExchange, _
			    OpcodeEnum.OpAtomicIAdd, _
			    OpcodeEnum.OpAtomicIDecrement, OpcodeEnum.OpAtomicIIncrement, _
			    OpcodeEnum.OpAtomicIMax, _
			    OpcodeEnum.OpAtomicIMin, _
			    OpcodeEnum.OpAtomicISub, _
			    OpcodeEnum.OpAtomicLoad, _
			    OpcodeEnum.OpAtomicOr, _
			    OpcodeEnum.OpAtomicUMax, _
			    OpcodeEnum.OpAtomicUMin, _
			    OpcodeEnum.OpAtomicXor, _
			    OpcodeEnum.OpBitcast, _
			    OpcodeEnum.OpBitwiseAnd, _
			    OpcodeEnum.OpBitwiseOr, _
			    OpcodeEnum.OpBitwiseXor, _
			    OpcodeEnum.OpBuildNDRange, _
			    OpcodeEnum.OpCompositeConstruct, OpcodeEnum.OpCompositeExtract, _
			    OpcodeEnum.OpCompositeInsert, _
			    OpcodeEnum.OpConstant, _
			    OpcodeEnum.OpConstantComposite, OpcodeEnum.OpConstantFalse, _
			    OpcodeEnum.OpConstantNullObject, OpcodeEnum.OpConstantNullPointer, _
			    OpcodeEnum.OpConstantSampler, OpcodeEnum.OpConstantTrue, _
			    OpcodeEnum.OpConvertFToS, _
			    OpcodeEnum.OpConvertFToU, _
			    OpcodeEnum.OpConvertPtrToU, _
			    OpcodeEnum.OpConvertSToF, _
			    OpcodeEnum.OpConvertUToF, _
			    OpcodeEnum.OpConvertUToPtr, _
			    OpcodeEnum.OpCopyObject, _
			    OpcodeEnum.OpCreateUserEvent, _
			    OpcodeEnum.OpDot, _
			    OpcodeEnum.OpDPdx, OpcodeEnum.OpDPdxCoarse, _
			    OpcodeEnum.OpDPdxFine, _
			    OpcodeEnum.OpDPdy, OpcodeEnum.OpDPdyCoarse, _
			    OpcodeEnum.OpDPdyFine, _
			    OpcodeEnum.OpEnqueueKernel, _
			    OpcodeEnum.OpEnqueueMarker, _
			    OpcodeEnum.OpExtInst, _
			    OpcodeEnum.OpFAdd, _
			    OpcodeEnum.OpFConvert, _
			    OpcodeEnum.OpFDiv, _
			    OpcodeEnum.OpFMod, _
			    OpcodeEnum.OpFMul, _
			    OpcodeEnum.OpFNegate, _
			    OpcodeEnum.OpFOrdEqual, _
			    OpcodeEnum.OpFOrdGreaterThan, _
			    OpcodeEnum.OpFOrdGreaterThanEqual, _
			    OpcodeEnum.OpFOrdLessThan, _
			    OpcodeEnum.OpFOrdLessThanEqual, _
			    OpcodeEnum.OpFOrdNotEqual, _
			    OpcodeEnum.OpFRem, _
			    OpcodeEnum.OpFSub, _
			    OpcodeEnum.OpFunction, OpcodeEnum.OpFunctionCall, _
			    OpcodeEnum.OpFunctionParameter, _
			    OpcodeEnum.OpFUnordEqual, _
			    OpcodeEnum.OpFUnordGreaterThan, _
			    OpcodeEnum.OpFUnordGreaterThanEqual, _
			    OpcodeEnum.OpFUnordLessThan, _
			    OpcodeEnum.OpFUnordLessThanEqual, _
			    OpcodeEnum.OpFUnordNotEqual, _
			    OpcodeEnum.OpFwidth, OpcodeEnum.OpFwidthCoarse, _
			    OpcodeEnum.OpFwidthFine, _
			    OpcodeEnum.OpGenericCastToPtr, _
			    OpcodeEnum.OpGenericCastToPtrExplicit, _
			    OpcodeEnum.OpGenericPtrMemSemantics, _
			    OpcodeEnum.OpGetDefaultQueue, _
			    OpcodeEnum.OpGetKernelNDrangeSubGroupCount, _
			    OpcodeEnum.OpGetKernelNDrangeMaxSubGroupSize, _
			    OpcodeEnum.OpGetKernelPreferredWorkGroupSizeMultiple, _
			    OpcodeEnum.OpGetKernelWorkGroupSize, _
			    OpcodeEnum.OpGetMaxPipePackets, _
			    OpcodeEnum.OpGetNumPipePackets, _
			    OpcodeEnum.OpGroupAll, _
			    OpcodeEnum.OpGroupAny, _
			    OpcodeEnum.OpGroupBroadcast, _
			    OpcodeEnum.OpGroupFAdd, _
			    OpcodeEnum.OpGroupFMax, _
			    OpcodeEnum.OpGroupFMin, _
			    OpcodeEnum.OpGroupIAdd, _
			    OpcodeEnum.OpGroupReserveReadPipePackets, _
			    OpcodeEnum.OpGroupReserveWritePipePackets, _
			    OpcodeEnum.OpGroupSMax, _
			    OpcodeEnum.OpGroupSMin, _
			    OpcodeEnum.OpGroupUMax, _
			    OpcodeEnum.OpGroupUMin, _
			    OpcodeEnum.OpIAdd, _
			    OpcodeEnum.OpIEqual, _
			    OpcodeEnum.OpImagePointer, _
			    OpcodeEnum.OpIMul, _
			    OpcodeEnum.OpInBoundsAccessChain, _
			    OpcodeEnum.OpINotEqual, _
			    OpcodeEnum.OpIsFinite, _
			    OpcodeEnum.OpIsInf, _
			    OpcodeEnum.OpIsNan, _
			    OpcodeEnum.OpIsNormal, _
			    OpcodeEnum.OpISub, _
			    OpcodeEnum.OpIsValidEvent, _
			    OpcodeEnum.OpIsValidReserveId, _
			    OpcodeEnum.OpLessOrGreater, _
			    OpcodeEnum.OpLoad, _
			    OpcodeEnum.OpLogicalAnd, _
			    OpcodeEnum.OpLogicalOr, _
			    OpcodeEnum.OpLogicalXor, _
			    OpcodeEnum.OpMatrixTimesMatrix, _
			    OpcodeEnum.OpMatrixTimesScalar, _
			    OpcodeEnum.OpMatrixTimesVector, _
			    OpcodeEnum.OpNot, _
			    OpcodeEnum.OpOrdered, _
			    OpcodeEnum.OpOuterProduct, _
			    OpcodeEnum.OpPhi, _
			    OpcodeEnum.OpPtrCastToGeneric, _
			    OpcodeEnum.OpReadPipe, _
			    OpcodeEnum.OpReservedReadPipe, _
			    OpcodeEnum.OpReservedWritePipe, _
			    OpcodeEnum.OpReserveReadPipePackets, _
			    OpcodeEnum.OpReserveWritePipePackets, _
			    OpcodeEnum.OpSampler, _
			    OpcodeEnum.OpSatConvertSToU, _
			    OpcodeEnum.OpSatConvertUToS, _
			    OpcodeEnum.OpSConvert, _
			    OpcodeEnum.OpSDiv, _
			    OpcodeEnum.OpSelect, _
			    OpcodeEnum.OpShiftLeftLogical, _
			    OpcodeEnum.OpShiftRightArithmetic, _
			    OpcodeEnum.OpShiftRightLogical, _
			    OpcodeEnum.OpSignBitSet, _
			    OpcodeEnum.OpSGreaterThan, _
			    OpcodeEnum.OpSGreaterThanEqual, _
			    OpcodeEnum.OpSLessThan, _
			    OpcodeEnum.OpSLessThanEqual, _
			    OpcodeEnum.OpSMod, _
			    OpcodeEnum.OpSNegate, _
			    OpcodeEnum.OpSpecConstant, _
			    OpcodeEnum.OpSpecConstantComposite, OpcodeEnum.OpSpecConstantFalse, _
			    OpcodeEnum.OpSpecConstantTrue, _
			    OpcodeEnum.OpSRem, _
			    OpcodeEnum.OpTextureFetchSample, _
			    OpcodeEnum.OpTextureFetchTexel, _
			    OpcodeEnum.OpTextureFetchTexelLod, OpcodeEnum.OpTextureFetchTexelOffset, _
			    OpcodeEnum.OpTextureGather, OpcodeEnum.OpTextureGatherOffset, _
			    OpcodeEnum.OpTextureGatherOffsets, OpcodeEnum.OpTextureQueryLevels, _
			    OpcodeEnum.OpTextureQueryLod, OpcodeEnum.OpTextureQuerySamples, _
			    OpcodeEnum.OpTextureQuerySize, OpcodeEnum.OpTextureQuerySizeLod, _
			    OpcodeEnum.OpTextureSample, OpcodeEnum.OpTextureSampleDref, _
			    OpcodeEnum.OpTextureSampleGrad, OpcodeEnum.OpTextureSampleGradOffset, _
			    OpcodeEnum.OpTextureSampleLod, OpcodeEnum.OpTextureSampleLodOffset, _
			    OpcodeEnum.OpTextureSampleOffset, _
			    OpcodeEnum.OpTextureSampleProj, OpcodeEnum.OpTextureSampleProjGrad, _
			    OpcodeEnum.OpTextureSampleProjGradOffset, _
			    OpcodeEnum.OpTextureSampleProjLod, OpcodeEnum.OpTextureSampleProjLodOffset, _
			    OpcodeEnum.OpTextureSampleProjOffset, _
			    OpcodeEnum.OpTranspose, _
			    OpcodeEnum.OpUConvert, _
			    OpcodeEnum.OpUDiv, _
			    OpcodeEnum.OpUGreaterThan, _
			    OpcodeEnum.OpUGreaterThanEqual, _
			    OpcodeEnum.OpULessThan, _
			    OpcodeEnum.OpULessThanEqual, _
			    OpcodeEnum.OpUMod, _
			    OpcodeEnum.OpUndef, _
			    OpcodeEnum.OpUnordered, _
			    OpcodeEnum.OpVariable, _
			    OpcodeEnum.OpVariableArray, OpcodeEnum.OpVectorExtractDynamic, _
			    OpcodeEnum.OpVectorInsertDynamic, OpcodeEnum.OpVectorShuffle, _
			    OpcodeEnum.OpVectorTimesMatrix, _
			    OpcodeEnum.OpVectorTimesScalar, _
			    OpcodeEnum.OpWaitGroupEvents, _
			    OpcodeEnum.OpWritePipe
			    
			    result = compose_type(Offset + 4)
			    
			  end select
			  
			  return result
			  
			End Get
		#tag EndGetter
		ResultType As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			  ' www.zoclee.com/shade
			  
			  Dim result As UInt32
			  
			  result = 0
			  
			  select case Type
			    
			  case OpcodeEnum.OpAccessChain, OpcodeEnum.OpAll, _
			    OpcodeEnum.OpAny, _
			    OpcodeEnum.OpArrayLength, _
			    OpcodeEnum.OpAsyncGroupCopy, _
			    OpcodeEnum.OpAtomicAnd, _
			    OpcodeEnum.OpAtomicCompareExchange, OpcodeEnum.OpAtomicCompareExchangeWeak, _
			    OpcodeEnum.OpAtomicExchange, _
			    OpcodeEnum.OpAtomicIAdd, _
			    OpcodeEnum.OpAtomicIDecrement, OpcodeEnum.OpAtomicIIncrement, _
			    OpcodeEnum.OpAtomicIMax, _
			    OpcodeEnum.OpAtomicIMin, _
			    OpcodeEnum.OpAtomicISub, _
			    OpcodeEnum.OpAtomicLoad, _
			    OpcodeEnum.OpAtomicOr, _
			    OpcodeEnum.OpAtomicUMax, _
			    OpcodeEnum.OpAtomicUMin, _
			    OpcodeEnum.OpAtomicXor, _
			    OpcodeEnum.OpBitcast, _
			    OpcodeEnum.OpBitwiseAnd, _
			    OpcodeEnum.OpBitwiseOr, _
			    OpcodeEnum.OpBitwiseXor, _
			    OpcodeEnum.OpBuildNDRange, _
			    OpcodeEnum.OpCompositeConstruct, OpcodeEnum.OpCompositeExtract, _
			    OpcodeEnum.OpCompositeInsert, _
			    OpcodeEnum.OpConstant, _
			    OpcodeEnum.OpConstantComposite, OpcodeEnum.OpConstantFalse, _
			    OpcodeEnum.OpConstantNullObject, OpcodeEnum.OpConstantNullPointer, _
			    OpcodeEnum.OpConstantSampler, OpcodeEnum.OpConstantTrue, _
			    OpcodeEnum.OpConvertFToS, _
			    OpcodeEnum.OpConvertFToU, _
			    OpcodeEnum.OpConvertPtrToU, _
			    OpcodeEnum.OpConvertSToF, _
			    OpcodeEnum.OpConvertUToF, _
			    OpcodeEnum.OpConvertUToPtr, _
			    OpcodeEnum.OpCopyObject, _
			    OpcodeEnum.OpCreateUserEvent, _
			    OpcodeEnum.OpDot, _
			    OpcodeEnum.OpDPdx, OpcodeEnum.OpDPdxCoarse, _
			    OpcodeEnum.OpDPdxFine, _
			    OpcodeEnum.OpDPdy, OpcodeEnum.OpDPdyCoarse, _
			    OpcodeEnum.OpDPdyFine, _
			    OpcodeEnum.OpEnqueueKernel, _
			    OpcodeEnum.OpEnqueueMarker, _
			    OpcodeEnum.OpExtInst, _
			    OpcodeEnum.OpFAdd, _
			    OpcodeEnum.OpFConvert, _
			    OpcodeEnum.OpFDiv, _
			    OpcodeEnum.OpFMod, _
			    OpcodeEnum.OpFMul, _
			    OpcodeEnum.OpFNegate, _
			    OpcodeEnum.OpFOrdEqual, _
			    OpcodeEnum.OpFOrdGreaterThan, _
			    OpcodeEnum.OpFOrdGreaterThanEqual, _
			    OpcodeEnum.OpFOrdLessThan, _
			    OpcodeEnum.OpFOrdLessThanEqual, _
			    OpcodeEnum.OpFOrdNotEqual, _
			    OpcodeEnum.OpFRem, _
			    OpcodeEnum.OpFSub, _
			    OpcodeEnum.OpFunction, OpcodeEnum.OpFunctionCall, _
			    OpcodeEnum.OpFunctionParameter, _
			    OpcodeEnum.OpFUnordEqual, _
			    OpcodeEnum.OpFUnordGreaterThan, _
			    OpcodeEnum.OpFUnordGreaterThanEqual, _
			    OpcodeEnum.OpFUnordLessThan, _
			    OpcodeEnum.OpFUnordLessThanEqual, _
			    OpcodeEnum.OpFUnordNotEqual, _
			    OpcodeEnum.OpFwidth, OpcodeEnum.OpFwidthCoarse, _
			    OpcodeEnum.OpFwidthFine, _
			    OpcodeEnum.OpGenericCastToPtr, _
			    OpcodeEnum.OpGenericCastToPtrExplicit, _
			    OpcodeEnum.OpGenericPtrMemSemantics, _
			    OpcodeEnum.OpGetDefaultQueue, _
			    OpcodeEnum.OpGetKernelNDrangeSubGroupCount, _
			    OpcodeEnum.OpGetKernelNDrangeMaxSubGroupSize, _
			    OpcodeEnum.OpGetKernelPreferredWorkGroupSizeMultiple, _
			    OpcodeEnum.OpGetKernelWorkGroupSize, _
			    OpcodeEnum.OpGetMaxPipePackets, _
			    OpcodeEnum.OpGetNumPipePackets, _
			    OpcodeEnum.OpGroupAll, _
			    OpcodeEnum.OpGroupAny, _
			    OpcodeEnum.OpGroupBroadcast, _
			    OpcodeEnum.OpGroupFAdd, _
			    OpcodeEnum.OpGroupFMax, _
			    OpcodeEnum.OpGroupFMin, _
			    OpcodeEnum.OpGroupIAdd, _
			    OpcodeEnum.OpGroupReserveReadPipePackets, _
			    OpcodeEnum.OpGroupReserveWritePipePackets, _
			    OpcodeEnum.OpGroupSMax, _
			    OpcodeEnum.OpGroupSMin, _
			    OpcodeEnum.OpGroupUMax, _
			    OpcodeEnum.OpGroupUMin, _
			    OpcodeEnum.OpIAdd, _
			    OpcodeEnum.OpIEqual, _
			    OpcodeEnum.OpImagePointer, _
			    OpcodeEnum.OpIMul, _
			    OpcodeEnum.OpInBoundsAccessChain, _
			    OpcodeEnum.OpINotEqual, _
			    OpcodeEnum.OpIsFinite, _
			    OpcodeEnum.OpIsInf, _
			    OpcodeEnum.OpIsNan, _
			    OpcodeEnum.OpIsNormal, _
			    OpcodeEnum.OpISub, _
			    OpcodeEnum.OpIsValidEvent, _
			    OpcodeEnum.OpIsValidReserveId, _
			    OpcodeEnum.OpLessOrGreater, _
			    OpcodeEnum.OpLoad, _
			    OpcodeEnum.OpLogicalAnd, _
			    OpcodeEnum.OpLogicalOr, _
			    OpcodeEnum.OpLogicalXor, _
			    OpcodeEnum.OpMatrixTimesMatrix, _
			    OpcodeEnum.OpMatrixTimesScalar, _
			    OpcodeEnum.OpMatrixTimesVector, _
			    OpcodeEnum.OpNot, _
			    OpcodeEnum.OpOrdered, _
			    OpcodeEnum.OpOuterProduct, _
			    OpcodeEnum.OpPhi, _
			    OpcodeEnum.OpPtrCastToGeneric, _
			    OpcodeEnum.OpReadPipe, _
			    OpcodeEnum.OpReservedReadPipe, _
			    OpcodeEnum.OpReservedWritePipe, _
			    OpcodeEnum.OpReserveReadPipePackets, _
			    OpcodeEnum.OpReserveWritePipePackets, _
			    OpcodeEnum.OpSampler, _
			    OpcodeEnum.OpSatConvertSToU, _
			    OpcodeEnum.OpSatConvertUToS, _
			    OpcodeEnum.OpSConvert, _
			    OpcodeEnum.OpSDiv, _
			    OpcodeEnum.OpSelect, _
			    OpcodeEnum.OpShiftLeftLogical, _
			    OpcodeEnum.OpShiftRightArithmetic, _
			    OpcodeEnum.OpShiftRightLogical, _
			    OpcodeEnum.OpSignBitSet, _
			    OpcodeEnum.OpSGreaterThan, _
			    OpcodeEnum.OpSGreaterThanEqual, _
			    OpcodeEnum.OpSLessThan, _
			    OpcodeEnum.OpSLessThanEqual, _
			    OpcodeEnum.OpSMod, _
			    OpcodeEnum.OpSNegate, _
			    OpcodeEnum.OpSpecConstant, _
			    OpcodeEnum.OpSpecConstantComposite, OpcodeEnum.OpSpecConstantFalse, _
			    OpcodeEnum.OpSpecConstantTrue, _
			    OpcodeEnum.OpSRem, _
			    OpcodeEnum.OpTextureFetchSample, _
			    OpcodeEnum.OpTextureFetchTexel, _
			    OpcodeEnum.OpTextureFetchTexelLod, OpcodeEnum.OpTextureFetchTexelOffset, _
			    OpcodeEnum.OpTextureGather, OpcodeEnum.OpTextureGatherOffset, _
			    OpcodeEnum.OpTextureGatherOffsets, OpcodeEnum.OpTextureQueryLevels, _
			    OpcodeEnum.OpTextureQueryLod, OpcodeEnum.OpTextureQuerySamples, _
			    OpcodeEnum.OpTextureQuerySize, OpcodeEnum.OpTextureQuerySizeLod, _
			    OpcodeEnum.OpTextureSample, OpcodeEnum.OpTextureSampleDref, _
			    OpcodeEnum.OpTextureSampleGrad, OpcodeEnum.OpTextureSampleGradOffset, _
			    OpcodeEnum.OpTextureSampleLod, OpcodeEnum.OpTextureSampleLodOffset, _
			    OpcodeEnum.OpTextureSampleOffset, _
			    OpcodeEnum.OpTextureSampleProj, OpcodeEnum.OpTextureSampleProjGrad, _
			    OpcodeEnum.OpTextureSampleProjGradOffset, _
			    OpcodeEnum.OpTextureSampleProjLod, OpcodeEnum.OpTextureSampleProjLodOffset, _
			    OpcodeEnum.OpTextureSampleProjOffset, _
			    OpcodeEnum.OpTranspose, _
			    OpcodeEnum.OpUConvert, _
			    OpcodeEnum.OpUDiv, _
			    OpcodeEnum.OpUGreaterThan, _
			    OpcodeEnum.OpUGreaterThanEqual, _
			    OpcodeEnum.OpULessThan, _
			    OpcodeEnum.OpULessThanEqual, _
			    OpcodeEnum.OpUMod, _
			    OpcodeEnum.OpUndef, _
			    OpcodeEnum.OpUnordered, _
			    OpcodeEnum.OpVariable, _
			    OpcodeEnum.OpVariableArray, OpcodeEnum.OpVectorExtractDynamic, _
			    OpcodeEnum.OpVectorInsertDynamic, OpcodeEnum.OpVectorShuffle, _
			    OpcodeEnum.OpVectorTimesMatrix, _
			    OpcodeEnum.OpVectorTimesScalar, _
			    OpcodeEnum.OpWaitGroupEvents, _
			    OpcodeEnum.OpWritePipe
			    
			    result = VM.ModuleBinary.UInt32Value(Offset + 4)
			    
			  end select
			  
			  return result
			  
			End Get
		#tag EndGetter
		ResultTypeID As UInt32
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Type As OpcodeEnum
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
			Type="OpcodeEnum"
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
