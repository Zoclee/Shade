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
		Function SPIRVDescribeSourceLanguage(value As UInt32) As String
		  Dim result As String
		  
		  select case value
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
		  
		  Dim bin As new MemoryBlock(716)
		  
		  bin.UInt32Value(0) = &h07230203 ' magic number
		  bin.UInt32Value(4) = 99 ' version number (99 = pre-relase, 100 = first public version)
		  bin.UInt32Value(8) = &h0000001B ' 27: generator magic number
		  bin.UInt32Value(12) = 23 ' bound
		  bin.UInt32Value(16) = 0 ' reserved for instruction schema
		  
		  ' Source OpenCL 120
		  bin.UInt16Value(16) = 1 ' OpSource
		  bin.UInt16Value(18) = 3 ' Word Count
		  bin.UInt32Value(20) = 3 ' OpenCL
		  bin.UInt32Value(24) = 120 ' Version
		  
		  ' EntryPoint Kernel 9
		  bin.UInt16Value(28) = 6 ' OpEntryPoint
		  bin.UInt16Value(30) = 3 ' Word Count
		  bin.UInt32Value(32) = 6 ' Kernel
		  bin.UInt32Value(36) = 9 ' entry point <id>
		  
		  ' MemoryModel Physical64 OpenCL1.2
		  bin.UInt16Value(40) = 5 ' OpMemoryModel
		  bin.UInt16Value(42) = 3 ' Word Count
		  bin.UInt32Value(44) = 2 ' 2 - Physical64
		  bin.UInt32Value(48) = 2 ' 2 - OpenCL1.2
		  
		  ' Name 4 "LocalInvocationId"
		  bin.UInt16Value(52) = 54 ' OpName
		  bin.UInt16Value(54) = 2 + 5 ' Word Count
		  bin.UInt32Value(56) = 4 ' target id
		  bin.CString(60) = "LocalInvocationId" + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 9 "add"
		  bin.UInt16Value(80) = 54 ' OpName
		  bin.UInt16Value(82) = 2 + 1 ' Word Count
		  bin.UInt32Value(84) = 9 ' target id
		  bin.CString(88) = "add" + Chr(0) ' Name
		  
		  ' Name 10 "in1"
		  bin.UInt16Value(92) = 54 ' OpName
		  bin.UInt16Value(94) = 2 + 1 ' Word Count
		  bin.UInt32Value(96) = 10 ' target id
		  bin.CString(100) = "in1" + Chr(0) ' Name
		  
		  ' Name 11 "in2"
		  bin.UInt16Value(104) = 54 ' OpName
		  bin.UInt16Value(106) = 2 + 1 ' Word Count
		  bin.UInt32Value(108) = 11 ' target id
		  bin.CString(112) = "in2" + Chr(0) ' Name
		  
		  ' Name 12 "out"
		  bin.UInt16Value(116) = 54 ' OpName
		  bin.UInt16Value(118) = 2 + 1 ' Word Count
		  bin.UInt32Value(120) = 12 ' target id
		  bin.CString(124) = "out" + Chr(0) ' Name
		  
		  ' Name 13 "entry"
		  bin.UInt16Value(128) = 54 ' OpName
		  bin.UInt16Value(130) = 2 + 2 ' Word Count
		  bin.UInt32Value(132) = 13 ' target id
		  bin.CString(136) = "entry" + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 15 "call"
		  bin.UInt16Value(144) = 54 ' OpName
		  bin.UInt16Value(146) = 2 + 2 ' Word Count
		  bin.UInt32Value(148) = 15 ' target id
		  bin.CString(152) = "call" + Chr(0) + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 16 "arrayidx"
		  bin.UInt16Value(160) = 54 ' OpName
		  bin.UInt16Value(162) = 2 + 3 ' Word Count
		  bin.UInt32Value(164) = 16 ' target id
		  bin.CString(168) = "arrayidx" + Chr(0) + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 18 "arrayidx1"
		  bin.UInt16Value(180) = 54 ' OpName
		  bin.UInt16Value(182) = 2 + 3 ' Word Count
		  bin.UInt32Value(184) = 18 ' target id
		  bin.CString(188) = "arrayidx1" + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Name 20 "add"
		  bin.UInt16Value(200) = 54 ' OpName
		  bin.UInt16Value(202) = 2 + 1 ' Word Count
		  bin.UInt32Value(204) = 20 ' target id
		  bin.CString(208) = "add" + Chr(0) ' Name
		  
		  ' Name 21 "arrayidx2"
		  bin.UInt16Value(212) = 54 ' OpName
		  bin.UInt16Value(214) = 2 + 3 ' Word Count
		  bin.UInt32Value(216) = 21 ' target id
		  bin.CString(220) = "arrayidx2" + Chr(0) + Chr(0) + Chr(0) ' Name
		  
		  ' Decorate 4(LocalInvocationId) Constant
		  bin.UInt16Value(232) = 50 ' OpDecorate
		  bin.UInt16Value(234) = 3 + 0 ' Word Count
		  bin.UInt32Value(236) = 4 ' target id
		  bin.UInt32Value(240) = 21 ' Constant
		  
		  'Decorate 4(LocalInvocationId) Built-In LocalInvocationId
		  bin.UInt16Value(244) = 50 ' OpDecorate
		  bin.UInt16Value(246) = 3 + 1 ' Word Count
		  bin.UInt32Value(248) = 4 ' target id
		  bin.UInt32Value(252) = 39 ' Built-In
		  bin.UInt32Value(256) = 27 ' LocalInvocationId
		  
		  ' Decorate 10(in1) FuncParamAttr 5
		  bin.UInt16Value(260) = 50 ' OpDecorate
		  bin.UInt16Value(262) = 3 + 1 ' Word Count
		  bin.UInt32Value(264) = 10 ' target id
		  bin.UInt32Value(268) = 40 ' FuncParamAttr
		  bin.UInt32Value(272) = 5 ' NoCapture
		  
		  ' Decorate 11(in2) FuncParamAttr 5
		  bin.UInt16Value(276) = 50 ' OpDecorate
		  bin.UInt16Value(278) = 3 + 1 ' Word Count
		  bin.UInt32Value(280) = 11 ' target id
		  bin.UInt32Value(284) = 40 ' FuncParamAttr
		  bin.UInt32Value(288) = 5 ' NoCapture
		  
		  ' Decorate 12(out) FuncParamAttr 5
		  bin.UInt16Value(292) = 50 ' OpDecorate
		  bin.UInt16Value(294) = 3 + 1 ' Word Count
		  bin.UInt32Value(296) = 12 ' target id
		  bin.UInt32Value(300) = 40 ' FuncParamAttr
		  bin.UInt32Value(304) = 5 ' NoCapture
		  
		  ' Decorate 17 Alignment 4
		  bin.UInt16Value(308) = 50 ' OpDecorate
		  bin.UInt16Value(310) = 3 + 1 ' Word Count
		  bin.UInt32Value(312) = 17 ' target id
		  bin.UInt32Value(316) = 36 ' Alignment (TBD: This can probably be removed.)
		  bin.UInt32Value(320) = 4 ' ? Not specified in SPIR-V specification
		  
		  ' Decorate 19 Alignment 4
		  bin.UInt16Value(324) = 50 ' OpDecorate
		  bin.UInt16Value(326) = 3 + 1 ' Word Count
		  bin.UInt32Value(328) = 19 ' target id
		  bin.UInt32Value(332) = 36 ' Alignment (TBD: This can probably be removed.)
		  bin.UInt32Value(336) = 4 ' ? Not specified in SPIR-V specification
		  
		  ' Decorate 22 Alignment 4
		  bin.UInt16Value(340) = 50 ' OpDecorate
		  bin.UInt16Value(342) = 3 + 1 ' Word Count
		  bin.UInt32Value(344) = 22 ' target id
		  bin.UInt32Value(348) = 36 ' Alignment (TBD: This can probably be removed.)
		  bin.UInt32Value(352) = 4 ' ? Not specified in SPIR-V specification
		  
		  ' 1: TypeInt 64 0
		  bin.UInt16Value(356) = 10 ' OpTypeInt
		  bin.UInt16Value(358) = 4 ' Word Count
		  bin.UInt32Value(360) = 1 ' result id
		  bin.UInt32Value(364) = 64 ' width
		  bin.UInt32Value(368) = 0 ' signedness (0 = unsigned, 1= signed)
		  
		  ' 2: TypeVector 1(int) 3
		  bin.UInt16Value(372) = 12 ' OpTypeVector
		  bin.UInt16Value(374) = 4 ' Word Count
		  bin.UInt32Value(376) = 2 ' result id
		  bin.UInt32Value(380) = 1 ' component type id
		  bin.UInt32Value(384) = 3 ' component count
		  
		  ' 3: TypePointer UniformConstant 2(ivec3)
		  bin.UInt16Value(388) = 20 ' OpTypePointer
		  bin.UInt16Value(390) = 4 ' Word Count
		  bin.UInt32Value(392) = 3 ' result id
		  bin.UInt32Value(396) = 0 ' storage class
		  bin.UInt32Value(400) = 2 ' type id
		  
		  ' 5: TypeVoid
		  bin.UInt16Value(404) = 8 ' OpTypeVoid
		  bin.UInt16Value(406) = 2 ' Word Count
		  bin.UInt32Value(408) = 5 ' result id
		  
		  ' 6: TypeInt 32 0
		  bin.UInt16Value(412) = 10 ' OpTypeInt
		  bin.UInt16Value(414) = 4 ' Word Count
		  bin.UInt32Value(416) = 6 ' result id
		  bin.UInt32Value(420) = 32 ' width
		  bin.UInt32Value(424) = 0 ' signedness (0 = unsigned, 1= signed)
		  
		  ' 7: TypePointer WorkgroupGlobal 6(int)
		  bin.UInt16Value(428) = 20 ' OpTypePointer
		  bin.UInt16Value(430) = 4 ' Word Count
		  bin.UInt32Value(432) = 7 ' result id
		  bin.UInt32Value(436) = 4 ' storage class
		  bin.UInt32Value(440) = 6 ' type id
		  
		  ' 8: TypeFunction 5 7(ptr) 7(ptr) 7(ptr)
		  bin.UInt16Value(444) = 21 ' OpTypeFunction
		  bin.UInt16Value(446) = 3 + 3 ' Count
		  bin.UInt32Value(448) = 8 ' result id
		  bin.UInt32Value(452) = 5 ' return type id
		  bin.UInt32Value(456) = 7 ' parameter 0 type
		  bin.UInt32Value(460) = 7 ' parameter 1 type
		  bin.UInt32Value(464) = 7 ' parameter 2 type
		  
		  ' 4(LocalInvocationId): 3(ptr) Variable UniformConstant
		  bin.UInt16Value(468) = 38 ' OpVariable
		  bin.UInt16Value(470) = 4 + 0 ' Word Count
		  bin.UInt32Value(472) = 3 ' result type id
		  bin.UInt32Value(476) = 4 ' result id
		  bin.UInt16Value(480) = 0 ' storage class
		  
		  ' 9(add): 5 Function NoControl 8
		  bin.UInt16Value(484) = 40 ' OpFunction
		  bin.UInt16Value(486) = 5 ' Word Count
		  bin.UInt32Value(488) = 5 ' result type id = void
		  bin.UInt32Value(492) = 9 ' result id
		  bin.UInt32Value(496) = 0 ' function control mask
		  bin.UInt32Value(500) = 8 ' function type id
		  
		  ' 10(in1): 7(ptr) FunctionParameter
		  bin.UInt16Value(504) = 41 ' OpFunctionParameter
		  bin.UInt16Value(506) = 3 ' Word Count
		  bin.UInt32Value(508) = 7 ' result type id
		  bin.UInt32Value(512) = 10 ' result id
		  
		  ' 11(in2): 7(ptr) FunctionParameter
		  bin.UInt16Value(516) = 41 ' OpFunctionParameter
		  bin.UInt16Value(518) = 3 ' Word Count
		  bin.UInt32Value(520) = 7 ' result type id
		  bin.UInt32Value(524) = 11 ' result id
		  
		  ' 12(out): 7(ptr) FunctionParameter
		  bin.UInt16Value(528) = 41 ' OpFunctionParameter
		  bin.UInt16Value(530) = 3 ' Word Count
		  bin.UInt32Value(532) = 7 ' result type id
		  bin.UInt32Value(536) = 12 ' result id
		  
		  ' 13(entry): Label
		  bin.UInt16Value(540) = 208 ' OpFunctionParameter
		  bin.UInt16Value(542) = 2 ' Word Count
		  bin.UInt32Value(544) = 13 ' result id
		  
		  ' 14: 2(ivec3) Load 4(LocalInvocationId)
		  bin.UInt16Value(548) = 46 ' OpLoad
		  bin.UInt16Value(550) = 4 + 0 ' Word Count
		  bin.UInt32Value(552) = 2 ' result type id
		  bin.UInt32Value(556) = 14 ' result id
		  bin.UInt32Value(560) = 4 ' pointer id
		  
		  ' 15(call): 1(int) CompositeExtract 14 0
		  bin.UInt16Value(564) = 62 ' OpCompositeExtract
		  bin.UInt16Value(566) = 4 + 1 ' Word Count
		  bin.UInt32Value(568) = 1 ' result type id
		  bin.UInt32Value(572) = 15 ' result id
		  bin.UInt32Value(576) = 14 ' composite id
		  bin.UInt32Value(580) = 0 ' index
		  
		  ' 16(arrayidx): 7(ptr) InBoundsAccessChain 10(in1) 15(call)
		  bin.UInt16Value(584) = 94 ' OpInBoundsAccessChain
		  bin.UInt16Value(586) = 4 + 1 ' Word Count
		  bin.UInt32Value(588) = 7 ' result type id
		  bin.UInt32Value(592) = 16 ' result id
		  bin.UInt32Value(596) = 10 ' base id
		  bin.UInt32Value(600) = 15 ' index id
		  
		  ' 17: 6(int) Load 16(arrayidx)
		  bin.UInt16Value(604) = 46 ' OpLoad
		  bin.UInt16Value(606) = 4 + 0 ' Word Count
		  bin.UInt32Value(608) = 6 ' result type id
		  bin.UInt32Value(612) = 17 ' result id
		  bin.UInt32Value(616) = 16 ' pointer id
		  
		  ' 18(arrayidx1): 7(ptr) InBoundsAccessChain 11(in2) 15(call)
		  bin.UInt16Value(620) = 94 ' OpInBoundsAccessChain
		  bin.UInt16Value(622) = 4 + 1 ' Word Count
		  bin.UInt32Value(624) = 7 ' result type id
		  bin.UInt32Value(628) = 18 ' result id
		  bin.UInt32Value(632) = 11 ' base id
		  bin.UInt32Value(636) = 15 ' index id
		  
		  ' 19: 6(int) Load 18(arrayidx1)
		  bin.UInt16Value(640) = 46 ' OpLoad
		  bin.UInt16Value(642) = 4 + 0 ' Word Count
		  bin.UInt32Value(644) = 6 ' result type id
		  bin.UInt32Value(648) = 19 ' result id
		  bin.UInt32Value(652) = 18 ' pointer id
		  
		  ' 20(add): 6(int) IAdd 19 17
		  bin.UInt16Value(656) = 122 ' OpIAdd
		  bin.UInt16Value(658) = 5 ' Word Count
		  bin.UInt32Value(660) = 6 ' result type id
		  bin.UInt32Value(664) = 20 ' result id
		  bin.UInt32Value(668) = 19 ' operand id 1
		  bin.UInt32Value(672) = 17 ' operand id 2
		  
		  ' 21(arrayidx2): 7(ptr) InBoundsAccessChain 12(out) 15(call)
		  bin.UInt16Value(676) = 94 ' OpInBoundsAccessChain
		  bin.UInt16Value(678) = 4 + 1 ' Word Count
		  bin.UInt32Value(682) = 7 ' result type id
		  bin.UInt32Value(684) = 21 ' result id
		  bin.UInt32Value(688) = 12 ' base id
		  bin.UInt32Value(692) = 15 ' index id
		  
		  ' Store 22 21(arrayidx2) 20 ???? <<< CHECK THIS OPCODE
		  bin.UInt16Value(696) = 47 ' OpStore
		  bin.UInt16Value(698) = 3 + 0 ' Word Count
		  bin.UInt32Value(700) = 22 ' pointer id
		  bin.UInt32Value(704) = 21 ' object id
		  
		  ' Return
		  bin.UInt16Value(708) = 213 ' OpReturn
		  bin.UInt16Value(710) = 1 ' Word Count
		  
		  ' FunctionEnd
		  bin.UInt16Value(712) = 42 ' OpFunctionEnd
		  bin.UInt16Value(714) = 1 ' Word Count
		  
		  Dim f As FolderItem = App.ExecutableFile.Parent.Child("test_001.spirv")
		  Dim stream As BinaryStream
		  stream = BinaryStream.Create(f, True) // Overwrite if exists
		  stream.Write bin
		  stream.Close
		  
		  return bin
		  
		End Function
	#tag EndMethod


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
