#tag Module
Protected Module SPIRV
	#tag Method, Flags = &h0
		Function SPIRVDescribeAccessQualifier(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "ReadOnly"
		  case 1
		    result = "WriteOnly"
		  case 2
		    result = "ReadWrite"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeAddressingModel(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		Function SPIRVDescribeArrayed(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "NonArrayed"
		  case 1
		    result = "Arrayed"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeBuiltIn(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		Function SPIRVDescribeCompare(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "NoDepthComparisons"
		  case 1
		    result = "DepthComparisons"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeContent(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Texture"
		  case 1
		    result = "Image"
		  case 2
		    result = "TextureAndFilter"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeDecoration(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		Function SPIRVDescribeDimensionality(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "1D"
		  case 1
		    result = "2D"
		  case 2
		    result = "3D"
		  case 3
		    result = "Cube"
		  case 4
		    result = "Rect"
		  case 5
		    result = "Buffer"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeExecutionMode(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Invocations"
		  case 1
		    result = "SpacingEqual"
		  case 2
		    result = "SpacingFractionalEven"
		  case 3
		    result = "SpacingFractionalOdd"
		  case 4
		    result = "VertexOrderCw"
		  case 5
		    result = "VertexOrderCcw"
		  case 6
		    result = "PixelCenterInteger"
		  case 7
		    result = "OriginUpperLeft"
		  case 8
		    result = "EarlyFragmentTests"
		  case 9
		    result = "PointMode"
		  case 10
		    result = "Xfb"
		  case 11
		    result = "DepthReplacing"
		  case 12
		    result = "DepthAny"
		  case 13
		    result = "DepthGreater"
		  case 14
		    result = "DepthLess"
		  case 15
		    result = "DepthUnchanged"
		  case 16
		    result = "LocalSize"
		  case 17
		    result = "LocalSizeHint"
		  case 18
		    result = "InputPoints"
		  case 19
		    result = "InputLines"
		  case 20
		    result = "InputLinesAdjacency"
		  case 21
		    result = "InputTriangles"
		  case 22
		    result = "InputTrianglesAdjacency"
		  case 23
		    result = "InputQuads"
		  case 24
		    result = "InputIsolines"
		  case 25
		    result = "OutputVertices"
		  case 26
		    result = "OutputPoints"
		  case 27
		    result = "OutputLineStrip"
		  case 28
		    result = "OutputTriangleStrip"
		  case 29
		    result = "VecTypeHint"
		  case 30
		    result = "ContractionOff"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeExecutionModel(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		Function SPIRVDescribeExecutionScope(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "CorssDevice"
		  case 1
		    result = "Device"
		  case 2
		    result = "Workgroup"
		  case 3
		    result = "Subgroup"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeFPFastMathModeMask(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  // todo: This value is a mask; it can be formed by combining the bits from multiple rows in the table below.
		  
		  select case value
		  case &h00
		    result = "None"
		  case &h01
		    result = "NotNaN"
		  case &h02
		    result = "NotInf"
		  case &h04
		    result = "NSZ"
		  case &h08
		    result = "AllowRecip"
		  case &h10
		    result = "Fast"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeFPRoundingMode(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		Function SPIRVDescribeFunctionControlMask(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  // todo: formed by combining the bits from multiple rows in the table below
		  
		  select case value
		  case 0
		    result = "None"
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
		Function SPIRVDescribeFunctionParameterAttribute(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		Function SPIRVDescribeGroupOperation(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Reduce"
		  case 1
		    result = "InclusiveScan"
		  case 2
		    result = "ExclusiveScan"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeKernelEnqueueFlags(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "NoWait"
		  case 1
		    result = "WaitKernel"
		  case 2
		    result = "WaitWorkGroup"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeKernelProfilingInfoMask(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  // todo: This value is a mask; it can be formed by combining the bits from multiple rows in the table below.
		  
		  select case value
		  case &h00
		    result = "None"
		  case &h01
		    result = "CmdExecTime"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeLinkageType(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		Function SPIRVDescribeLoopControlMask(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  // todo: This value is a mask; it can be formed by combining the bits from multiple rows in the table below.
		  
		  select case value
		  case &h00
		    result = "None"
		  case &h01
		    result = "Unroll"
		  case &h002
		    result = "DontUnroll"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeMemoryAccessMask(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  // todo: This value is a mask; it can be formed by combining the bits from multiple rows in the table below.
		  
		  select case value
		  case &h00
		    result = "None"
		  case &h01
		    result = "Volatile"
		  case &h02
		    result = "Aligned"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeMemoryModel(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		Function SPIRVDescribeMemorySemantics(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  // todo: This value is a mask; it can be formed by combining the bits from multiple rows in the table below.
		  
		  select case value
		  case &h00
		    result = "None"
		  case &h01
		    result = "Relaxed"
		  case &h02
		    result = "SequentiallyConsistent"
		  case &h04
		    result = "Acquire"
		  case &h08
		    result = "Release"
		  case &h10
		    result = "UniformMemory"
		  case &h20
		    result = "SubgroupMemory"
		  case &h40
		    result = "WorkgroupLocalMemory"
		  case &h80
		    result = "WorkgroupGlobalMemory"
		  case &h100
		    result = "AtomicCounterMemory"
		  case &h200
		    result = "ImageMemory"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeMultisampled(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "SingleSampled"
		  case 1
		    result = "MultiSampled"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeParam(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Nonparametric"
		  case 1
		    result = "Parametric"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeSamplerAddressingMode(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "None"
		  case 1
		    result = "ClampEdge"
		  case 2
		    result = "Clamp"
		  case 3
		    result = "Repeat"
		  case 4
		    result = "RepeatMirrored"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeSamplerFilterMode(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  select case value
		  case 0
		    result = "Nearest"
		  case 1
		    result = "Linear"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeSelectionControlMask(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As String
		  
		  // todo: This value is a mask; it can be formed by combining the bits from multiple rows in the table below.
		  
		  select case value
		  case &h00
		    result = "None"
		  case &h01
		    result = "Flatten"
		  case &h02
		    result = "DontFlatten"
		  case else
		    result = "Unknown"
		  end select
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SPIRVDescribeSourceLanguage(value As UInt32) As String
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
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


	#tag Enum, Name = ConstantEnum, Type = Integer, Flags = &h0
		Unknown
		  Composite
		  Constant
		  BooleanFalse
		  BooleanTrue
		  Float
		  Integer
		  NullObject
		  NullPointer
		  Sampler
		  SpecBooleanTrue
		  SpecBooleanFalse
		  SpecComposite
		SpecConstant
	#tag EndEnum

	#tag Enum, Name = OpcodeEnum, Type = Integer, Flags = &h0
		Unknown
		  OpAccessChain
		  OpAll
		  OpAny
		  OpArrayLength
		  OpAsyncGroupCopy
		  OpAtomicAnd
		  OpAtomicCompareExchange
		  OpAtomicCompareExchangeWeak
		  OpAtomicExchange
		  OpAtomicIAdd
		  OpAtomicIDecrement
		  OpAtomicIIncrement
		  OpAtomicIMax
		  OpAtomicIMin
		  OpAtomicISub
		  OpAtomicInit
		  OpAtomicLoad
		  OpAtomicOr
		  OpAtomicStore
		  OpAtomicUMax
		  OpAtomicUMin
		  OpAtomicXor
		  OpBitcast
		  OpBitwiseAnd
		  OpBitwiseOr
		  OpBitwiseXor
		  OpBranch
		  OpBranchConditional
		  OpBuildNDRange
		  OpCaptureEventProfilingInfo
		  OpCommitReadPipe
		  OpCommitWritePipe
		  OpCompileFlag
		  OpCompositeConstruct
		  OpCompositeExtract
		  OpCompositeInsert
		  OpConstant
		  OpConstantFalse
		  OpConstantNullObject
		  OpConstantNullPointer
		  OpConstantSampler
		  OpConstantTrue
		  OpConstantComposite
		  OpControlBarrier
		  OpConvertFToU
		  OpConvertFToS
		  OpConvertPtrToU
		  OpConvertSToF
		  OpConvertUToF
		  OpConvertUToPtr
		  OpCopyMemory
		  OpCopyMemorySized
		  OpCopyObject
		  OpCreateUserEvent
		  OpDecorate
		  OpDecorationGroup
		  OpDot
		  OpDPdx
		  OpDPdxCoarse
		  OpDPdxFine
		  OpDPdy
		  OpDPdyCoarse
		  OpDPdyFine
		  OpEmitStreamVertex
		  OpEmitVertex
		  OpEndPrimitive
		  OpEndStreamPrimitive
		  OpEnqueueKernel
		  OpEnqueueMarker
		  OpEntryPoint
		  OpExecutionMode
		  OpExtension
		  OpExtInst
		  OpExtInstImport
		  OpFAdd
		  OpFConvert
		  OpFDiv
		  OpFMod
		  OpFMul
		  OpFNegate
		  OpFOrdEqual
		  OpFOrdGreaterThan
		  OpFOrdGreaterThanEqual
		  OpFOrdLessThan
		  OpFOrdLessThanEqual
		  OpFOrdNotEqual
		  OpFRem
		  OpFSub
		  OpFunction
		  OpFunctionCall
		  OpFunctionEnd
		  OpFunctionParameter
		  OpFUnordEqual
		  OpFUnordGreaterThan
		  OpFUnordGreaterThanEqual
		  OpFUnordLessThan
		  OpFUnordLessThanEqual
		  OpFUnordNotEqual
		  OpFwidth
		  OpFwidthCoarse
		  OpFwidthFine
		  OpGenericCastToPtr
		  OpGenericCastToPtrExplicit
		  OpGenericPtrMemSemantics
		  OpGetDefaultQueue
		  OpGetKernelNDrangeMaxSubGroupSize
		  OpGetKernelNDrangeSubGroupCount
		  OpGetKernelPreferredWorkGroupSizeMultiple
		  OpGetKernelWorkGroupSize
		  OpGetMaxPipePackets
		  OpGetNumPipePackets
		  OpGroupAll
		  OpGroupAny
		  OpGroupBroadcast
		  OpGroupCommitReadPipe
		  OpGroupCommitWritePipe
		  OpGroupDecorate
		  OpGroupFAdd
		  OpGroupFMax
		  OpGroupFMin
		  OpGroupIAdd
		  OpGroupMemberDecorate
		  OpGroupReserveReadPipePackets
		  OpGroupReserveWritePipePackets
		  OpGroupSMax
		  OpGroupSMin
		  OpGroupUMax
		  OpGroupUMin
		  OpIAdd
		  OpIEqual
		  OpImagePointer
		  OpIMul
		  OpINotEqual
		  OpInBoundsAccessChain
		  OpIsFinite
		  OpIsInf
		  OpIsNan
		  OpIsNormal
		  OpISub
		  OpIsValidEvent
		  OpIsValidReserveId
		  OpKill
		  OpLabel
		  OpLessOrGreater
		  OpLifetimeStart
		  OpLifetimeStop
		  OpLine
		  OpLoad
		  OpLogicalAnd
		  OpLogicalOr
		  OpLogicalXor
		  OpLoopMerge
		  OpMatrixTimesMatrix
		  OpMatrixTimesScalar
		  OpMatrixTimesVector
		  OpMemberDecorate
		  OpMemberName
		  OpMemoryBarrier
		  OpMemoryModel
		  OpName
		  OpNop
		  OpNot
		  OpOrdered
		  OpOuterProduct
		  OpPhi
		  OpPtrCastToGeneric
		  OpReadPipe
		  OpReleaseEvent
		  OpReservedReadPipe
		  OpReservedWritePipe
		  OpReserveReadPipePackets
		  OpReserveWritePipePackets
		  OpRetainEvent
		  OpReturn
		  OpReturnValue
		  OpSampler
		  OpSatConvertSToU
		  OpSatConvertUToS
		  OpSConvert
		  OpSDiv
		  OpSelect
		  OpSelectionMerge
		  OpSetUserEventStatus
		  OpShiftLeftLogical
		  OpShiftRightArithmetic
		  OpShiftRightLogical
		  OpSignBitSet
		  OpSGreaterThan
		  OpSGreaterThanEqual
		  OpSLessThan
		  OpSLessThanEqual
		  OpSNegate
		  OpSMod
		  OpSource
		  OpSourceExtension
		  OpSpecConstant
		  OpSpecConstantComposite
		  OpSpecConstantFalse
		  OpSpecConstantTrue
		  OpSRem
		  OpStore
		  OpString
		  OpSwitch
		  OpTextureFetchSample
		  OpTextureFetchTexel
		  OpTextureFetchTexelLod
		  OpTextureFetchTexelOffset
		  OpTextureGather
		  OpTextureGatherOffset
		  OpTextureGatherOffsets
		  OpTextureQueryLevels
		  OpTextureQueryLod
		  OpTextureQuerySamples
		  OpTextureQuerySize
		  OpTextureQuerySizeLod
		  OpTextureSample
		  OpTextureSampleDref
		  OpTextureSampleGrad
		  OpTextureSampleGradOffset
		  OpTextureSampleLod
		  OpTextureSampleLodOffset
		  OpTextureSampleOffset
		  OpTextureSampleProj
		  OpTextureSampleProjGrad
		  OpTextureSampleProjGradOffset
		  OpTextureSampleProjLod
		  OpTextureSampleProjLodOffset
		  OpTextureSampleProjOffset
		  OpTranspose
		  OpTypeArray
		  OpTypeBool
		  OpTypeDeviceEvent
		  OpTypeEvent
		  OpTypeFilter
		  OpTypeFloat
		  OpTypeFunction
		  OpTypeInt
		  OpTypeMatrix
		  OpTypeOpaque
		  OpTypePipe
		  OpTypePointer
		  OpTypeQueue
		  OpTypeReserveId
		  OpTypeRuntimeArray
		  OpTypeSampler
		  OpTypeStruct
		  OpTypeVector
		  OpTypeVoid
		  OpUConvert
		  OpUDiv
		  OpUGreaterThan
		  OpUGreaterThanEqual
		  OpULessThanEqual
		  OpULessThan
		  OpUMod
		  OpUndef
		  OpUnordered
		  OpUnreachable
		  OpVariable
		  OpVariableArray
		  OpVectorExtractDynamic
		  OpVectorInsertDynamic
		  OpVectorShuffle
		  OpVectorTimesMatrix
		  OpVectorTimesScalar
		  OpWaitGroupEvents
		OpWritePipe
	#tag EndEnum

	#tag Enum, Name = TypeEnum, Type = Integer, Flags = &h0
		Array_
		  Boolean
		  DeviceEvent
		  Event_
		  Filter
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
