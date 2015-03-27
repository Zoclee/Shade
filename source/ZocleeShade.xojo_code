#tag Module
Protected Module ZocleeShade
	#tag Method, Flags = &h0
		Function SPIRVDescribeAddressingModel(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Logical"
		  case 1
		    result = "Physical32"
		  case 2
		    result = "Physical64"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeBuiltIn(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Position"
		  case 1
		    result = "PointSize"
		  case 2
		    result = "ClipVertex"
		  case 3
		    result = "ClipDistance"
		  case 4
		    result = "CullDistance"
		  case 5
		    result = "VertexId"
		  case 6
		    result = "InstanceId"
		  case 7
		    result = "PrimitiveId"
		  case 8
		    result = "InvocationId"
		  case 9
		    result = "Layer"
		  case 10
		    result = "ViewportIndex"
		  case 11
		    result = "TessLevelOuter"
		  case 12
		    result = "TessLevelInner"
		  case 13
		    result = "TessCoord"
		  case 14
		    result = "PatchVertices"
		  case 15
		    result = "FragCoord"
		  case 16
		    result = "PointCoord"
		  case 17
		    result = "FrontFacing"
		  case 18
		    result = "SampleId"
		  case 19
		    result = "SamplePosition"
		  case 20
		    result = "SampleMask"
		  case 21
		    result = "FragColor"
		  case 22
		    result = "FragDepth"
		  case 23
		    result = "HelperInvocation"
		  case 24
		    result = "NumWorkgroups"
		  case 25
		    result = "WorkgroupSize"
		  case 26
		    result = "WorkgroupId"
		  case 27
		    result = "LocalInvocationId"
		  case 28
		    result = "GlobalInvocationId"
		  case 29
		    result = "LocalInvocationIndex"
		  case 30
		    result = "WorkDim"
		  case 31
		    result = "GlobalSize"
		  case 32
		    result = "EnqueuedWorkgroupSize"
		  case 33
		    result = "GlobalOffset"
		  case 34
		    result = "GlobalLinearId"
		  case 35
		    result = "WorkgroupLinearId"
		  case 36
		    result = "SubgroupSize"
		  case 37
		    result = "SubgroupMaxSize"
		  case 38
		    result = "NumSubgroups"
		  case 39
		    result = "NumEnqueuedSubgroups"
		  case 40
		    result = "SubgroupId"
		  case 41
		    result = "SubgroupLocalInvocationId"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeDecoration(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "PrecisionLow"
		  case 1
		    result = "PrecisionMedium"
		  case 2
		    result = "PrecisionHigh"
		  case 3
		    result = "Block"
		  case 4
		    result = "BufferBlock"
		  case 5
		    result = "RowMajor"
		  case 6
		    result = "ColMajor"
		  case 7
		    result = "GLSLShared"
		  case 8
		    result = "GLSLStd140"
		  case 9
		    result = "GLSLStd430"
		  case 10
		    result = "GLSLPacked"
		  case 11
		    result = "Smooth"
		  case 12
		    result = "Noperspective"
		  case 13
		    result = "Flat"
		  case 14
		    result = "Patch"
		  case 15
		    result = "Centroid"
		  case 16
		    result = "Sample"
		  case 17
		    result = "Invariant"
		  case 18
		    result = "Restrict"
		  case 19
		    result = "Aliased"
		  case 20
		    result = "Volatile"
		  case 21
		    result = "Constant"
		  case 22
		    result = "Coherent"
		  case 23
		    result = "Nonwritable"
		  case 24
		    result = "Nonreadable"
		  case 25
		    result = "Uniform"
		  case 26
		    result = "NoStaticUse"
		  case 27
		    result = "CPacked"
		  case 28
		    result = "FPSaturatedConversion"
		  case 29
		    result = "Stream"
		  case 30
		    result = "Location"
		  case 31
		    result = "Component"
		  case 32
		    result = "Index"
		  case 33
		    result = "Binding"
		  case 34
		    result = "DescriptorSet"
		  case 35
		    result = "Offset"
		  case 36
		    result = "Alignment"
		  case 37
		    result = "XfbBuffer"
		  case 38
		    result = "Stride"
		  case 39
		    result = "Built-In"
		  case 40
		    result = "FuncParamAttr"
		  case 41
		    result = "FP Rounding Mode"
		  case 42
		    result = "FP Fast Math Mode"
		  case 43
		    result = "Linkage Type"
		  case 44
		    result = "SpecId"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeExecutionModel(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Vertex"
		  case 1
		    result = "TessellationControl"
		  case 2
		    result = "TessellationEvaluation"
		  case 3
		    result = "Geometry"
		  case 4
		    result = "Fragment"
		  case 5
		    result = "GLCompute"
		  case 6
		    result = "Kernel"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeFPFastMathMode(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "NotNaN"
		  case 2
		    result = "NotInf"
		  case 4
		    result = "NSZ"
		  case 8
		    result = "AllowRecip"
		  case 16
		    result = "Fast"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeFPRoundingMode(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "RTE"
		  case 1
		    result = "RTZ"
		  case 2
		    result = "RTP"
		  case 3
		    result = "RTN"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeFuncParamAttr(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Zext"
		  case 1
		    result = "Sext"
		  case 2
		    result = "ByVal"
		  case 3
		    result = "Sret"
		  case 4
		    result = "NoAlias"
		  case 5
		    result = "NoCapture"
		  case 6
		    result = "SVM"
		  case 7
		    result = "NoWrite"
		  case 8
		    result = "NoReadWrite"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeFunctionControlMask(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "NoControl"
		  case 1
		    result = "InLine"
		  case 2
		    result = "DontInline"
		  case 4
		    result = "Pure"
		  case 8
		    result = "Const"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeLinkageType(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Export"
		  case 1
		    result = "Import"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeMemoryModel(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Simple"
		  case 1
		    result = "GLSL450"
		  case 2
		    result = "OpenCL1.2"
		  case 3
		    result = "OpenCL2.0"
		  case 4
		    result = "OpenCL2.1"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeSelectionControl(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "NoControl"
		  case 1
		    result = "Flatten"
		  case 2
		    result = "DontFlatten"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeSourceLanguage(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Unknown"
		  case 1
		    result = "ESSL"
		  case 2
		    result = "GLSL"
		  case 3
		    result = "OpenCL"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeStorageClass(value As UInt32) As String
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "UniformConstant"
		  case 1
		    result = "Input"
		  case 2
		    result = "Uniform"
		  case 3
		    result = "Output"
		  case 4
		    result = "WorkgroupLocal"
		  case 5
		    result = "WorkgroupGlobal"
		  case 6
		    result = "PrivateGlobal"
		  case 7
		    result = "Function"
		  case 8
		    result = "Generic"
		  case 9
		    result = "Private"
		  case 10
		    result = "AtomicCounter"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVTestModule1() As MemoryBlock
		  ' Flow:
		  ' 1 Optional OpSource instruction
		  ' 2 Optional OpSourceExtension instruction
		  ' 3 Optional OpCompileFlag instruction
		  ' 4 Optional OpExtension instruction
		  ' 5 Optional OpExtInstImpor instruction
		  ' 6 Required OpMemoryMode instruction
		  ' 7 Entry point declarations using OpEntryPoint
		  ' 8 Execution mode declarations using OpExecutionMode
		  ' 9 Debug and annotation instructions (e.g. decorations)
		  ' 10 All type declarations, constant instructions and global variable declarations
		  ' 11 All function definitions using OpFunction or OpFunctionParameter, ending with OpFunctionEnd
		  
		  Dim bin As new MemoryBlock(720)
		  
		  bin.UInt32Value(0) = &h07230203 ' magic number
		  bin.UInt32Value(4) = 99 ' version number (99 = pre-relase, 100 = first public version)
		  bin.UInt32Value(8) = &h00000000 ' 0: generator magic number
		  bin.UInt32Value(12) = 23 ' bound
		  bin.UInt32Value(16) = 0 ' reserved for instruction schema
		  
		  ' Source OpenCL 120
		  bin.UInt16Value(20) = 1 ' OpSource
		  bin.UInt16Value(22) = 3 ' word count
		  bin.UInt32Value(24) = 3 ' OpenCL
		  bin.UInt32Value(28) = 120 ' Version
		  
		  ' EntryPoint Kernel 9
		  bin.UInt16Value(32) = 6 ' OpEntryPoint
		  bin.UInt16Value(34) = 3 ' word count
		  bin.UInt32Value(36) = 6 ' execution model (Kernel)
		  bin.UInt32Value(40) = 9 ' entry point id
		  
		  ' MemoryModel Physical64 OpenCL1.2
		  bin.UInt16Value(44) = 5 ' OpMemoryModel
		  bin.UInt16Value(46) = 3 ' word count
		  bin.UInt32Value(48) = 2 ' addressing model (Physical64)
		  bin.UInt32Value(52) = 2 ' memory model (OpenCL1.2)
		  
		  ' Name 4 "LocalInvocationId"
		  bin.UInt16Value(56) = 54 ' OpName
		  bin.UInt16Value(58) = 2 + 5 ' word count
		  bin.UInt32Value(60) = 4 ' target id
		  bin.CString(64) = "LocalInvocationId" + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 9 "add"
		  bin.UInt16Value(84) = 54 ' OpName
		  bin.UInt16Value(86) = 2 + 1 ' word count
		  bin.UInt32Value(88) = 9 ' target id
		  bin.CString(92) = "add" + Chr(0) ' Name
		  
		  ' Name 10 "in1"
		  bin.UInt16Value(96) = 54 ' OpName
		  bin.UInt16Value(98) = 2 + 1 ' word count
		  bin.UInt32Value(100) = 10 ' target id
		  bin.CString(104) = "in1" + Chr(0) ' Name
		  
		  ' Name 11 "in2"
		  bin.UInt16Value(108) = 54 ' OpName
		  bin.UInt16Value(110) = 2 + 1 ' word count
		  bin.UInt32Value(112) = 11 ' target id
		  bin.CString(116) = "in2" + Chr(0) ' Name
		  
		  ' Name 12 "out"
		  bin.UInt16Value(120) = 54 ' OpName
		  bin.UInt16Value(122) = 2 + 1 ' word count
		  bin.UInt32Value(124) = 12 ' target id
		  bin.CString(128) = "out" + Chr(0) ' Name
		  
		  ' Name 13 "entry"
		  bin.UInt16Value(132) = 54 ' OpName
		  bin.UInt16Value(134) = 2 + 2 ' word count
		  bin.UInt32Value(136) = 13 ' target id
		  bin.CString(140) = "entry" + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 15 "call"
		  bin.UInt16Value(148) = 54 ' OpName
		  bin.UInt16Value(150) = 2 + 2 ' word count
		  bin.UInt32Value(152) = 15 ' target id
		  bin.CString(156) = "call" + Chr(0) + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 16 "arrayidx"
		  bin.UInt16Value(164) = 54 ' OpName
		  bin.UInt16Value(166) = 2 + 3 ' word count
		  bin.UInt32Value(168) = 16 ' target id
		  bin.CString(172) = "arrayidx" + Chr(0) + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 18 "arrayidx1"
		  bin.UInt16Value(184) = 54 ' OpName
		  bin.UInt16Value(186) = 2 + 3 ' word count
		  bin.UInt32Value(188) = 18 ' target id
		  bin.CString(192) = "arrayidx1" + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 20 "add"
		  bin.UInt16Value(204) = 54 ' OpName
		  bin.UInt16Value(206) = 2 + 1 ' word count
		  bin.UInt32Value(208) = 20 ' target id
		  bin.CString(212) = "add" + Chr(0) ' Name
		  
		  ' Name 21 "arrayidx2"
		  bin.UInt16Value(216) = 54 ' OpName
		  bin.UInt16Value(218) = 2 + 3 ' word count
		  bin.UInt32Value(220) = 21 ' target id
		  bin.CString(224) = "arrayidx2" + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Decorate 4(LocalInvocationId) Constant
		  bin.UInt16Value(236) = 50 ' OpDecorate
		  bin.UInt16Value(238) = 3 + 0 ' word count
		  bin.UInt32Value(240) = 4 ' target id
		  bin.UInt32Value(244) = 21 ' decoration (Constant)
		  
		  'Decorate 4(LocalInvocationId) Built-In LocalInvocationId
		  bin.UInt16Value(248) = 50 ' OpDecorate
		  bin.UInt16Value(250) = 3 + 1 ' word count
		  bin.UInt32Value(252) = 4 ' target id
		  bin.UInt32Value(256) = 39 ' decoration (Built-In)
		  bin.UInt32Value(260) = 27 '  LocalInvocationId
		  
		  ' Decorate 10(in1) FuncParamAttr 5
		  bin.UInt16Value(264) = 50 ' OpDecorate
		  bin.UInt16Value(266) = 3 + 1 ' word count
		  bin.UInt32Value(268) = 10 ' target id
		  bin.UInt32Value(272) = 40 ' FuncParamAttr
		  bin.UInt32Value(276) = 5 ' NoCapture
		  
		  ' Decorate 11(in2) FuncParamAttr 5
		  bin.UInt16Value(280) = 50 ' OpDecorate
		  bin.UInt16Value(282) = 3 + 1 ' word count
		  bin.UInt32Value(284) = 11 ' target id
		  bin.UInt32Value(288) = 40 ' FuncParamAttr
		  bin.UInt32Value(292) = 5 ' NoCapture
		  
		  ' Decorate 12(out) FuncParamAttr 5
		  bin.UInt16Value(296) = 50 ' OpDecorate
		  bin.UInt16Value(298) = 3 + 1 ' word count
		  bin.UInt32Value(300) = 12 ' target id
		  bin.UInt32Value(304) = 40 ' FuncParamAttr
		  bin.UInt32Value(308) = 5 ' NoCapture
		  
		  ' Decorate 17 Alignment 4
		  bin.UInt16Value(312) = 50 ' OpDecorate
		  bin.UInt16Value(314) = 3 + 1 ' word count
		  bin.UInt32Value(316) = 17 ' target id
		  bin.UInt32Value(320) = 36 ' Alignment (TBD: This can probably be removed.)
		  bin.UInt32Value(324) = 4 ' ? Not specified in SPIR-V specification
		  
		  ' Decorate 19 Alignment 4
		  bin.UInt16Value(328) = 50 ' OpDecorate
		  bin.UInt16Value(330) = 3 + 1 ' word count
		  bin.UInt32Value(332) = 19 ' target id
		  bin.UInt32Value(336) = 36 ' Alignment (TBD: This can probably be removed.)
		  bin.UInt32Value(340) = 4 ' ? Not specified in SPIR-V specification
		  
		  ' Decorate 22 Alignment 4
		  bin.UInt16Value(344) = 50 ' OpDecorate
		  bin.UInt16Value(346) = 3 + 1 ' word count
		  bin.UInt32Value(348) = 22 ' target id
		  bin.UInt32Value(352) = 36 ' Alignment (TBD: This can probably be removed.)
		  bin.UInt32Value(356) = 4 ' ? Not specified in SPIR-V specification
		  
		  ' 1: TypeInt 64 0
		  bin.UInt16Value(360) = 10 ' OpTypeInt
		  bin.UInt16Value(362) = 4 ' word count
		  bin.UInt32Value(364) = 1 ' result id
		  bin.UInt32Value(368) = 64 ' width
		  bin.UInt32Value(372) = 0 ' signedness (0 = unsigned, 1= signed)
		  
		  ' 2: TypeVector 1(int) 3
		  bin.UInt16Value(376) = 12 ' OpTypeVector
		  bin.UInt16Value(378) = 4 ' word count
		  bin.UInt32Value(380) = 2 ' result id
		  bin.UInt32Value(384) = 1 ' component type id
		  bin.UInt32Value(388) = 3 ' component count
		  
		  ' 3: TypePointer UniformConstant 2(ivec3)
		  bin.UInt16Value(392) = 20 ' OpTypePointer
		  bin.UInt16Value(394) = 4 ' word count
		  bin.UInt32Value(396) = 3 ' result id
		  bin.UInt32Value(400) = 0 ' storage class
		  bin.UInt32Value(404) = 2 ' type id
		  
		  ' 5: TypeVoid
		  bin.UInt16Value(408) = 8 ' OpTypeVoid
		  bin.UInt16Value(410) = 2 ' word count
		  bin.UInt32Value(412) = 5 ' result id
		  
		  ' 6: TypeInt 32 0
		  bin.UInt16Value(416) = 10 ' OpTypeInt
		  bin.UInt16Value(418) = 4 ' word count
		  bin.UInt32Value(420) = 6 ' result id
		  bin.UInt32Value(424) = 32 ' width
		  bin.UInt32Value(428) = 0 ' signedness (0 = unsigned, 1= signed)
		  
		  ' 7: TypePointer WorkgroupGlobal 6(int)
		  bin.UInt16Value(432) = 20 ' OpTypePointer
		  bin.UInt16Value(434) = 4 ' word count
		  bin.UInt32Value(436) = 7 ' result id
		  bin.UInt32Value(440) = 4 ' storage class
		  bin.UInt32Value(444) = 6 ' type id
		  
		  ' 8: TypeFunction 5 7(ptr) 7(ptr) 7(ptr)
		  bin.UInt16Value(448) = 21 ' OpTypeFunction
		  bin.UInt16Value(450) = 3 + 3 ' word count
		  bin.UInt32Value(452) = 8 ' result id
		  bin.UInt32Value(456) = 5 ' return type id
		  bin.UInt32Value(460) = 7 ' parameter 0 type
		  bin.UInt32Value(464) = 7 ' parameter 1 type
		  bin.UInt32Value(468) = 7 ' parameter 2 type
		  
		  ' 4(LocalInvocationId): 3(ptr) Variable UniformConstant
		  bin.UInt16Value(472) = 38 ' OpVariable
		  bin.UInt16Value(474) = 4 + 0 ' word count
		  bin.UInt32Value(476) = 3 ' result type id
		  bin.UInt32Value(480) = 4 ' result id
		  bin.UInt16Value(484) = 0 ' storage class
		  
		  ' 9(add): 5 Function NoControl 8
		  bin.UInt16Value(488) = 40 ' OpFunction
		  bin.UInt16Value(490) = 5 ' word count
		  bin.UInt32Value(492) = 5 ' result type id
		  bin.UInt32Value(496) = 9 ' result id
		  bin.UInt32Value(500) = 0 ' function control mask
		  bin.UInt32Value(504) = 8 ' function type id
		  
		  ' 10(in1): 7(ptr) FunctionParameter
		  bin.UInt16Value(508) = 41 ' OpFunctionParameter
		  bin.UInt16Value(510) = 3 ' word count
		  bin.UInt32Value(512) = 7 ' result type id
		  bin.UInt32Value(516) = 10 ' result id
		  
		  ' 11(in2): 7(ptr) FunctionParameter
		  bin.UInt16Value(520) = 41 ' OpFunctionParameter
		  bin.UInt16Value(522) = 3 ' word count
		  bin.UInt32Value(524) = 7 ' result type id
		  bin.UInt32Value(528) = 11 ' result id
		  
		  ' 12(out): 7(ptr) FunctionParameter
		  bin.UInt16Value(532) = 41 ' OpFunctionParameter
		  bin.UInt16Value(534) = 3 ' word count
		  bin.UInt32Value(536) = 7 ' result type id
		  bin.UInt32Value(540) = 12 ' result id
		  
		  ' 13(entry): Label
		  bin.UInt16Value(544) = 208 ' OpFunctionParameter
		  bin.UInt16Value(546) = 2 ' word count
		  bin.UInt32Value(548) = 13 ' result id
		  
		  ' 14: 2(ivec3) Load 4(LocalInvocationId)
		  bin.UInt16Value(552) = 46 ' OpLoad
		  bin.UInt16Value(554) = 4 + 0 ' word count
		  bin.UInt32Value(556) = 2 ' result type id
		  bin.UInt32Value(560) = 14 ' result id
		  bin.UInt32Value(564) = 4 ' pointer id
		  
		  ' 15(call): 1(int) CompositeExtract 14 0
		  bin.UInt16Value(568) = 62 ' OpCompositeExtract
		  bin.UInt16Value(570) = 4 + 1 ' word count
		  bin.UInt32Value(572) = 1 ' result type id
		  bin.UInt32Value(576) = 15 ' result id
		  bin.UInt32Value(580) = 14 ' composite id
		  bin.UInt32Value(584) = 0 ' index
		  
		  ' 16(arrayidx): 7(ptr) InBoundsAccessChain 10(in1) 15(call)
		  bin.UInt16Value(588) = 94 ' OpInBoundsAccessChain
		  bin.UInt16Value(590) = 4 + 1 ' word count
		  bin.UInt32Value(592) = 7 ' result type id
		  bin.UInt32Value(596) = 16 ' result id
		  bin.UInt32Value(600) = 10 ' base id
		  bin.UInt32Value(604) = 15 ' index id
		  
		  ' 17: 6(int) Load 16(arrayidx)
		  bin.UInt16Value(608) = 46 ' OpLoad
		  bin.UInt16Value(610) = 4 + 0 ' word count
		  bin.UInt32Value(612) = 6 ' result type id
		  bin.UInt32Value(616) = 17 ' result id
		  bin.UInt32Value(620) = 16 ' pointer id
		  
		  ' 18(arrayidx1): 7(ptr) InBoundsAccessChain 11(in2) 15(call)
		  bin.UInt16Value(624) = 94 ' OpInBoundsAccessChain
		  bin.UInt16Value(626) = 4 + 1 ' word count
		  bin.UInt32Value(628) = 7 ' result type id
		  bin.UInt32Value(632) = 18 ' result id
		  bin.UInt32Value(636) = 11 ' base id
		  bin.UInt32Value(640) = 15 ' index id
		  
		  ' 19: 6(int) Load 18(arrayidx1)
		  bin.UInt16Value(644) = 46 ' OpLoad
		  bin.UInt16Value(646) = 4 + 0 ' word count
		  bin.UInt32Value(648) = 6 ' result type id
		  bin.UInt32Value(652) = 19 ' result id
		  bin.UInt32Value(656) = 18 ' pointer id
		  
		  ' 20(add): 6(int) IAdd 19 17
		  bin.UInt16Value(660) = 122 ' OpIAdd
		  bin.UInt16Value(662) = 5 ' word count
		  bin.UInt32Value(664) = 6 ' result type id
		  bin.UInt32Value(668) = 20 ' result id
		  bin.UInt32Value(672) = 19 ' operand id 1
		  bin.UInt32Value(676) = 17 ' operand id 2
		  
		  ' 21(arrayidx2): 7(ptr) InBoundsAccessChain 12(out) 15(call)
		  bin.UInt16Value(680) = 94 ' OpInBoundsAccessChain
		  bin.UInt16Value(682) = 4 + 1 ' word count
		  bin.UInt32Value(684) = 7 ' result type id
		  bin.UInt32Value(688) = 21 ' result id
		  bin.UInt32Value(692) = 12 ' base id
		  bin.UInt32Value(696) = 15 ' index id
		  
		  ' Store 21(arrayidx2) 20
		  bin.UInt16Value(700) = 47 ' OpStore
		  bin.UInt16Value(702) = 3 + 0 ' word count
		  bin.UInt32Value(704) = 21 ' pointer id
		  bin.UInt32Value(708) = 20 ' object id
		  
		  ' Return
		  bin.UInt16Value(712) = 213 ' OpReturn
		  bin.UInt16Value(714) = 1 ' word count
		  
		  ' FunctionEnd
		  bin.UInt16Value(716) = 42 ' OpFunctionEnd
		  bin.UInt16Value(718) = 1 ' word count
		  
		  Dim f As FolderItem = App.ExecutableFile.Parent.Child("test_001.spirv")
		  Dim stream As BinaryStream
		  stream = BinaryStream.Create(f, True) // Overwrite if exists
		  stream.Write bin
		  stream.Close
		  
		  return bin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVTestModule2() As MemoryBlock
		  ' Flow:
		  ' 1 Optional OpSource instruction
		  ' 2 Optional OpSourceExtension instruction
		  ' 3 Optional OpCompileFlag instruction
		  ' 4 Optional OpExtension instruction
		  ' 5 Optional OpExtInstImpor instruction
		  ' 6 Required OpMemoryMode instruction
		  ' 7 Entry point declarations using OpEntryPoint
		  ' 8 Execution mode declarations using OpExecutionMode
		  ' 9 Debug and annotation instructions (e.g. decorations)
		  ' 10 All type declarations, constant instructions and global variable declarations
		  ' 11 All function definitions using OpFunction or OpFunctionParameter, ending with OpFunctionEnd
		  
		  Dim bin As new MemoryBlock(1362)
		  
		  bin.UInt32Value(0) = &h07230203 ' magic number
		  bin.UInt32Value(4) = 99 ' version number (99 = pre-relase, 100 = first public version)
		  bin.UInt32Value(8) = 0 ' generator magic number
		  bin.UInt32Value(12) = 59 ' bound
		  bin.UInt32Value(16) = 0 ' reserved for instruction schema
		  
		  ' Source GLSL 450
		  bin.UInt16Value(20) = 1 ' OpSource
		  bin.UInt16Value(22) = 3 ' word count
		  bin.UInt32Value(24) = 2 ' GLSL
		  bin.UInt32Value(28) = 450 ' Version
		  
		  ' 1: ExtInstImport "GLSL.std.450"
		  bin.UInt16Value(32) = 4 ' OpExtInstImport
		  bin.UInt16Value(34) = 2 + 4 ' word count
		  bin.UInt32Value(36) = 1 ' result id
		  bin.CString(40) = "GLSL.std.450" ' name
		  
		  ' MemoryModel Logical GLSL450
		  bin.UInt16Value(56) = 5 ' OpMemoryModel
		  bin.UInt16Value(58) = 3 ' word count
		  bin.UInt32Value(60) = 0 ' addressing model (Logical)
		  bin.UInt32Value(64) = 1 ' memory model (GLSL450)
		  
		  ' EntryPoint Fragment 4
		  bin.UInt16Value(68) = 6 ' OpEntryPoint
		  bin.UInt16Value(70) = 3 ' word count
		  bin.UInt32Value(72) = 4 ' execution model (Fragment)
		  bin.UInt32Value(76) = 4 ' entry point id
		  
		  ' Name 4 "main"
		  bin.UInt16Value(80) = 54 ' OpName
		  bin.UInt16Value(82) = 2 + 2 ' word count
		  bin.UInt32Value(84) = 9 ' target id
		  bin.CString(88) = "main" ' Name
		  
		  ' Name 10 "scale"
		  bin.UInt16Value(96) = 54 ' OpName
		  bin.UInt16Value(98) = 2 + 2 ' word count
		  bin.UInt32Value(100) = 10 ' target id
		  bin.CString(104) = "scale" ' Name
		  
		  ' Name 16 "cond"
		  bin.UInt16Value(112) = 54 ' OpName
		  bin.UInt16Value(114) = 2 + 2 ' word count
		  bin.UInt32Value(116) = 16 ' target id
		  bin.CString(120) = "cond" ' Name
		  
		  ' Name 21 "color"
		  bin.UInt16Value(128) = 54 ' OpName
		  bin.UInt16Value(130) = 2 + 2 ' Word Count
		  bin.UInt32Value(132) = 21 ' target id
		  bin.CString(136) = "color" ' Name
		  
		  ' Name 23 "color1"
		  bin.UInt16Value(144) = 54 ' OpName
		  bin.UInt16Value(146) = 2 + 2 ' word count
		  bin.UInt32Value(148) = 23 ' target id
		  bin.CString(152) = "color1" ' Name
		  
		  ' Name 29 "S"
		  bin.UInt16Value(160) = 54 ' OpName
		  bin.UInt16Value(162) = 2 + 1 ' word count
		  bin.UInt32Value(164) = 29 ' target id
		  bin.CString(168) = "S" ' Name
		  
		  ' MemberName 29(S) 0 "b"
		  bin.UInt16Value(172) = 55 ' OpMemberName
		  bin.UInt16Value(174) = 3 + 1 ' word count
		  bin.UInt32Value(176) = 29 ' type id
		  bin.UInt32Value(180) = 0 ' member
		  bin.CString(184) = "b" ' member
		  
		  ' MemberName 29(S) 1 "v"
		  bin.UInt16Value(188) = 55 ' OpMemberName
		  bin.UInt16Value(190) = 3 + 1 ' word count
		  bin.UInt32Value(192) = 29 ' type id
		  bin.UInt32Value(196) = 1 ' member
		  bin.CString(200) = "v" ' member
		  
		  ' MemberName 29(S) 2 "i"
		  bin.UInt16Value(204) = 55 ' OpMemberName
		  bin.UInt16Value(206) = 3 + 1 ' word count
		  bin.UInt32Value(208) = 29 ' type id
		  bin.UInt32Value(212) = 2 ' member
		  bin.CString(216) = "i" ' member
		  
		  ' Name 31 "s"
		  bin.UInt16Value(220) = 54 ' OpName
		  bin.UInt16Value(222) = 2 + 1 ' word count
		  bin.UInt32Value(224) = 31 ' target id
		  bin.CString(228) = "s" ' Name
		  
		  ' Name 39 "color2"
		  bin.UInt16Value(232) = 54 ' OpName
		  bin.UInt16Value(234) = 2 + 2 ' word count
		  bin.UInt32Value(236) = 39 ' target id
		  bin.CString(240) = "color2" ' Name
		  
		  ' Name 45 "i"
		  bin.UInt16Value(248) = 54 ' OpName
		  bin.UInt16Value(250) = 2 + 1 ' word count
		  bin.UInt32Value(252) = 45 ' target id
		  bin.CString(256) = "i" ' Name
		  
		  ' Name 53 "multiplier"
		  bin.UInt16Value(260) = 54 ' OpName
		  bin.UInt16Value(262) = 2 + 3 ' word count
		  bin.UInt32Value(264) = 53 ' target id
		  bin.CString(268) = "multiplier" ' Name
		  
		  ' Decorate 23(color1) Smooth
		  bin.UInt16Value(280) = 50 ' OpDecorate
		  bin.UInt16Value(282) = 3 + 0 ' word count
		  bin.UInt32Value(284) = 23 ' target id
		  bin.UInt32Value(288) = 11 ' decoration (Smooth)
		  
		  ' Decorate 39(color2) Noperspective
		  
		  bin.UInt16Value(292) = 50 ' OpDecorate
		  bin.UInt16Value(294) = 3 + 0 ' word count
		  bin.UInt32Value(296) = 39 ' target id
		  bin.UInt32Value(300) = 12 ' decoration (Noperspective)
		  
		  ' 2: TypeVoid
		  bin.UInt16Value(304) = 8 ' OpTypeVoid
		  bin.UInt16Value(306) = 2 ' word count
		  bin.UInt32Value(308) = 2 ' result id
		  
		  ' 3: TypeFunction 2
		  bin.UInt16Value(312) = 21 ' OpTypeFunction
		  bin.UInt16Value(314) = 3 + 0 ' word count
		  bin.UInt32Value(316) = 3 ' result id
		  bin.UInt32Value(320) = 2 ' return type id
		  
		  ' 7: TypeFloat 32
		  bin.UInt16Value(324) = 11 ' OpTypeFloat
		  bin.UInt16Value(326) = 3 ' word count
		  bin.UInt32Value(328) = 7 ' result id
		  bin.UInt32Value(332) = 32 ' return type id
		  
		  ' 8: TypeVector 7(float) 4
		  bin.UInt16Value(336) = 12 ' OpTypeVector
		  bin.UInt16Value(338) = 4 ' word count
		  bin.UInt32Value(340) = 8 ' result id
		  bin.UInt32Value(344) = 7 ' component type id
		  bin.UInt32Value(348) = 4 ' component count
		  
		  ' 9: TypePointer Function 8(fvec4)
		  bin.UInt16Value(352) = 20 ' OpTypePointer
		  bin.UInt16Value(354) = 4 ' word count
		  bin.UInt32Value(356) = 9 ' result id
		  bin.UInt32Value(360) = 7 ' storage class (Function)
		  bin.UInt32Value(364) = 8 ' type id
		  
		  ' 11: 7(float) Constant 1065353216
		  bin.UInt16Value(368) = 29 ' OpConstant
		  bin.UInt16Value(370) = 3 + 1 ' word count
		  bin.UInt32Value(372) = 7 ' result type id
		  bin.UInt32Value(376) = 11 ' result id
		  bin.UInt32Value(380) = 1065353216 ' value
		  
		  ' 12: 7(float) Constant 1073741824
		  bin.UInt16Value(384) = 29 ' OpConstant
		  bin.UInt16Value(386) = 3 + 1 ' word count
		  bin.UInt32Value(388) = 7 ' result type id
		  bin.UInt32Value(392) = 12 ' result id
		  bin.UInt32Value(396) = 1073741824 ' value
		  
		  ' 13: 8(fvec4) ConstantComposite 11 11 12 11
		  bin.UInt16Value(400) = 30 ' OpConstantComposite
		  bin.UInt16Value(402) = 3 + 4 ' word count
		  bin.UInt32Value(404) = 8 ' return type id
		  bin.UInt32Value(408) = 13 ' result id
		  bin.UInt32Value(412) = 11 ' constituent id 1
		  bin.UInt32Value(416) = 11 ' constituent id 2
		  bin.UInt32Value(420) = 12 ' constituent id 3
		  bin.UInt32Value(424) = 11 ' constituent id 4
		  
		  ' 14: TypeBool
		  bin.UInt16Value(428) = 9 ' OpConstantComposite
		  bin.UInt16Value(430) = 2 ' word count
		  bin.UInt32Value(432) = 14 ' result id
		  
		  ' 15: TypePointer UniformConstant 14(bool)
		  bin.UInt16Value(436) = 20 ' OpTypePointer
		  bin.UInt16Value(438) = 4 ' word count
		  bin.UInt32Value(440) = 15 ' result id
		  bin.UInt32Value(444) = 0 ' storage class (UniformConstant)
		  bin.UInt32Value(448) = 14 ' type id
		  
		  ' 16(cond): 15(ptr) Variable UniformConstant
		  bin.UInt16Value(452) = 38 ' OpVariable
		  bin.UInt16Value(454) = 4 + 0 ' word count
		  bin.UInt32Value(456) = 15 ' result type id
		  bin.UInt32Value(460) = 16 ' result id
		  bin.UInt16Value(464) = 0 ' storage class (UniformConstant)
		  
		  ' 20: TypePointer Output 8(fvec4)
		  bin.UInt16Value(468) = 20 ' OpTypePointer
		  bin.UInt16Value(470) = 4 ' word count
		  bin.UInt32Value(472) = 20 ' result id
		  bin.UInt32Value(476) = 3 ' storage class (Output)
		  bin.UInt32Value(480) = 8 ' type id
		  
		  ' 21(color): 20(ptr) Variable Output
		  bin.UInt16Value(484) = 38 ' OpVariable
		  bin.UInt16Value(486) = 4 + 0 ' word count
		  bin.UInt32Value(488) = 20 ' result type id
		  bin.UInt32Value(492) = 21 ' result id
		  bin.UInt16Value(496) = 3 ' storage class (Output)
		  
		  ' 22: TypePointer Input 8(fvec4)
		  bin.UInt16Value(500) = 20 ' OpTypePointer
		  bin.UInt16Value(502) = 4 ' word count
		  bin.UInt32Value(504) = 22 ' result id
		  bin.UInt32Value(508) = 1 ' storage class (Input)
		  bin.UInt32Value(512) = 8 ' type id
		  
		  ' 23(color1): 22(ptr) Variable Input
		  bin.UInt16Value(516) = 38 ' OpVariable
		  bin.UInt16Value(518) = 4 + 0 ' word count
		  bin.UInt32Value(520) = 22 ' result type id
		  bin.UInt32Value(524) = 23 ' result id
		  bin.UInt16Value(528) = 1 ' storage class (Input)
		  
		  '25: TypeInt 32 0
		  bin.UInt16Value(532) = 10 ' OpTypeInt
		  bin.UInt16Value(534) = 4 ' word count
		  bin.UInt32Value(536) = 25 ' result id
		  bin.UInt32Value(540) = 32 ' width
		  bin.UInt32Value(544) = 0 ' signedness (0=unsigned, 1=signed)
		  
		  ' 26: 25(int) Constant 5
		  bin.UInt16Value(548) = 29 ' OpConstant
		  bin.UInt16Value(550) = 3 + 1 ' word count
		  bin.UInt32Value(552) = 25 ' result type id
		  bin.UInt32Value(556) = 26 ' result id
		  bin.UInt32Value(560) = 5 ' value
		  
		  ' 27: TypeArray 8(fvec4) 26
		  bin.UInt16Value(564) = 16 ' OpConstant
		  bin.UInt16Value(566) = 4 ' word count
		  bin.UInt32Value(568) = 27 ' result id
		  bin.UInt32Value(572) = 8 ' element type id
		  bin.UInt32Value(576) = 26 ' length
		  
		  ' 28: TypeInt 32 1
		  bin.UInt16Value(580) = 10 ' OpTypeInt
		  bin.UInt16Value(582) = 4 ' word count
		  bin.UInt32Value(584) = 28 ' result id
		  bin.UInt32Value(588) = 32 ' width
		  bin.UInt32Value(592) = 1 ' signedness (0=unsigned, 1=signed)
		  
		  ' 29(S): TypeStruct 14(bool) 27 28(int)
		  bin.UInt16Value(596) = 18 ' OpTypeStruct
		  bin.UInt16Value(598) = 2 + 3 ' word count
		  bin.UInt32Value(600) = 29 ' result id
		  bin.UInt32Value(604) = 14 ' member 0 type id
		  bin.UInt32Value(608) = 27 ' member 1 type id
		  bin.UInt32Value(612) = 28 ' member 2 type id
		  
		  ' 30: TypePointer UniformConstant 29(S)
		  bin.UInt16Value(616) = 20 ' OpTypePointer
		  bin.UInt16Value(618) = 4 ' word count
		  bin.UInt32Value(620) = 30 ' result id
		  bin.UInt32Value(624) = 0 ' storage class (UniformConstant)
		  bin.UInt32Value(628) = 29 ' type id
		  
		  ' 31(s): 30(ptr) Variable UniformConstant
		  bin.UInt16Value(632) = 38 ' OpVariable
		  bin.UInt16Value(634) = 4 + 0 ' word count
		  bin.UInt32Value(636) = 30 ' result type id
		  bin.UInt32Value(640) = 31 ' result id
		  bin.UInt16Value(644) = 0 ' storage class (UniformConstant)
		  
		  ' 32: 28(int) Constant 1
		  bin.UInt16Value(648) = 29 ' OpConstant
		  bin.UInt16Value(650) = 3 + 1 ' word count
		  bin.UInt32Value(652) = 28 ' result type id
		  bin.UInt32Value(656) = 32 ' result id
		  bin.UInt32Value(660) = 1 ' value
		  
		  ' 33: 28(int) Constant 2
		  bin.UInt16Value(664) = 29 ' OpConstant
		  bin.UInt16Value(666) = 3 + 1 ' word count
		  bin.UInt32Value(668) = 28 ' result type id
		  bin.UInt32Value(672) = 33 ' result id
		  bin.UInt32Value(676) = 2 ' value
		  
		  ' 34: TypePointer UniformConstant 8(fvec4)
		  bin.UInt16Value(680) = 20 ' OpTypePointer
		  bin.UInt16Value(682) = 4 ' word count
		  bin.UInt32Value(684) = 34 ' result id
		  bin.UInt32Value(688) = 0 ' storage class (UniformConstant)
		  bin.UInt32Value(692) = 8 ' type id
		  
		  ' 39(color2): 22(ptr) Variable Input
		  bin.UInt16Value(696) = 38 ' OpVariable
		  bin.UInt16Value(698) = 4 + 0 ' word count
		  bin.UInt32Value(700) = 22 ' result type id
		  bin.UInt32Value(704) = 39 ' result id
		  bin.UInt16Value(708) = 1 ' storage class (Input)
		  
		  ' 44: TypePointer Function 28(int)
		  bin.UInt16Value(712) = 20 ' OpTypePointer
		  bin.UInt16Value(714) = 4 ' word count
		  bin.UInt32Value(716) = 44 ' result id
		  bin.UInt32Value(720) = 7 ' storage class (Function)
		  bin.UInt32Value(724) = 28 ' type id
		  
		  ' 46: 28(int) Constant 0
		  bin.UInt16Value(728) = 29 ' OpConstant
		  bin.UInt16Value(730) = 3 + 1 ' word count
		  bin.UInt32Value(732) = 28 ' result type id
		  bin.UInt32Value(736) = 46 ' result id
		  bin.UInt32Value(740) = 0 ' value
		  
		  ' 50: 28(int) Constant 4
		  bin.UInt16Value(744) = 29 ' OpConstant
		  bin.UInt16Value(746) = 3 + 1 ' word count
		  bin.UInt32Value(748) = 28 ' result type id
		  bin.UInt32Value(752) = 50 ' result id
		  bin.UInt32Value(756) = 4 ' value
		  
		  ' 53(multiplier): 34(ptr) Variable UniformConstant
		  bin.UInt16Value(760) = 38 ' OpVariable
		  bin.UInt16Value(762) = 4 + 0 ' word count
		  bin.UInt32Value(764) = 34 ' result type id
		  bin.UInt32Value(768) = 53 ' result id
		  bin.UInt16Value(772) = 0 ' storage class (UniformConstant)
		  
		  ' 4(main): 2 Function NoControl 3
		  bin.UInt16Value(776) = 40 ' OpFunction
		  bin.UInt16Value(778) = 5 ' word count
		  bin.UInt32Value(780) = 2 ' result type id
		  bin.UInt32Value(784) = 4 ' result id
		  bin.UInt32Value(788) = 0 ' function control mask
		  bin.UInt32Value(792) = 3 ' function type id
		  
		  ' 5: Label
		  bin.UInt16Value(796) = 208 ' OpLabel
		  bin.UInt16Value(798) = 2 ' word count
		  bin.UInt32Value(800) = 5 ' result id
		  
		  ' 10(scale): 9(ptr) Variable Function
		  bin.UInt16Value(804) = 38 ' OpVariable
		  bin.UInt16Value(806) = 4 + 0 ' word count
		  bin.UInt32Value(808) = 9 ' result type id
		  bin.UInt32Value(812) = 10 ' result id
		  bin.UInt16Value(816) = 7 ' storage class (Function)
		  
		  ' 45(i): 44(ptr) Variable Function
		  bin.UInt16Value(820) = 38 ' OpVariable
		  bin.UInt16Value(822) = 4 + 0 ' word count
		  bin.UInt32Value(824) = 44 ' result type id
		  bin.UInt32Value(828) = 45 ' result id
		  bin.UInt16Value(832) = 7 ' storage class (Function)
		  
		  ' Store 10(scale) 13
		  bin.UInt16Value(836) = 47 ' OpStore
		  bin.UInt16Value(838) = 3 + 0 ' word count
		  bin.UInt32Value(840) = 10 ' pointer id
		  bin.UInt32Value(844) = 13 ' object id
		  
		  ' 17: 14(bool) Load 16(cond)
		  bin.UInt16Value(848) = 46 ' OpLoad
		  bin.UInt16Value(850) = 4 + 0 ' word count
		  bin.UInt32Value(852) = 14 ' result type id
		  bin.UInt32Value(856) = 17 ' result id
		  bin.UInt32Value(860) = 16 ' pointer id
		  
		  ' SelectionMerge 19 NoControl
		  bin.UInt16Value(864) = 207 ' OpSelectionMerge
		  bin.UInt16Value(866) = 3 ' word count
		  bin.UInt32Value(868) = 19 ' label id
		  bin.UInt32Value(872) = 0 ' selection control (NoControl)
		  
		  ' BranchConditional 17 18 38
		  bin.UInt16Value(876) = 210 ' OpSelectionMerge
		  bin.UInt16Value(878) = 4 + 0 ' word count
		  bin.UInt32Value(880) = 17 ' condition id
		  bin.UInt32Value(884) = 18 ' true label
		  bin.UInt32Value(888) = 38 ' false label
		  
		  ' 18: Label
		  bin.UInt16Value(892) = 208 ' OpLabel
		  bin.UInt16Value(894) = 2 ' word count
		  bin.UInt32Value(896) = 18 ' result id
		  
		  ' 24: 8(fvec4) Load 23(color1)
		  bin.UInt16Value(900) = 46 ' OpLoad
		  bin.UInt16Value(902) = 4 + 0 ' word count
		  bin.UInt32Value(904) = 8 ' result type id
		  bin.UInt32Value(908) = 24 ' result id
		  bin.UInt32Value(912) = 23 ' pointer id
		  
		  ' 35: 34(ptr) AccessChain 31(s) 32 33
		  bin.UInt16Value(916) = 93 ' OpAccessChain
		  bin.UInt16Value(918) = 4 + 2 ' word count
		  bin.UInt32Value(920) = 34 ' result type id
		  bin.UInt32Value(924) = 35 ' result id
		  bin.UInt32Value(928) = 31 ' base id
		  bin.UInt32Value(932) = 32 ' index 0 id
		  bin.UInt32Value(936) = 33 ' index 1 id
		  
		  ' 36: 8(fvec4) Load 35
		  bin.UInt16Value(940) = 46 ' OpLoad
		  bin.UInt16Value(942) = 4 + 0 ' word count
		  bin.UInt32Value(944) = 8 ' result type id
		  bin.UInt32Value(948) = 36 ' result id
		  bin.UInt32Value(952) = 35 ' pointer id
		  
		  ' 37: 8(fvec4) FAdd 24 36
		  bin.UInt16Value(956) = 123 ' OpFAdd
		  bin.UInt16Value(958) = 5 ' word count
		  bin.UInt32Value(960) = 8 ' result type id
		  bin.UInt32Value(964) = 37 ' result id
		  bin.UInt32Value(968) = 24 ' operand 1 id
		  bin.UInt32Value(972) = 36 ' operand 2 id
		  
		  ' Store 21(color) 37
		  bin.UInt16Value(976) = 47 ' OpStore
		  bin.UInt16Value(978) = 3 + 0 ' word count
		  bin.UInt32Value(980) = 21 ' pointer id
		  bin.UInt32Value(984) = 37 ' object id
		  
		  ' Branch 19
		  bin.UInt16Value(988) = 209 ' OpBranch
		  bin.UInt16Value(990) = 2 ' word count
		  bin.UInt32Value(992) = 19 ' target label id
		  
		  ' 38: Label
		  bin.UInt16Value(996) = 208 ' OpLabel
		  bin.UInt16Value(998) = 2 ' word count
		  bin.UInt32Value(1000) = 38 ' result id
		  
		  ' 40: 8(fvec4) Load 39(color2)
		  bin.UInt16Value(1004) = 46 ' OpLoad
		  bin.UInt16Value(1006) = 4 + 0 ' word count
		  bin.UInt32Value(1008) = 8 ' result type id
		  bin.UInt32Value(1012) = 40 ' result id
		  bin.UInt32Value(1016) = 39 ' pointer id
		  
		  ' 41: 8(fvec4) ExtInst 1(GLSL.std.450) 28(sqrt) 40
		  bin.UInt16Value(1020) = 44 ' OpExtInst
		  bin.UInt16Value(1022) = 5 + 1 ' word count
		  bin.UInt32Value(1024) = 8 ' result type id
		  bin.UInt32Value(1028) = 41 ' result id
		  bin.UInt32Value(1032) = 1 ' set id
		  bin.UInt32Value(1036) = 28 ' instruction (sqrt)
		  bin.UInt32Value(1040) = 40 ' operand 1 id
		  
		  ' 42: 8(fvec4) Load 10(scale)
		  bin.UInt16Value(1044) = 46 ' OpLoad
		  bin.UInt16Value(1046) = 4 + 0 ' word count
		  bin.UInt32Value(1048) = 8 ' result type id
		  bin.UInt32Value(1052) = 42 ' result id
		  bin.UInt32Value(1056) = 10 ' pointer id
		  
		  ' 43: 8(fvec4) FMul 41 42
		  bin.UInt16Value(1060) = 127 ' OpFMul
		  bin.UInt16Value(1062) = 5 ' word count
		  bin.UInt32Value(1064) = 8 ' result type id
		  bin.UInt32Value(1068) = 43 ' result id
		  bin.UInt32Value(1072) = 41 ' operand 1 id
		  bin.UInt32Value(1076) = 42 ' operand 2 id
		  
		  ' Store 21(color) 43
		  bin.UInt16Value(1080) = 47 ' OpStore
		  bin.UInt16Value(1082) = 3 + 0 ' word count
		  bin.UInt32Value(1084) = 21 ' pointer id
		  bin.UInt32Value(1088) = 43 ' object id
		  
		  ' Branch 19
		  bin.UInt16Value(1092) = 209 ' OpBranch
		  bin.UInt16Value(1094) = 2 ' word count
		  bin.UInt32Value(1096) = 19 ' target label id
		  
		  ' 19: Label
		  bin.UInt16Value(1100) = 208 ' OpLabel
		  bin.UInt16Value(1102) = 2 ' word count
		  bin.UInt32Value(1104) = 19 ' result id
		  
		  ' Store 45(i) 46
		  bin.UInt16Value(1108) = 47 ' OpStore
		  bin.UInt16Value(1110) = 3 + 0 ' word count
		  bin.UInt32Value(1112) = 45 ' pointer id
		  bin.UInt32Value(1116) = 46 ' object id
		  
		  ' Branch 47
		  bin.UInt16Value(1120) = 209 ' OpBranch
		  bin.UInt16Value(1122) = 2 ' word count
		  bin.UInt32Value(1124) = 47 ' target label id
		  
		  ' 47: Label
		  bin.UInt16Value(1128) = 208 ' OpLabel
		  bin.UInt16Value(1130) = 2 ' word count
		  bin.UInt32Value(1132) = 47 ' result id
		  
		  ' 49: 28(int) Load 45(i)
		  bin.UInt16Value(1136) = 46 ' OpLoad
		  bin.UInt16Value(1138) = 4 + 0 ' word count
		  bin.UInt32Value(1140) = 28 ' result type id
		  bin.UInt32Value(1144) = 49 ' result id
		  bin.UInt32Value(1148) = 45 ' pointer id
		  
		  ' 51: 14(bool) SLessThan 49 50
		  bin.UInt16Value(1152) = 160 ' OpSLessThan
		  bin.UInt16Value(1154) = 5 ' word count
		  bin.UInt32Value(1156) = 14 ' result type id
		  bin.UInt32Value(1160) = 51 ' result id
		  bin.UInt32Value(1164) = 49 ' operand 1 id
		  bin.UInt32Value(1168) = 50 ' operand 2 id
		  
		  ' LoopMerge 48 NoControl
		  bin.UInt16Value(1172) = 206 ' OpLoopMerge
		  bin.UInt16Value(1174) = 3 ' word count
		  bin.UInt32Value(1176) = 48 ' label id
		  bin.UInt32Value(1180) = 0 ' loop control (NoControl)
		  
		  ' BranchConditional 51 52 48
		  bin.UInt16Value(1184) = 210 ' OpBranchConditional
		  bin.UInt16Value(1186) = 4 + 0 ' word count
		  bin.UInt32Value(1188) = 51 ' condition id
		  bin.UInt32Value(1192) = 52 ' true label id
		  bin.UInt32Value(1196) = 48 ' false label id
		  
		  ' 52: Label
		  bin.UInt16Value(1200) = 208 ' OpLabel
		  bin.UInt16Value(1202) = 2 ' word count
		  bin.UInt32Value(1204) = 52 ' result id
		  
		  ' 54: 8(fvec4) Load 53(multiplier)
		  bin.UInt16Value(1208) = 46 ' OpLoad
		  bin.UInt16Value(1210) = 4 + 0 ' word count
		  bin.UInt32Value(1212) = 8 ' result type id
		  bin.UInt32Value(1216) = 54 ' result id
		  bin.UInt32Value(1220) = 53 ' pointer id
		  
		  ' 55: 8(fvec4) Load 21(color)
		  bin.UInt16Value(1224) = 46 ' OpLoad
		  bin.UInt16Value(1226) = 4 + 0 ' word count
		  bin.UInt32Value(1228) = 8 ' result type id
		  bin.UInt32Value(1232) = 55 ' result id
		  bin.UInt32Value(1236) = 21 ' pointer id
		  
		  ' 56: 8(fvec4) FMul 55 54
		  bin.UInt16Value(1240) = 127 ' OpFMul
		  bin.UInt16Value(1242) = 5 ' word count
		  bin.UInt32Value(1244) = 8 ' result type id
		  bin.UInt32Value(1248) = 56 ' result id
		  bin.UInt32Value(1252) = 55 ' operand 1 id
		  bin.UInt32Value(1256) = 54 ' operand 2 id
		  
		  ' Store 21(color) 56
		  bin.UInt16Value(1260) = 47 ' OpStore
		  bin.UInt16Value(1262) = 3 + 0 ' word count
		  bin.UInt32Value(1264) = 21 ' pointer id
		  bin.UInt32Value(1268) = 56 ' object id
		  
		  ' 57: 28(int) Load 45(i)
		  bin.UInt16Value(1272) = 46 ' OpLoad
		  bin.UInt16Value(1274) = 4 + 0 ' word count
		  bin.UInt32Value(1276) = 28 ' result type id
		  bin.UInt32Value(1280) = 57 ' result id
		  bin.UInt32Value(1284) = 45 ' pointer id
		  
		  ' 58: 28(int) IAdd 57 32
		  bin.UInt16Value(1288) = 122 ' OpIAdd
		  bin.UInt16Value(1290) = 5 ' word count
		  bin.UInt32Value(1292) = 28 ' result type id
		  bin.UInt32Value(1296) = 58 ' result id
		  bin.UInt32Value(1300) = 57 ' operand id 1
		  bin.UInt32Value(1304) = 32 ' operand id 2
		  
		  ' Store 45(i) 58
		  bin.UInt16Value(1308) = 47 ' OpStore
		  bin.UInt16Value(1310) = 3 + 0 ' word count
		  bin.UInt32Value(1312) = 45 ' pointer id
		  bin.UInt32Value(1316) = 58 ' object id
		  
		  ' Branch 47
		  bin.UInt16Value(1320) = 209 ' OpBranch
		  bin.UInt16Value(1322) = 2 ' word count
		  bin.UInt32Value(1324) = 47 ' target label id
		  
		  ' 48: Label
		  bin.UInt16Value(1328) = 208 ' OpLabel
		  bin.UInt16Value(1330) = 2 ' word count
		  bin.UInt32Value(1332) = 48 ' result id
		  
		  ' Branch 6
		  bin.UInt16Value(1336) = 209 ' OpBranch
		  bin.UInt16Value(1338) = 2 ' word count
		  bin.UInt32Value(1340) = 6 ' target label id
		  
		  ' 6: Label
		  bin.UInt16Value(1344) = 208 ' OpLabel
		  bin.UInt16Value(1346) = 2 ' word count
		  bin.UInt32Value(1348) = 6 ' result id
		  
		  ' Return
		  bin.UInt16Value(1352) = 213 ' OpReturn
		  bin.UInt16Value(1354) = 1 ' word count
		  
		  ' FunctionEnd
		  bin.UInt16Value(1356) = 42 ' OpFunctionEnd
		  bin.UInt16Value(1358) = 1 ' word count
		  
		  Dim f As FolderItem = App.ExecutableFile.Parent.Child("test_002.spirv")
		  Dim stream As BinaryStream
		  stream = BinaryStream.Create(f, True) // Overwrite if exists
		  stream.Write bin
		  stream.Close
		  
		  return bin
		  
		End Function
	#tag EndMethod


	#tag Enum, Name = SPIRVOpcodeTypeEnum, Type = Integer, Flags = &h0
		Unknown
		  OpCompositeExtract
		  OpConstant
		  OpConstantComposite
		  OpDecorate
		  OpEntryPoint
		  OpExtInstImport
		  OpFunction
		  OpFunctionEnd
		  OpFunctionParameter
		  OpIAdd
		  OpInBoundsAccessChain
		  OpLabel
		  OpLoad
		  OpMemberName
		  OpMemoryModel
		  OpName
		  OpTypeArray
		  OpTypeBool
		  OpTypeFloat
		  OpTypeFunction
		  OpTypeInt
		  OpTypePointer
		  OpTypeStruct
		  OpTypeVector
		  OpTypeVoid
		  OpReturn
		  OpSelectionMerge
		  OpSource
		  OpStore
		OpVariable
	#tag EndEnum

	#tag Enum, Name = SPIRVTypeEnum, Type = Integer, Flags = &h0
		Array_
		  Boolean
		  DeviceEvent
		  Event_
		  Float
		  Function_
		  Integer
		  Matrix
		  Opaque
		  Pipe
		  Pointer
		  Queue
		  ReservedId
		  RuntimeArray
		  Sampler
		  Struct
		  Vector
		Void
	#tag EndEnum


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
	#tag EndViewBehavior
End Module
#tag EndModule
