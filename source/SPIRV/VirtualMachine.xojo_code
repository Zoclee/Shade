#tag Class
Protected Class VirtualMachine
	#tag Method, Flags = &h0
		Sub Clear()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  AddressingModel = 2 // Phyical64
		  Bound = 0
		  Constants = new Dictionary()
		  Redim Decorations(-1)
		  EntryPoints = new Dictionary()
		  Redim Errors(-1)
		  Functions = new Dictionary()
		  GeneratorMagicNumber = 0
		  MemoryModel = 0 // Simple
		  Names = new Dictionary()
		  OpcodeLookup = new Dictionary()
		  Redim Opcodes(-1)
		  SourceLanguage = 0 // Unknown
		  SourceVersion = 0
		  Types = new Dictionary()
		  Version = 99
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadModule(binary As MemoryBlock)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim ip As UInt32
		  Dim moduleUB As Integer
		  Dim tempIP As UInt32
		  Dim ub As UInt32
		  Dim ep As SPIRV.EntryPoint
		  Dim dec As SPIRV.Decoration
		  Dim typ As SPIRV.SPIRVType
		  Dim op As SPIRV.Opcode
		  Dim cnst As SPIRV.Constant
		  
		  Clear()
		  
		  if binary <> nil then
		    
		    ModuleBinary = binary
		    
		    // test magic number
		    
		    if ModuleBinary.UInt32Value(0) <> &h07230203 then
		      
		      Errors.Append "Invalid magic number."
		      
		    else
		      
		      Version = ModuleBinary.UInt32Value(4)
		      GeneratorMagicNumber = ModuleBinary.UInt32Value(8)
		      Bound = ModuleBinary.UInt32Value(12)
		      moduleUB = ModuleBinary.Size - 1
		      
		      //  instructions
		      
		      ip = 20
		      while ip < moduleUB
		        
		        select case ModuleBinary.UInt16Value(ip)
		          
		        case 0 // ***** OpNop ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpNop)
		          
		        case 1 // ***** OpSource ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSource)
		          SourceLanguage = ModuleBinary.UInt32Value(ip + 4)
		          SourceVersion = ModuleBinary.UInt32Value(ip + 8)
		          
		        case 2 // ***** OpSourceExtension ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSourceExtension)
		          
		        case 3 // ***** OpExtension ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpExtension)
		          
		        case 4 // ***** OpExtInstImport ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpExtInstImport)
		          
		        case 5 // ***** OpMemoryModel ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpMemoryModel)
		          AddressingModel = ModuleBinary.UInt32Value(ip + 4)
		          MemoryModel = ModuleBinary.UInt32Value(ip + 8)
		          
		        case 6 // ***** OpEntryPoint ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpEntryPoint)
		          ep = new SPIRV.EntryPoint
		          ep.ExecutionModel = ModuleBinary.UInt32Value(ip + 4)
		          ep.EntryPointID = ModuleBinary.UInt32Value(ip + 8)
		          EntryPoints.Value(ep.EntryPointID) = ep
		          
		        case 7 // ***** OpExecutionMode ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpExecutionMode)
		          
		        case 8 // ***** OpTypeVoid ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeVoid)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Void
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 9 // ***** OpTypeBool ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeBool)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Boolean
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 10 // ***** OpTypeInt ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeInt)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Integer
		          typ.Width = ModuleBinary.UInt32Value(ip + 8)
		          if ModuleBinary.UInt32Value(ip + 12) = 0 then
		            typ.Signed = false
		          else
		            typ.Signed = true
		          end if
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 11 // ***** OpTypeFloat ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeFloat)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Float
		          typ.Width = ModuleBinary.UInt32Value(ip + 8)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 12 // ***** OpTypeVector ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeVector)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Vector
		          typ.ComponentTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.ComponentCount = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 13 // ***** OpTypeMatrix ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeMatrix)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Matrix
		          typ.ColumnTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.ColumnCount = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 14 // ***** OpTypeSampler ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeSampler)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Sampler
		          typ.SampledTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.Dimensionality = ModuleBinary.UInt32Value(ip + 12)
		          typ.Content = ModuleBinary.UInt32Value(ip + 16)
		          typ.Arrayed = ModuleBinary.UInt32Value(ip + 20)
		          typ.Compare = ModuleBinary.UInt32Value(ip + 24)
		          typ.Multisampled = ModuleBinary.UInt32Value(ip + 28)
		          if ModuleBinary.UInt16Value(ip + 2) >= 9 then
		            typ.AccessQualifier = ModuleBinary.UInt32Value(ip + 32)
		          else
		            typ.AccessQualifier = 0
		          end if
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 15 // ***** OpTypeFilter ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeFilter)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Filter
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 16 // ***** OpTypeArray ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeArray)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Array_
		          typ.ElementTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.Length = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 17 // ***** OpTypeRuntimeArray ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeRuntimeArray)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.RuntimeArray
		          typ.ElementTypeID = ModuleBinary.UInt32Value(ip + 8)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 18 // ***** OpTypeStruct ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeStruct)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Struct
		          tempIP = ip + 8
		          ub = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		          while tempIP < ub
		            typ.MemberTypeID.Append ModuleBinary.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 19 // ***** OpTypeOpaque ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeOpaque)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Opaque
		          typ.Name = ModuleBinary.CString(ip + 8)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 20 // ***** OpTypePointer ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypePointer)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Pointer
		          typ.StorageClass = ModuleBinary.UInt32Value(ip + 8)
		          typ.TypeID = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 21 // ***** OpTypeFunction ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeFunction)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Function_
		          typ.ReturnTypeID = ModuleBinary.UInt32Value(ip + 8)
		          tempIP = ip + 12
		          ub = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		          while tempIP < ub
		            typ.ParmTypeID.Append ModuleBinary.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 22 // ***** OpTypeEvent ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeEvent)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Event_
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 23 // ***** OpTypeDeviceEvent ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeDeviceEvent)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.DeviceEvent
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 24 // ***** OpTypeReserveId ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeReserveId)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.ReservedId
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 25 // ***** OpTypeQueue ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypeQueue)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Queue
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 26 // ***** OpTypePipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTypePipe)
		          typ = new SPIRV.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRV.TypeEnum.Pipe
		          typ.DataTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.AccessQualifier = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 27 // ***** OpConstantTrue ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConstantTrue)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.BooleanTrue
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 28 // ***** OpConstantFalse ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConstantFalse)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.BooleanFalse
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 29 // ***** OpConstant ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConstant)
		          
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.Constant
		          if Types.HasKey(ModuleBinary.UInt32Value(ip + 4)) then
		            typ = Types.Value(ModuleBinary.UInt32Value(ip + 4))
		            select case typ.Type
		            case SPIRV.TypeEnum.Float
		              cnst.Type = SPIRVConstantType.Float
		            case SPIRV.TypeEnum.Integer
		              cnst.Type = SPIRVConstantType.Integer
		            end select
		          end if
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 30 // ***** OpConstantComposite ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConstantComposite)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.Composite
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          tempIP = ip + 12
		          ub = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		          while tempIP < ub
		            cnst.Constituents.Append ModuleBinary.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 31 // ***** OpConstantSampler ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConstantSampler)
		          cnst = new SPIRV.Constant
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          cnst.Mode = ModuleBinary.UInt32Value(ip + 12)
		          cnst.Param = ModuleBinary.UInt32Value(ip + 16)
		          cnst.Filter = ModuleBinary.UInt32Value(ip + 20)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 32 // ***** OpConstantNullPointer ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConstantNullPointer)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.NullPointer
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 33 // ***** OpConstantNullObject ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConstantNullObject)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.NullObject
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 34 // ***** OpSpecConstantTrue ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSpecConstantTrue)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.SpecBooleanTrue
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 35 // ***** OpSpecConstantFalse ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSpecConstantFalse)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.SpecBooleanFalse
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 36 // ***** OpSpecConstant ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSpecConstant)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.SpecConstant
		          if Types.HasKey(ModuleBinary.UInt32Value(ip + 4)) then
		            typ = Types.Value(ModuleBinary.UInt32Value(ip + 4))
		            select case typ.Type
		            case SPIRV.TypeEnum.Float
		              cnst.Type = SPIRVConstantType.Float
		            case SPIRV.TypeEnum.Integer
		              cnst.Type = SPIRVConstantType.Integer
		            end select
		          end if
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 37 // ***** OpSpecConstantComposite ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSpecConstantComposite)
		          cnst = new SPIRV.Constant
		          cnst.Type = SPIRVConstantType.SpecComposite
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          tempIP = ip + 12
		          ub = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		          while tempIP < ub
		            cnst.Constituents.Append ModuleBinary.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 38 // ***** OpVariable ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpVariable)
		          
		        case 39 // ***** OpVariableArray ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpVariableArray)
		          
		        case 40 // ***** OpFunction ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFunction)
		          Functions.Value(ModuleBinary.UInt32Value(ip + 8)) = op
		          
		        case 41 // ***** OpFunctionParameter ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFunctionParameter)
		          
		        case 42 // ***** OpFunctionEnd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFunctionEnd)
		          
		        case 43 // ***** OpFunctionCall ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFunctionCall)
		          
		        case 44 // ***** OpExtInst ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpExtInst)
		          
		        case 45 // ***** OpUndef ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpUndef)
		          
		        case 46 // ***** OpLoad ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLoad)
		          
		        case 47 // ***** OpStore ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpStore)
		          
		        case 48 // ***** OpPhi ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpPhi)
		          
		        case 49 // ***** OpDecorationGroup ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDecorationGroup)
		          
		        case 50 // ***** OpDecorate ***************************************************
		          
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDecorate)
		          dec = new SPIRV.Decoration
		          dec.TargetID = ModuleBinary.UInt32Value(ip + 4)
		          dec.Decoration = ModuleBinary.UInt32Value(ip + 8)
		          select case dec.Decoration
		            ' Stream, Location, Component, Index, Binding, DescriptorSet, Offset, Alignment, XfbBuffer, Stride,
		            ' Built-In, FuncParamAttr, FP Rouding Mode, FP Fast Math Mode, Linkage Type, SpecId
		          case 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44
		            tempIP = ip + 12
		            ub = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		            while tempIP < ub
		              dec.ExtraOperands.Append ModuleBinary.UInt32Value(tempIP)
		              tempIP = tempIP + 4
		            wend
		          end select
		          Decorations.Append dec
		          
		        case 51 // ***** OpMemberDecorate ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpMemberDecorate)
		          
		        case 52 // ***** OpGroupDecorate ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupDecorate)
		          
		        case 53 // ***** OpGroupMemberDecorate ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupMemberDecorate)
		          
		        case 54 // ***** OpName ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpName)
		          Names.Value(ModuleBinary.UInt32Value(ip + 4)) = ModuleBinary.CString(ip + 8)
		          
		        case 55 // ***** OpMemberName ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpMemberName)
		          
		        case 56 // ***** OpString ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpString)
		          
		        case 57 // ***** OpLine ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLine)
		          
		        case 58 // ***** OpVectorExtractDynamic ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpVectorExtractDynamic)
		          
		        case 59 // ***** OpVectorInsertDynamic ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpVectorInsertDynamic)
		          
		        case 60 // ***** OpVectorShuffle ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpVectorShuffle)
		          
		        case 61 // ***** OpCompositeConstruct ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCompositeConstruct)
		          
		        case 62 // ***** OpCompositeExtract ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCompositeExtract)
		          
		        case 63 // ***** OpCompositeInsert ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCompositeInsert)
		          
		        case 64 // ***** OpCopyObject ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCopyObject)
		          
		        case 65 // ***** OpCopyMemory ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCopyMemory)
		          
		        case 66 // ***** OpCopyMemorySized ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCopyMemorySized)
		          
		        case 67 // ***** OpSampler ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSampler)
		          
		        case 68 // ***** OpTextureSample ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSample)
		          
		        case 69 // ***** OpTextureSampleDref ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleDref)
		          
		        case 70 // ***** OpTextureSampleLod ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleLod)
		          
		        case 71 // ***** OpTextureSampleProj ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleProj)
		          
		        case 72 // ***** OpTextureSampleGrad ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleGrad)
		          
		        case 73 // ***** OpTextureSampleOffset ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleOffset)
		          
		        case 74 // ***** OpTextureSampleProjGrad ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleProjGrad)
		          
		        case 75 // ***** OpTextureSampleProjLod ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleProjLod)
		          
		        case 76 // ***** OpTextureSampleLodOffset ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleLodOffset)
		          
		        case 77 // ***** OpTextureSampleProjOffset ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleProjOffset)
		          
		        case 78 // ***** OpTextureSampleGradOffset ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleGradOffset)
		          
		        case 79 // ***** OpTextureSampleProjLodOffset ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleProjLodOffset)
		          
		        case 80 // ***** OpTextureSampleProjGradOffset ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureSampleProjGradOffset)
		          
		        case 81 // ***** OpTextureFetchTexelLod ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureFetchTexelLod)
		          
		        case 82 // ***** OpTextureFetchTexelOffset ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureFetchTexelOffset)
		          
		        case 83 // ***** OpTextureFetchSample ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureFetchSample)
		          
		        case 84 // ***** OpTextureFetchTexel ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureFetchTexel)
		          
		        case 85 // ***** OpTextureGather ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureGather)
		          
		        case 86 // ***** OpTextureGatherOffset ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureGatherOffset)
		          
		        case 87 // ***** OpTextureGatherOffsets ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureGatherOffsets)
		          
		        case 88 // ***** OpTextureQuerySizeLod ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureQuerySizeLod)
		          
		        case 89 // ***** OpTextureQuerySize ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureQuerySize)
		          
		        case 90 // ***** OpTextureQueryLod ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureQueryLod)
		          
		        case 91 // ***** OpTextureQueryLevels ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureQueryLevels)
		          
		        case 92 // ***** OpTextureQuerySamples ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTextureQuerySamples)
		          
		        case 93 // ***** OpAccessChain ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAccessChain)
		          
		        case 94 // ***** OpInBoundsAccessChain ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpInBoundsAccessChain)
		          
		        case 95 // ***** OpSNegate ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSNegate)
		          
		        case 96 // ***** OpFNegate ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFNegate)
		          
		        case 97 // ***** OpNot ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpNot)
		          
		        case 98 // ***** OpAny ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAny)
		          
		        case 99 // ***** OpAll ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAll)
		          
		        case 100 // ***** OpConvertFToU ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConvertFToU)
		          
		        case 101 // ***** OpConvertFToS ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConvertFToS)
		          
		        case 102 // ***** OpConvertSToF ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConvertSToF)
		          
		        case 103 // ***** OpConvertUToF ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConvertUToF)
		          
		        case 104 // ***** OpUConvert ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpUConvert)
		          
		        case 105 // ***** OpSConvert ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSConvert)
		          
		        case 106 // ***** OpFConvert ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFConvert)
		          
		        case 107 // ***** OpConvertPtrToU ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConvertPtrToU)
		          
		        case 108 // ***** OpConvertUToPtr ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpConvertUToPtr)
		          
		        case 109 // ***** OpPtrCastToGeneric ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpPtrCastToGeneric)
		          
		        case 110 // ***** OpGenericCastToPtr ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGenericCastToPtr)
		          
		        case 111 // ***** OpBitcast ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpBitcast)
		          
		        case 112 // ***** OpTranspose ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpTranspose)
		          
		        case 113 // ***** OpIsNan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIsNan)
		          
		        case 114 // ***** OpIsInf ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIsInf)
		          
		        case 115 // ***** OpIsFinite ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIsFinite)
		          
		        case 116 // ***** OpIsNormal ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIsNormal)
		          
		        case 117 // ***** OpSignBitSet ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSignBitSet)
		          
		        case 118 // ***** OpLessOrGreater ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLessOrGreater)
		          
		        case 119 // ***** OpOrdered ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpOrdered)
		          
		        case 120 // ***** OpUnordered ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpUnordered)
		          
		        case 121 // ***** OpArrayLength ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpArrayLength)
		          
		        case 122 // ***** OpIAdd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIAdd)
		          
		        case 123 // ***** OpFAdd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFAdd)
		          
		        case 124 // ***** OpISub ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpISub)
		          
		        case 125 // ***** OpFSub ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFSub)
		          
		        case 126 // ***** OpIMul ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIMul)
		          
		        case 127 // ***** OpFMul ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFMul)
		          
		        case 128 // ***** OpUDiv ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpUDiv)
		          
		        case 129 // ***** OpSDiv ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSDiv)
		          
		        case 130 // ***** OpFDiv ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFDiv)
		          
		        case 131 // ***** OpUMod ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpUMod)
		          
		        case 132 // ***** OpSRem ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSRem)
		          
		        case 133 // ***** OpSMod ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSMod)
		          
		        case 134 // ***** OpFRem ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFRem)
		          
		        case 135 // ***** OpFMul ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFMul)
		          
		        case 136 // ***** OpVectorTimesScalar ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpVectorTimesScalar)
		          
		        case 137 // ***** OpMatrixTimesScalar ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpMatrixTimesScalar)
		          
		        case 138 // ***** OpVectorTimesMatrix ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpVectorTimesMatrix)
		          
		        case 139 // ***** OpMatrixTimesVector ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpMatrixTimesVector)
		          
		        case 140 // ***** OpMatrixTimesMatrix ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpMatrixTimesMatrix)
		          
		        case 141 // ***** OpOuterProduct ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpOuterProduct)
		          
		        case 142 // ***** OpDot ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDot)
		          
		        case 143 // ***** OpShiftRightLogical ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpShiftRightLogical)
		          
		        case 144 // ***** OpShiftRightArithmetic ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpShiftRightArithmetic)
		          
		        case 145 // ***** OpShiftLeftLogical ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpShiftLeftLogical)
		          
		        case 146 // ***** OpLogicalOr ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLogicalOr)
		          
		        case 147 // ***** OpLogicalXor ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLogicalXor)
		          
		        case 148 // ***** OpLogicalAnd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLogicalAnd)
		          
		        case 149 // ***** OpBitwiseOr ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpBitwiseOr)
		          
		        case 150 // ***** OpBitwiseXor ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpBitwiseXor)
		          
		        case 151 // ***** OpBitwiseAnd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpBitwiseAnd)
		          
		        case 152 // ***** OpSelect ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSelect)
		          
		        case 153 // ***** OpIEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIEqual)
		          
		        case 154 // ***** OpFOrdEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFOrdEqual)
		          
		        case 155 // ***** OpFUnordEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFUnordEqual)
		          
		        case 156 // ***** OpINotEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpINotEqual)
		          
		        case 157 // ***** OpFOrdNotEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFOrdNotEqual)
		          
		        case 158 // ***** OpFUnordNotEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFUnordNotEqual)
		          
		        case 159 // ***** OpULessThan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpULessThan)
		          
		        case 160 // ***** OpSLessThan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSLessThan)
		          
		        case 161 // ***** OpFOrdLessThan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFOrdLessThan)
		          
		        case 162 // ***** OpFUnordLessThan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFUnordLessThan)
		          
		        case 163 // ***** OpUGreaterThan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpUGreaterThan)
		          
		        case 164 // ***** OpSGreaterThan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSGreaterThan)
		          
		        case 165 // ***** OpFOrdGreaterThan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFOrdGreaterThan)
		          
		        case 166 // ***** OpFUnordGreaterThan ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFUnordGreaterThan)
		          
		        case 167 // ***** OpULessThanEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpULessThanEqual)
		          
		        case 168 // ***** OpSLessThanEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSLessThanEqual)
		          
		        case 169 // ***** OpFOrdLessThanEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFOrdLessThanEqual)
		          
		        case 170 // ***** OpFUnordLessThanEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFUnordLessThanEqual)
		          
		        case 171 // ***** OpUGreaterThanEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpUGreaterThanEqual)
		          
		        case 172 // ***** OpSGreaterThanEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSGreaterThanEqual)
		          
		        case 173 // ***** OpFOrdGreaterThanEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFOrdGreaterThanEqual)
		          
		        case 174 // ***** OpFUnordGreaterThanEqual ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFUnordGreaterThanEqual)
		          
		        case 175 // ***** OpDPdx ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDPdx)
		          
		        case 176 // ***** OpDPdy ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDPdy)
		          
		        case 177 // ***** OpFwidth ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFwidth)
		          
		        case 178 // ***** OpDPdxFine ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDPdxFine)
		          
		        case 179 // ***** OpDPdyFine ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDPdyFine)
		          
		        case 180 // ***** OpFwidthFine ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFwidthFine)
		          
		        case 181 // ***** OpDPdxCoarse ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDPdxCoarse)
		          
		        case 182 // ***** OpDPdyCoarse ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpDPdyCoarse)
		          
		        case 183 // ***** OpFwidthCoarse ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpFwidthCoarse)
		          
		        case 184 // ***** OpEmitVertex ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpEmitVertex)
		          
		        case 185 // ***** OpEndPrimitive ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpEndPrimitive)
		          
		        case 186 // ***** OpEmitStreamVertex ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpEmitStreamVertex)
		          
		        case 187 // ***** OpEndStreamPrimitive ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpEndStreamPrimitive)
		          
		        case 188 // ***** OpControlBarrier ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpControlBarrier)
		          
		        case 189 // ***** OpMemoryBarrier ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpMemoryBarrier)
		          
		        case 190 // ***** OpImagePointer ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpImagePointer)
		          
		        case 191 // ***** OpAtomicInit ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicInit)
		          
		        case 192 // ***** OpAtomicLoad ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicLoad)
		          
		        case 193 // ***** OpAtomicStore ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicStore)
		          
		        case 194 // ***** OpAtomicExchange ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicExchange)
		          
		        case 195 // ***** OpAtomicCompareExchange ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicCompareExchange)
		          
		        case 196 // ***** OpAtomicCompareExchangeWeak ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicCompareExchangeWeak)
		          
		        case 197 // ***** OpAtomicIIncrement ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicIIncrement)
		          
		        case 198 // ***** OpAtomicIDecrement ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicIDecrement)
		          
		        case 199 // ***** OpAtomicIAdd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicIAdd)
		          
		        case 200 // ***** OpAtomicISub ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicISub)
		          
		        case 201 // ***** OpAtomicUMin ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicUMin)
		          
		        case 202 // ***** OpAtomicUMax ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicUMax)
		          
		        case 203 // ***** OpAtomicAnd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicAnd)
		          
		        case 204 // ***** OpAtomicOr ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicOr)
		          
		        case 205 // ***** OpAtomicXor ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicXor)
		          
		        case 206 // ***** OpLoopMerge ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLoopMerge)
		          
		        case 207 // ***** OpSelectionMerge ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSelectionMerge)
		          
		        case 208 // ***** OpLabel ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLabel)
		          
		        case 209 // ***** OpBranch ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpBranch)
		          
		        case 210 // ***** OpBranchConditional ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpBranchConditional)
		          
		        case 211 // ***** OpSwitch ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSwitch)
		          
		        case 212 // ***** OpKill ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpKill)
		          
		        case 213 // ***** OpReturn ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpReturn)
		          
		        case 214 // ***** OpReturnValue ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpReturnValue)
		          
		        case 215 // ***** OpUnreachable ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpUnreachable)
		          
		        case 216 // ***** OpLifetimeStart ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLifetimeStart)
		          
		        case 217 // ***** OpLifetimeStop ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpLifetimeStop)
		          
		        case 218 // ***** OpCompileFlag ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCompileFlag)
		          
		        case 219 // ***** OpAsyncGroupCopy ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAsyncGroupCopy)
		          
		        case 220 // ***** OpWaitGroupEvents ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpWaitGroupEvents)
		          
		        case 221 // ***** OpGroupAll ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupAll)
		          
		        case 222 // ***** OpGroupAny ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupAny)
		          
		        case 223 // ***** OpGroupBroadcast ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupBroadcast)
		          
		        case 224 // ***** OpGroupIAdd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupIAdd)
		          
		        case 225 // ***** OpGroupFAdd ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupFAdd)
		          
		        case 226 // ***** OpGroupFMin ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupFMin)
		          
		        case 227 // ***** OpGroupUMin ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupUMin)
		          
		        case 228 // ***** OpGroupSMin ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupSMin)
		          
		        case 229 // ***** OpGroupFMax ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupFMax)
		          
		        case 230 // ***** OpGroupUMax ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupUMax)
		          
		        case 231 // ***** OpGroupSMax ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupSMax)
		          
		        case 232 // ***** OpGenericCastToPtrExplicit ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGenericCastToPtrExplicit)
		          
		        case 233 // ***** OpGenericPtrMemSemantics ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGenericPtrMemSemantics)
		          
		        case 234 // ***** OpReadPipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpReadPipe)
		          
		        case 235 // ***** OpWritePipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpWritePipe)
		          
		        case 236 // ***** OpReservedReadPipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpReservedReadPipe)
		          
		        case 237 // ***** OpReservedWritePipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpReservedWritePipe)
		          
		        case 238 // ***** OpReserveReadPipePackets ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpReserveReadPipePackets)
		          
		        case 239 // ***** OpReserveWritePipePackets ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpReserveWritePipePackets)
		          
		        case 240 // ***** OpCommitReadPipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCommitReadPipe)
		          
		        case 241 // ***** OpCommitWritePipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCommitWritePipe)
		          
		        case 242 // ***** OpIsValidReserveId ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIsValidReserveId)
		          
		        case 243 // ***** OpGetNumPipePackets ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGetNumPipePackets)
		          
		        case 244 // ***** OpGetMaxPipePackets ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGetMaxPipePackets)
		          
		        case 245 // ***** OpGroupReserveReadPipePackets ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupReserveReadPipePackets)
		          
		        case 246 // ***** OpGroupReserveWritePipePackets ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupReserveWritePipePackets)
		          
		        case 247 // ***** OpGroupCommitReadPipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupCommitReadPipe)
		          
		        case 248 // ***** OpGroupCommitWritePipe ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGroupCommitWritePipe)
		          
		        case 249 // ***** OpEnqueueMarker ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpEnqueueMarker)
		          
		        case 250 // ***** OpEnqueueKernel ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpEnqueueKernel)
		          
		        case 251 // ***** OpGetKernelNDrangeSubGroupCount ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGetKernelNDrangeSubGroupCount)
		          
		        case 252 // ***** OpGetKernelNDrangeMaxSubGroupSize ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGetKernelNDrangeMaxSubGroupSize)
		          
		        case 253 // ***** OpGetKernelWorkGroupSize ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGetKernelWorkGroupSize)
		          
		        case 254 // ***** OpGetKernelPreferredWorkGroupSizeMultiple ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGetKernelPreferredWorkGroupSizeMultiple)
		          
		        case 255 // ***** OpRetainEvent ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpRetainEvent)
		          
		        case 256 // ***** OpReleaseEvent ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpReleaseEvent)
		          
		        case 257 // ***** OpCreateUserEvent ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCreateUserEvent)
		          
		        case 258 // ***** OpIsValidEvent ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpIsValidEvent)
		          
		        case 259 // ***** OpSetUserEventStatus ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSetUserEventStatus)
		          
		        case 260 // ***** OpCaptureEventProfilingInfo ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpCaptureEventProfilingInfo)
		          
		        case 261 // ***** OpGetDefaultQueue ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpGetDefaultQueue)
		          
		        case 262 // ***** OpBuildNDRange ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpBuildNDRange)
		          
		        case 263 // ***** OpSatConvertSToU ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSatConvertSToU)
		          
		        case 264 // ***** OpSatConvertUToS ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpSatConvertUToS)
		          
		        case 265 // ***** OpAtomicIMin ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicIMin)
		          
		        case 266 // ***** OpAtomicIMax ***************************************************
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.OpAtomicIMax)
		          
		        case else
		          op = new SPIRV.Opcode(self, OpcodeTypeEnum.Unknown)
		          
		          Errors.Append ("ERROR [" + Str(ip) + "]: Unknown opcode.")
		          
		        end select
		        
		        // store opcode
		        
		        op.Offset = ip
		        Opcodes.Append op
		        
		        // check for duplicate result id, and store in lookup table if necessary
		        
		        if op.ResultID > 0 then
		          if OpcodeLookup.HasKey(op.ResultID) then
		            Errors.Append ("ERROR [" + Str(ip) + "]: Duplicate result ID.")
		          else
		            OpcodeLookup.Value(op.ResultID) = op
		          end if
		        end if
		        
		        if (ip + 2) >= ModuleBinary.Size then
		          Errors.Append ("ERROR [" + Str(ip) + "]: IP out of bounds.")
		          ip = moduleUB + 1
		          if Opcodes.Ubound >= 0 then
		            if OpcodeLookup.HasKey(Opcodes(Opcodes.Ubound).ResultID) then
		              OpcodeLookup.Remove(Opcodes(Opcodes.Ubound).ResultID)
		            end if
		            Opcodes.Remove(Opcodes.Ubound)
		          end if
		        elseif ModuleBinary.UInt16Value(ip + 2) = 0 then
		          Errors.Append ("ERROR [" + Str(ip) + "]: Word count of zero.")
		          ip = moduleUB + 1
		        else
		          ip = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		        end if
		        
		      wend
		      
		      validateOpcodes()
		      
		    end if
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub logError(op As SPIRV.Opcode, errMsg As String)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Errors.Append "ERROR [" + Str(op.Offset) + "]: " + errMsg
		  op.HasErrors = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validateOpcodes()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim i As UInt32
		  Dim j As UInt32
		  Dim k As Integer
		  Dim ub As UInt32
		  Dim op As SPIRV.Opcode
		  Dim typ As SPIRV.SPIRVType
		  
		  i = 0
		  while i <= Opcodes.Ubound
		    
		    op = Opcodes(i)
		    
		    select case op.Type
		      
		      ' ***** OpAccessChain ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAccessChain
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Base ID out of bounds.", "Base ID not declared.")
		      
		      ' ***** OpAll ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAll
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRV.TypeEnum.Boolean then
		          logError op, "Result Type must be a Boolean scalar type."
		        end if
		      end if
		      
		      ' ***** OpAny ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAny
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRV.TypeEnum.Boolean then
		          logError op, "Result Type must be a Boolean scalar type."
		        end if
		      end if
		      
		      ' ***** OpArrayLength ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpArrayLength
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Structure ID out of bounds.", "Structure ID not declared.")
		      // todo: Structure must be an object of type OpTypeStruct that contains a member that is a run-time array.
		      // todo: Array member is a member number of Structure that must have a type from OpTypeRuntimeArray.
		      
		      ' ***** OpAsyncGroupCopy ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAsyncGroupCopy
		      validate_WordCountEqual(op, 9)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Destination ID out of bounds.", "Destination ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Source ID out of bounds.", "Source ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Num Elements ID out of bounds.", "Num Elements ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 28), "Stride ID out of bounds.", "Stride ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 32), "Event ID out of bounds.", "Event ID not found.")
		      // todo: Event must be OpTypeEvent.
		      // todo: Event can be used to associate the copy with a previous copy allowing an event to be shared by multiple copies. Otherwise Event should be a OpConstantNullObject.
		      // todo: Destination and Source should both be pointers to the same integer or floating point scalar or vector data type.
		      // todo: Destination and Source pointer storage class can be eitherWorkgroupLocal or WorkgroupGlobal.
		      // todo: When Destination pointer storage class isWorkgroupLocal, the Source pointer storage class must be WorkgroupGlobal.
		      // todo: When Destination pointer storage class isWorkgroupGlobal, the Source pointer storage class must be WorkgroupLocal.
		      
		      ' ***** OpAtomicAnd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicAnd
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicCompareExchange ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicCompareExchange
		      validate_WordCountEqual(op, 8)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 28), "Comparator ID out of bounds.", "Comparator ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicCompareExchangeWeak ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicCompareExchangeWeak
		      validate_WordCountEqual(op, 8)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 28), "Comparator ID out of bounds.", "Comparator ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type. This type must also match the type of Comparator.
		      
		      ' ***** OpAtomicExchange ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicExchange
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicIAdd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicIAdd
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicIDecrement ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicIDecrement
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      // todo: Result Type must be the same type as the type pointed to by Pointer.
		      
		      ' ***** OpAtomicIIncrement ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicIIncrement
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      // todo: Result Type must be the same type as the type pointed to by Pointer.
		      
		      ' ***** OpAtomicInit ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicInit
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Pointer ID out of bounds.", "Pointer ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Value ID out of bounds.", "Value ID not found.")
		      // todo: The type of Value and the type pointed to by Pointer must be the same type.
		      
		      ' ***** OpAtomicIMax ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicIMax
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicIMin ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicIMin
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicISub ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicISub
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicLoad ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicLoad
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      // todo: Result Type must be the same type as the type pointed to by Pointer.
		      
		      ' ***** OpAtomicOr ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicOr
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicStore ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicStore
		      validate_WordCountEqual(op, 5)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Value ID out of bounds.", "Value ID not found.")
		      // todo: The type pointed to by Pointer must be the same type as the type of Value.
		      
		      ' ***** OpAtomicUMax ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicUMax
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicUMin ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicUMin
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpAtomicXor ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpAtomicXor
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Value ID out of bounds.", "Value ID not found.")
		      // todo: Result Type, the type of Value, and the type pointed to by Pointer must all be same type.
		      
		      ' ***** OpBitcast ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpBitcast
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not declared.")
		      // todo: Result Type must be different than the type of Operand.
		      // todo: Both Result Type and the type of Operand must be Numerical-types or pointer types.
		      // todo: The components of Operand and Result Type must be same bit width.
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpBitwiseAnd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpBitwiseAnd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpBitwiseOr ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpBitwiseOr
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpBitwiseXor ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpBitwiseXor
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpBranch ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpBranch
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target Label ID out of bounds.", "Target Label ID not declared.")
		      
		      ' ***** OpBranchConditional ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpBranchConditional
		      validate_WordCountMinimum(op, 4)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Condition ID out of bounds.", "Condition ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "True Label ID out of bounds.", "True Label ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "False Label ID out of bounds.", "False Label ID not declared.")
		      
		      ' ***** OpBuildNDRange ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpBuildNDRange
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "GlobalWorkSize ID out of bounds.", "GlobalWorkSize ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "LocalWorkSize ID out of bounds.", "LocalWorkSize ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "GlobalWorkOffset ID out of bounds.", "GlobalWorkOffset ID not declared.")
		      // todo: GlobalWorkSize, LocalWorkSize and GlobalWorkOffset must be a scalar or an array with 2 or 3 components. Where the type of each element in the array is 32 bit OpTypeInt when the Addressing Model is Physical32 or 64 bit OpTypeInt when the Addressing Model is Physical64.
		      // todo: Result Type is the descriptor and must be a OpTypeStruct with the following ordered list of members, starting from the first to last:
		      //  - 32 bit OpTypeInt
		      //  - OpTypeArray with 3 elements, where each element is 32 bit OpTypeInt when the Addressing Model is Physical32 and 64 bit OpTypeInt when the Addressing Model is Physical64.
		      //  - OpTypeArray with 3 elements, where each element is 32 bit OpTypeInt when the Addressing Model is Physical32 and 64 bit OpTypeInt when the Addressing Model is Physical64.
		      //  - OpTypeArray with 3 elements, where each element is 32 bit OpTypeInt when the Addressing Model is Physical32 and 64 bit OpTypeInt when the Addressing Model is Physical64.
		      
		      ' ***** OpCaptureEventProfilingInfo ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCaptureEventProfilingInfo
		      validate_WordCountEqual(op, 4)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "event ID out of bounds.", "event ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 1 then
		        logError op, "Invalid Kernel Profiling Info mask value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "value ID out of bounds.", "value ID not declared.")
		      // todo: event must be a OpTypeDeviceEvent that was produced by OpEnqueueKernel or OpEnqueueMarker.
		      // todo: When info is CmdExecTime value must be a OpTypePointer with WorkgroupGlobal storage class, to two 64-bit OpTypeInt values.
		      
		      ' ***** OpCommitReadPipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCommitReadPipe
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "reserve_id ID out of bounds.", "reserve_id ID not declared.")
		      // todo: p must be a OpTypePipe with ReadOnly Access Qualifier.
		      // todo: reserve_id must be a OpTypeReserveId.
		      
		      ' ***** OpCommitWritePipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCommitWritePipe
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "reserve_id ID out of bounds.", "reserve_id ID not declared.")
		      // todo: p must be a OpTypePipe with WriteOnly Access Qualifier.
		      // todo: reserve_id must be a OpTypeReserveId.
		      
		      ' ***** OpCompileFlag ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCompileFlag
		      validate_WordCountMinimum(op, 1)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not found.")
		      
		      ' ***** OpCompositeConstruct ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCompositeConstruct
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Constituent " + Str(k) + " ID out of bounds.", "Constituent " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpCompositeExtract ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCompositeExtract
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Composite ID out of bounds.", "Composite ID not declared.")
		      // todo: validate that result type id is the same type as the object selected by the last provided index
		      
		      ' ***** OpCompositeInsert ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCompositeInsert
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Object ID out of bounds.", "Object ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Composite ID out of bounds.", "Composite ID not declared.")
		      
		      ' ***** OpConstant ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConstant
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        select case typ.Type
		        case SPIRV.TypeEnum.Float, SPIRV.TypeEnum.Integer
		          // do nothing
		        case else
		          logError op, "Invalid constant type. Expected integer or float."
		        end select
		      end if
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpConstantComposite ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConstantComposite
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Constituent " + Str(k) + " ID out of bounds.", "Constituent " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpConstantFalse ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConstantFalse
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRV.TypeEnum.Boolean then
		          logError op, "Expected scalar Boolean type."
		        end if
		      end if
		      
		      ' ***** OpConstantNullObject ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConstantNullObject
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpConstantNullPointer ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConstantNullPointer
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpConstantSampler ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConstantSampler
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if (ModuleBinary.UInt32Value(op.Offset + 12) > 8) or (ModuleBinary.UInt32Value(op.Offset + 12) mod 2 <> 0) then
		        logError op, "Invalid Sampler Addressing Mode enumeration value."
		      end if
		      if (ModuleBinary.UInt32Value(op.Offset + 16) > 1) then
		        logError op, "Invalid Param enumeration value."
		      end if
		      if (ModuleBinary.UInt32Value(op.Offset + 20) <> 16) and (ModuleBinary.UInt32Value(op.Offset + 20) <> 32) then
		        logError op, "Invalid Sampler Filter Mode enumeration value."
		      end if
		      
		      ' ***** OpConstantTrue ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConstantTrue
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRV.TypeEnum.Boolean then
		          logError op, "Expected scalar Boolean type."
		        end if
		      end if
		      
		      ' ***** OpControlBarrier ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpControlBarrier
		      validate_WordCountEqual(op, 2)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      // todo: It is only valid to use this instruction with TessellationControl, GLCompute, or Kernel execution models.
		      
		      ' ***** OpConvertFToS ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConvertFToS
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Float Value ID out of bounds.", "Float Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpConvertFToU ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConvertFToU
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Float Value ID out of bounds.", "Float Value ID not declared.")
		      // todo: result type cannot be signed integer type
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpConvertPtrToU ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConvertPtrToU
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not declared.")
		      // todo: result type cannot be signed integer type
		      
		      ' ***** OpConvertSToF ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConvertSToF
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Signed Value ID out of bounds.", "Signed Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpConvertUToF ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConvertUToF
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Unsigned Value ID out of bounds.", "Unsigned Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpConvertUToPtr ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpConvertUToPtr
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Integer Value ID out of bounds.", "Integer Value ID not declared.")
		      
		      ' ***** OpCopyMemory ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCopyMemory
		      validate_WordCountMinimum(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Source ID out of bounds.", "Source ID not declared.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      while j < ub
		        if (ModuleBinary.UInt32Value(j) < 1) or (ModuleBinary.UInt32Value(j) > 2) then
		          logError op, "Invalid Memory Access mask value."
		        end if
		        j = j + 4
		      wend
		      
		      ' ***** OpCopyMemorySized ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCopyMemorySized
		      validate_WordCountMinimum(op, 4)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Source ID out of bounds.", "Source ID not declared.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 16
		      while j < ub
		        if (ModuleBinary.UInt32Value(j) < 1) or (ModuleBinary.UInt32Value(j) > 2) then
		          logError op, "Invalid Memory Access mask value."
		        end if
		        j = j + 4
		      wend
		      
		      ' ***** OpCopyObject ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCopyObject
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not declared.")
		      
		      ' ***** OpCreateUserEvent ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpCreateUserEvent
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      // todo: Result Type must be OpTypeDeviceEvent.
		      
		      ' ***** OpDecorate ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDecorate
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 44 then
		        logError op, "Invalid Decoration enumeration value."
		      end if
		      
		      select case ModuleBinary.UInt32Value(op.Offset + 8)
		      case 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 44
		        validate_WordCountEqual(op, 4)
		      case 39 // Built-In
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 41 then
		          logError op, "Invalid Built-In enumeration value."
		        end if
		      case 40 // Function Parameter Attribute
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 8 then
		          logError op, "Invalid Function Parameter Attribute enumeration value."
		        end if
		      case 41 // FP Rounding Mode
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		          logError op, "Invalid FP Rounding Mode enumeration value."
		        end if
		      case 42 // FP Fast Math Mode
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 16) > 31 then
		          logError op, "Invalid FP Fast Math Mode mask value."
		        end if
		      case 43 // Linkage Type
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 1 then
		          logError op, "Invalid Linkage Type enumeration value."
		        end if
		      case else
		        validate_WordCountEqual(op, 3)
		      end select
		      
		      ' ***** OpDecorationGroup ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDecorationGroup
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpDot ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDot
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector 1 ID out of bounds.", "Vector 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Vector 2 ID out of bounds.", "Vector 2 ID not found.")
		      // todo: The operands’ types must be floating-point vectors with the same component type and the same number of components.
		      // todo: Result Type must be a scalar of the same type as the operands’ component type.
		      
		      ' ***** OpDPdx ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDPdx
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdxCoarse ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDPdxCoarse
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdxFine ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDPdxFine
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdy ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDPdy
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdyCoarse ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDPdyCoarse
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdyFine ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpDPdyFine
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpEmitStreamVertex ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpEmitStreamVertex
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Stream ID out of bounds.", "Stream ID not found.")
		      // todo: Stream must be an <id> of a constant instruction with a scalar integer type.
		      // todo: This instruction can only be used when multiple streams are present.
		      
		      ' ***** OpEmitVertex ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpEmitVertex
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpEndPrimitive ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpEndPrimitive
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpEndStreamPrimitive ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpEndStreamPrimitive
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Stream ID out of bounds.", "Stream ID not found.")
		      // todo: Stream must be an <id> of a constant instruction with a scalar integer type.
		      // todo: This instruction can only be used when multiple streams are present.
		      
		      ' ***** OpEnqueueKernel ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpEnqueueKernel
		      validate_WordCountMinimum(op, 13)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "q ID out of bounds.", "q ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Kernel Enqueue Flags enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "ND Range ID out of bounds.", "ND Range ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Num Events ID out of bounds.", "Num Events ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 28), "Wait Events ID out of bounds.", "Wait Events ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 32), "Ret Event ID out of bounds.", "Ret Event ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 36), "Invoke ID out of bounds.", "Invoke ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 40), "Param ID out of bounds.", "Param ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 44), "Param Size ID out of bounds.", "Param Size ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 48), "Param Align ID out of bounds.", "Param Align ID not declared.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 52
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Local Size " + Str(k) + " ID out of bounds.", "Local Size " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      // todo: ND Range must be a OpTypeStruct created by OpBuildNDRange.
		      // todo: Num Events specifies the number of event objects in the wait list pointed Wait Events and must be 32 bit OpTypeInt treated as unsigned integer.
		      // todo: Wait Events specifies the list of wait event objects and must be a OpTypePointer to OpTypeDeviceEvent.
		      // todo: Ret Event is OpTypePointer to OpTypeDeviceEvent which gets implictly retained by this instruction. must be a OpTypePointer to OpTypeDeviceEvent.
		      // todo: Result Type must be a 32 bit OpTypeInt.
		      // todo: Invoke must be a OpTypeFunction with the following signature:
		      //      - Result Type must be OpTypeVoid.
		      //      - The first parameter must be OpTypePointer to 8 bits OpTypeInt.
		      //      - Optional list of parameters that must be OpTypePointer with WorkgroupLocal storage class.
		      // todo: Param is the first parameter of the function specified by Invoke and must be OpTypePointer to 8 bit OpTypeInt.
		      // todo: Param Size is the size in bytes of the memory pointed by Param and must be a 32 bit OpTypeInt treated as unsigned int.
		      // todo: Local Size is an optional list of 32 bit OpTypeInt values which are treated as unsigned integers.
		      // todo: The number of Local Size operands must match the signature of Invoke OpTypeFunction
		      // todo: Result Type must be a 32 bit OpTypeInt.
		      
		      ' ***** OpEnqueueMarker ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpEnqueueMarker
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "q ID out of bounds.", "q ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Num Events ID out of bounds.", "Num Events ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Wait Events ID out of bounds.", "Wait Events ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Ret Event ID out of bounds.", "Ret Event ID not declared.")
		      // todo: Num Events specifies the number of event objects in the wait list pointed Wait Events and must be 32 bit OpTypeInt treated as unsigned integer.
		      // todo: Wait Events specifies the list of wait event objects and must be a OpTypePointer to OpTypeDeviceEvent.
		      // todo: Ret Event is OpTypePointer to OpTypeDeviceEvent which gets implictly retained by this instruction. must be a OpTypePointer to OpTypeDeviceEvent.
		      // todo: Result Type must be a 32 bit OpTypeInt.
		      
		      ' ***** OpEntryPoint ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpEntryPoint
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 6 then
		        logError op, "Invalid Execution Model enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Entry Point ID out of bounds.", "Entry Point ID not declared.")
		      
		      ' ***** OpExecutionMode ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpExecutionMode
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Entry Point ID out of bounds.", "Entry Point ID not declared.")
		      if not EntryPoints.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        logError op, "Entry Point not declared."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 30 then
		        logError op, "Invalid Execution Mode enumeration value."
		      end if
		      select case ModuleBinary.UInt32Value(op.Offset + 8)
		      case 0 // Invocations
		      case 16 // LocalSize
		        validate_WordCountEqual(op, 6)
		      case 17 // LocalSize
		        validate_WordCountEqual(op, 6)
		      case 25 // OutputVertices
		        validate_WordCountEqual(op, 4)
		      case 29 // VecTypeHint
		        validate_WordCountEqual(op, 4)
		      case else
		        validate_WordCountEqual(op, 3)
		      end select
		      
		      ' ***** OpExtension ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpExtension
		      validate_WordCountMinimum(op, 1)
		      if Trim(ModuleBinary.CString(op.Offset + 4)) = "" then
		        logError op, "Invalid name."
		      end if
		      
		      ' ***** OpExtInst ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpExtInst
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Set ID out of bounds.", "Set ID not declared.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 20
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Operand " + Str(k) + " ID out of bounds.", "Operand " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpExtInstImport ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpExtInstImport
		      validate_WordCountMinimum(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if Trim(ModuleBinary.CString(op.Offset + 8)) = "" then
		        logError op, "Invalid name."
		      end if
		      
		      ' ***** OpFAdd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFAdd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFConvert ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFConvert
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Float Value ID out of bounds.", "Float Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      // todo: widts of components op operand and result type must be different
		      
		      ' ***** OpFDiv ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFDiv
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFMod ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFMod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFMul ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFMul
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFNegate ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFNegate
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not found.")
		      // todo: The operand type and Result Type must be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFOrdEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFOrdEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFOrdGreaterThan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFOrdGreaterThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFOrdGreaterThanEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFOrdGreaterThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      
		      ' ***** OpFOrdLessThan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFOrdLessThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFOrdLessThanEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFOrdLessThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFOrdNotEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFOrdNotEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFRem ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFRem
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFSub ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFSub
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      
		      ' ***** OpFunction ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFunction
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 15 then
		        logError op, "Invalid Function Control mask value."
		      end if
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 16), "Function Type ID out of bounds.", "Function TypeID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 16)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 16))
		        if typ.ReturnTypeID <> ModuleBinary.UInt32Value(op.Offset + 4) then
		          logError op, "Result Type ID does not match Return Type ID in function declaration."
		        end if
		      end if
		      
		      ' ***** OpFunctionCall ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFunctionCall
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_functionId(op, ModuleBinary.UInt32Value(op.Offset + 12), "Function ID out of bounds.", "Function ID not declared.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 16
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Argument " + Str(k) + " ID out of bounds.", "Argument " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpFunctionEnd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFunctionEnd
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpFunctionParameter ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFunctionParameter
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpFUnordEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFUnordEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFUnordGreaterThan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFUnordGreaterThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFUnordGreaterThanEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFUnordGreaterThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFUnordLessThan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFUnordLessThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFUnordLessThanEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFUnordLessThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      
		      ' ***** OpFUnordNotEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFUnordNotEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFwidth ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFwidth
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpFwidthCoarse ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFwidthCoarse
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpFwidthFine ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpFwidthFine
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpGenericCastToPtr ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGenericCastToPtr
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Source Pointer ID out of bounds.", "Source Pointer ID not declared.")
		      // todo: Result Type must point to storage class WorkgroupLocal, WorkgroupGlobal or Private
		      // todo: Result Type must be a pointer type pointing to storage class Generic
		      // todo: Result Type and Source pointer must point to the same type.
		      
		      ' ***** OpGenericCastToPtrExplicit ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGenericCastToPtrExplicit
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Source Pointer ID out of bounds.", "Source Pointer ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 10 then
		        logError op, "Invalid Storage Class enumeration value."
		      end if
		      // todo: Result Type must point to storage class WorkgroupLocal, WorkgroupGlobal or Private
		      // todo: Result Type and Source pointer must point to the same type.
		      
		      ' ***** OpGenericPtrMemSemantics ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGenericPtrMemSemantics
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "ptr ID out of bounds.", "ptr ID not declared.")
		      // todo: Result Type must be a 32-bits wide OpTypeInt value.
		      // todo: ptr must point to Generic.
		      
		      ' ***** OpGetDefaultQueue ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGetDefaultQueue
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      // todo: Result Type must be a OpTypeQueue.
		      
		      ' ***** OpGetKernelNDrangeMaxSubGroupSize ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGetKernelNDrangeMaxSubGroupSize
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "ND Range ID out of bounds.", "ND Range ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Invoke ID out of bounds.", "Invoke ID not declared.")
		      // todo: ND Range must be a OpTypeStruct created by OpBuildNDRange.
		      // todo: Invoke must be a OpTypeFunction with the following signature:
		      //      - Result Type must be OpTypeVoid.
		      //      - The first parameter must be OpTypePointer to 8 bits OpTypeInt.
		      //      - Optional list of parameters that must be OpTypePointer with WorkgroupLocal storage class.
		      // todo: Result Type must be a 32 bit OpTypeInt.
		      
		      ' ***** OpGetKernelNDrangeSubGroupCount ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGetKernelNDrangeSubGroupCount
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "ND Range ID out of bounds.", "ND Range ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Invoke ID out of bounds.", "Invoke ID not declared.")
		      // todo: ND Range must be a OpTypeStruct created by OpBuildNDRange.
		      // todo: Invoke must be a OpTypeFunction with the following signature:
		      //      - Result Type must be OpTypeVoid.
		      //      - The first parameter must be OpTypePointer to 8 bits OpTypeInt.
		      //      - Optional list of parameters that must be OpTypePointer with WorkgroupLocal storage class.
		      // todo: Result Type must be a 32 bit OpTypeInt.
		      
		      ' ***** OpGetKernelPreferredWorkGroupSizeMultiple ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGetKernelPreferredWorkGroupSizeMultiple
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Invoke ID out of bounds.", "Invoke ID not declared.")
		      // todo: Invoke must be a OpTypeFunction with the following signature:
		      //      - Result Type must be OpTypeVoid.
		      //      - The first parameter must be OpTypePointer to 8 bits OpTypeInt.
		      //      - Optional list of parameters that must be OpTypePointer with WorkgroupLocal storage class.
		      // todo: Result Type must be a 32 bit OpTypeInt.
		      
		      ' ***** OpGetKernelWorkGroupSize ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGetKernelWorkGroupSize
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Invoke ID out of bounds.", "Invoke ID not declared.")
		      // todo: Invoke must be a OpTypeFunction with the following signature:
		      //      - Result Type must be OpTypeVoid.
		      //      - The first parameter must be OpTypePointer to 8 bits OpTypeInt.
		      //      - Optional list of parameters that must be OpTypePointer with WorkgroupLocal storage class.
		      // todo: Result Type must be a 32 bit OpTypeInt.
		      
		      ' ***** OpGetMaxPipePackets ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGetMaxPipePackets
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "p ID out of bounds.", "p ID not declared.")
		      // todo: p must be a OpTypePipe with ReadOnly or WriteOnly Access Qualifier.
		      // todo: Result Type must be a 32-bits OpTypeInt which should be treated as unsigned value.
		      
		      ' ***** OpGetNumPipePackets ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGetNumPipePackets
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "p ID out of bounds.", "p ID not declared.")
		      // todo: p must be a OpTypePipe with ReadOnly or WriteOnly Access Qualifier.
		      // todo: Result Type must be a 32-bits OpTypeInt which should be treated as unsigned value.
		      
		      ' ***** OpGroupAll ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupAll
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Predicate ID out of bounds.", "Predicate ID not found.")
		      // todo: Both the Predicate and the Result Type must be of OpTypeBool.
		      
		      ' ***** OpGroupAny ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupAny
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Predicate ID out of bounds.", "Predicate ID not found.")
		      // todo: Both the Predicate and the Result Type must be of OpTypeBool.
		      
		      ' ***** OpGroupBroadcast ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupBroadcast
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Value ID out of bounds.", "Value ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "LocalId ID out of bounds.", "LocalId ID not found.")
		      // todo: Value and Result Type must be a 32 or 64 bits wise OpTypeInt or a 16, 32 or 64 OpTypeFloat floating-point scalar datatype.
		      // todo: LocalId must be an integer datatype. It can be a scalar, or a vector with 2 components or a vector with 3 components.
		      // todo: LocalId must be the same for all work-items in the group.
		      
		      ' ***** OpGroupCommitReadPipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupCommitReadPipe
		      validate_WordCountEqual(op, 4)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 4) = 2) or (ModuleBinary.UInt32Value(op.Offset + 4) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "reserve_id ID out of bounds.", "reserve_id ID not declared.")
		      // todo: p must be a OpTypePipe with ReadOnly Access Qualifier.
		      // todo: reserve_id must be a OpTypeReserveId.
		      
		      ' ***** OpGroupCommitWritePipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupCommitWritePipe
		      validate_WordCountEqual(op, 4)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 4) = 2) or (ModuleBinary.UInt32Value(op.Offset + 4) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "reserve_id ID out of bounds.", "reserve_id ID not declared.")
		      // todo: p must be a OpTypePipe with WriteOnly Access Qualifier.
		      // todo: reserve_id must be a OpTypeReserveId.
		      
		      ' ***** OpGroupDecorate ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupDecorate
		      validate_WordCountMinimum(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Decoration Group ID out of bounds.", "Decoration Group ID not found.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 8
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Target " + Str(k) + " ID out of bounds.", "Target " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpGroupFAdd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupFAdd
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Group Operation enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "X ID out of bounds.", "X ID not found.")
		      // todo: Both X and Result Type must be a 16, 32 or 64 bits wide OpTypeFloat data type.
		      
		      ' ***** OpGroupFMax ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupFMax
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Group Operation enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "X ID out of bounds.", "X ID not found.")
		      // todo: Both X and Result Type must be a 16, 32 or 64 bits wide OpTypeFloat data type.
		      
		      ' ***** OpGroupFMin ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupFMin
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Group Operation enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "X ID out of bounds.", "X ID not found.")
		      // todo: Both X and Result Type must be a 16, 32 or 64 bits wide OpTypeFloat data type.
		      
		      ' ***** OpGroupIAdd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupIAdd
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Group Operation enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "X ID out of bounds.", "X ID not found.")
		      // todo: X and Result Type must be a 32 or 64 bits wide OpTypeInt data type.
		      
		      ' ***** OpGroupReserveReadPipePackets ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupReserveReadPipePackets
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "num_packets ID out of bounds.", "num_packets ID not declared.")
		      // todo: p must be a OpTypePipe with ReadOnly Access Qualifier.
		      // todo: num_packets must be a 32-bits OpTypeInt which is treated as unsigned value.
		      // todo: Result Type must be a OpTypeReserveId.
		      
		      ' ***** OpGroupReserveWritePipePackets ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupReserveWritePipePackets
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "num_packets ID out of bounds.", "num_packets ID not declared.")
		      // todo: p must be a OpTypePipe with WriteOnly Access Qualifier.
		      // todo: num_packets must be a 32-bits OpTypeInt which is treated as unsigned value.
		      // todo: Result Type must be a OpTypeReserveId.
		      
		      ' ***** OpGroupSMax ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupSMax
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Group Operation enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "X ID out of bounds.", "X ID not found.")
		      // todo: X and Result Type must be a 32 or 64 bits wide OpTypeInt data type.
		      
		      ' ***** OpGroupSMin ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupSMin
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Group Operation enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "X ID out of bounds.", "X ID not found.")
		      // todo: X and Result Type must be a 32 or 64 bits wide OpTypeInt data type.
		      
		      ' ***** OpGroupUMax ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupUMax
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Group Operation enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "X ID out of bounds.", "X ID not found.")
		      // todo: X and Result Type must be a 32 or 64 bits wide OpTypeInt data type.
		      
		      ' ***** OpGroupUMin ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupUMin
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Group Operation enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "X ID out of bounds.", "X ID not found.")
		      // todo: X and Result Type must be a 32 or 64 bits wide OpTypeInt data type.
		      
		      ' ***** OpGroupMemberDecorate ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpGroupMemberDecorate
		      validate_WordCountMinimum(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Decoration Group ID out of bounds.", "Decoration Group ID not found.")
		      j = op.Offset + 8
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Target " + Str(k) + " ID out of bounds.", "Target " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpIAdd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIAdd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpIEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpImagePointer ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpImagePointer
		      validate_WordCountMinimum(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Image ID out of bounds.", "Image ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Sample ID out of bounds.", "Sample ID not declared.")
		      // todo : Image is a pointer to a variable of type of OpTypeSampler.
		      
		      ' ***** OpIMul ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIMul
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpInBoundsAccessChain ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpInBoundsAccessChain
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Base ID out of bounds.", "Base ID not found.")
		      
		      ' ***** OpINotEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpINotEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      
		      ' ***** OpIsFinite ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIsFinite
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpIsInf ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIsInf
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpIsNan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIsNan
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpIsNormal ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIsNormal
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpISub ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpISub
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpIsValidEvent ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIsValidEvent
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "event ID out of bounds.", "event ID not declared.")
		      // todo: event must be a OpTypeDeviceEvent
		      // todo: Result Type must be a OpTypeBool.
		      
		      ' ***** OpIsValidReserveId ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpIsValidReserveId
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "reserve_id ID out of bounds.", "reserve_id ID not declared.")
		      // todo: reserve_id must be a OpTypeReserveId.
		      // todo: Result Type must be a OpTypeBool.
		      
		      ' ***** OpKill ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpKill
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpLabel ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLabel
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpLessOrGreater ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLessOrGreater
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "y ID out of bounds.", "y ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      // todo: The operands’ types and Result Type must all have the same number of components.
		      
		      ' ***** OpLifetimeStart ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLifetimeStart
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "ID out of bounds.", "ID not found.")
		      
		      ' ***** OpLifetimeStop ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLifetimeStop
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "ID out of bounds.", "ID not found.")
		      
		      ' ***** OpLine ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLine
		      validate_WordCountEqual(op, 5)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "File ID out of bounds.", "File ID not found.")
		      
		      ' ***** OpLoad ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLoad
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      
		      ' ***** OpLogicalAnd ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLogicalAnd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Operand 1 and Operand 2 must both be scalars or vectors of Boolean type.
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpLogicalOr ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLogicalOr
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Operand 1 and Operand 2 must both be scalars or vectors of Boolean type.
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpLogicalXor ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLogicalXor
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Operand 1 and Operand 2 must both be scalars or vectors of Boolean type.
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpLoopMerge ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpLoopMerge
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Label ID out of bounds.", "Label ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 2 then
		        logError op, "Invalid Loop Control mask value."
		      end if
		      
		      ' ***** OpMatrixTimesMatrix ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpMatrixTimesMatrix
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "LeftMatrix ID out of bounds.", "LeftMatrix ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "RightMatrix ID out of bounds.", "RightMatrix ID not found.")
		      // todo: LeftMatrix and RightMatrix must both have a floating-point matrix type.
		      // todo: The number of columns of LeftMatrix must equal the number of rows of RightMatrix.
		      // todo: Result Type must be a matrix whose number of columns is the number of columns in RightMatrix and whose number of rows is the number of rows of LeftMatrix.
		      
		      ' ***** OpMatrixTimesScalar ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpMatrixTimesScalar
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Matrix ID out of bounds.", "Vector ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Scalar ID out of bounds.", "Scalar ID not found.")
		      // todo: Matrix must have a floating-point matrix type.
		      // todo: Scalar must be a floating-point scalar.
		      // todo: Result Type must be the same as the type of Vector.
		      
		      ' ***** OpMatrixTimesVector ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpMatrixTimesVector
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Matrix ID out of bounds.", "Vector ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Vector ID out of bounds.", "Vector ID not found.")
		      // todo: Matrix must have a floating-point matrix type.
		      // todo: Vector must have a floating-point vector type.
		      // todo: Result Type must be a vector whose size is the number of rows in the matrix.
		      
		      ' ***** OpMemberDecorate ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpMemberDecorate
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 44 then
		        logError op, "Invalid Decoration enumeration value."
		      end if
		      
		      select case ModuleBinary.UInt32Value(op.Offset + 12)
		      case 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 44
		        validate_WordCountEqual(op, 4)
		      case 39 // Built-In
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 16) > 41 then
		          logError op, "Invalid Built-In enumeration value."
		        end if
		      case 40 // Function Parameter Attribute
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 16) > 8 then
		          logError op, "Invalid Function Parameter Attribute enumeration value."
		        end if
		      case 41 // FP Rounding Mode
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 16) > 3 then
		          logError op, "Invalid FP Rounding Mode enumeration value."
		        end if
		      case 42 // FP Fast Math Mode
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 16) > 31 then
		          logError op, "Invalid FP Fast Math Mode mask value."
		        end if
		      case 43 // Linkage Type
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 16) > 1 then
		          logError op, "Invalid Linkage Type enumeration value."
		        end if
		      case else
		        validate_WordCountEqual(op, 4)
		      end select
		      
		      
		      ' ***** OpMemberName ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpMemberName
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      if Trim(ModuleBinary.CString(op.Offset + 12)) = "" then
		        logError op, "Invalid name."
		      end if
		      
		      ' ***** OpMemoryBarrier ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpMemoryBarrier
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 6 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      
		      ' ***** OpMemoryModel ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpMemoryModel
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 2 then
		        logError op, "Invalid Addressing Model enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 4 then
		        logError op, "Invalid Memory Model enumeration value."
		      end if
		      
		      ' ***** OpName ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpName
		      validate_WordCountMinimum(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not found.")
		      
		      ' ***** OpNop ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpNop
		      logError op, "Use of OpNop is invalid."
		      
		      ' ***** OpNot ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpNot
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not found.")
		      // todo: Result Type must be scalars or vectors of floatint-point types
		      
		      ' ***** OpOrdered ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpOrdered
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "y ID out of bounds.", "y ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      // todo: The operands’ types and Result Type must all have the same number of components.
		      
		      ' ***** OpOuterProduct ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpOuterProduct
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector 1 ID out of bounds.", "Vector 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Vector 2 ID out of bounds.", "Vector 2 ID not found.")
		      // todo: The vectors' types must be floating-point vectors with the same component type and the same number of components.
		      // todo: Result Type must be a matrix type. Its number of columns must equal the number of components in Vector 2. The vector type of its columns must be the same as the type of Vector 1.
		      
		      ' ***** OpPhi ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpPhi
		      validate_WordCountMinimum(op, 3)
		      if ((op.WordCount mod 2) <> 1) then
		        logError op, "Operands need to be in pairs."
		      end if
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Operand " + Str(k) + " ID out of bounds.", "Operand " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpPtrCastToGeneric ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpPtrCastToGeneric
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Source Pointer ID out of bounds.", "Source Pointer ID not declared.")
		      // todo: Source pointer must point to storage class WorkgroupLocal, WorkgroupGlobal or Private
		      // todo: Result Type must be a pointer type pointing to storage class Generic
		      // todo: Result Type and Source pointer must point to the same type.
		      
		      ' ***** OpReadPipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpReadPipe
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "ptr ID out of bounds.", "ptr ID not declared.")
		      // todo: p must be a OpTypePipe with ReadOnly Access Qualifier.
		      // todo: ptr must be a OpTypePointer with the same data type as p and a Generic storage class.
		      
		      ' ***** OpReleaseEvent ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpReleaseEvent
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "event ID out of bounds.", "event ID not declared.")
		      //todo: event must be an event that was produced by OpEnqueueKernel, OpEnqueueMarker or OpCreateUserEvent.
		      
		      ' ***** OpReservedReadPipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpReservedReadPipe
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "reserve_id ID out of bounds.", "reserve_id ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "index ID out of bounds.", "index ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "ptr ID out of bounds.", "ptr ID not declared.")
		      // todo: p must be a OpTypePipe with ReadOnly Access Qualifier.
		      // todo: reserve_id must be a OpTypeReserveId.
		      // todo: index must be a 32-bits OpTypeInt which is treated as unsigned value.
		      // todo: ptr must be a OpTypePointer with the same data type as p and a Generic storage class.
		      // todo: Result Type must be a 32-bits OpTypeInt.
		      
		      ' ***** OpReservedWritePipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpReservedWritePipe
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "reserve_id ID out of bounds.", "reserve_id ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "index ID out of bounds.", "index ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "ptr ID out of bounds.", "ptr ID not declared.")
		      // todo: p must be a OpTypePipe with WriteOnly Access Qualifier.
		      // todo: reserve_id must be a OpTypeReserveId.
		      // todo: index must be a 32-bits OpTypeInt which is treated as unsigned value.
		      // todo: ptr must be a OpTypePointer with the same data type as p and a Generic storage class.
		      // todo: Result Type must be a 32-bits OpTypeInt.
		      
		      ' ***** OpReserveReadPipePackets ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpReserveReadPipePackets
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "num_packets ID out of bounds.", "num_packets ID not declared.")
		      
		      ' ***** OpReserveWritePipePackets ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpReserveWritePipePackets
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "num_packets ID out of bounds.", "num_packets ID not declared.")
		      
		      ' ***** OpRetainEvent ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpRetainEvent
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "event ID out of bounds.", "event ID not declared.")
		      //todo: event must be an event that was produced by OpEnqueueKernel, OpEnqueueMarker or OpCreateUserEvent.
		      
		      ' ***** OpReturn ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpReturn
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpReturnValue ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpReturnValue
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Value ID out of bounds.", "Value ID not declared.")
		      // todo: Value must match the Return Type operand of the OpTypeFunction type of the OpFunction body this return instruction is in.
		      
		      ' ***** OpSampler ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSampler
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Filter ID out of bounds.", "Filter ID not found.")
		      // todo: validate that sampler object type is OpTypeSampler
		      // todo: validate that sampler object type is OpTypeFilter
		      
		      ' ***** OpSatConvertSToU ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSatConvertSToU
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Signed Value ID out of bounds.", "Signed Value ID not found.")
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpSatConvertUToS ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSatConvertUToS
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Unsigned Value ID out of bounds.", "Unsigned Value ID not found.")
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpSConvert ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSConvert
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Signed Value ID out of bounds.", "Signed Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      // todo: widts of components op operand and result type must be different
		      
		      ' ***** OpSDiv ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSDiv
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpSelect ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSelect
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Condtion ID out of bounds.", "Condtion ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Object 1 ID out of bounds.", "Object 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Object 2 ID out of bounds.", "Object 2 ID not found.")
		      // todo: Result Type, the type of Object 1, and the type of Object 2 must all be the same.
		      // todo: Condition must have the same number of components as the operands
		      
		      ' ***** OpSelectionMerge ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSelectionMerge
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Label ID out of bounds.", "Label ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 2 then
		        logError op, "Invalid Selection Control mask value."
		      end if
		      
		      ' ***** OpSetUserEventStatus ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSetUserEventStatus
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "event ID out of bounds.", "event ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "status ID out of bounds.", "status ID not declared.")
		      // todo: event must be a OpTypeDeviceEvent that was produced by OpCreateUserEvent.
		      // todo: status must be a 32-bit OpTypeInt treated as a signed integer.
		      
		      ' ***** OpSGreaterThan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSGreaterThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpSGreaterThanEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSGreaterThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpShiftLeftLogical ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpShiftLeftLogical
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The number of components and bit width of Result Type must match those of Operand 1 type.
		      // todo: All types must be integer types.
		      
		      ' ***** OpShiftRightArithmetic ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpShiftRightArithmetic
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The number of components and bit width of Result Type must match those of Operand 1 type.
		      // todo: All types must be integer types.
		      
		      ' ***** OpShiftRightLogical ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpShiftRightLogical
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The number of components and bit width of Result Type must match those of Operand 1 type.
		      // todo: All types must be integer types.
		      
		      ' ***** OpSignBitSet ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSignBitSet
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpSLessThan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSLessThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpSLessThanEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSLessThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpSMod ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSMod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpSNegate ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSNegate
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not found.")
		      // todo: Result Type must be scalars or vectors of integer types
		      
		      ' ***** OpSource ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSource
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 4 then
		        logError op, "Invalid Source Language enumeration value."
		      end if
		      
		      ' ***** OpSourceExtension ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSourceExtension
		      validate_WordCountMinimum(op, 1)
		      if Trim(ModuleBinary.CString(op.Offset + 4)) = "" then
		        logError op, "Invalid extension."
		      end if
		      
		      ' ***** OpSpecConstant ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSpecConstant
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        select case typ.Type
		        case SPIRV.TypeEnum.Float, SPIRV.TypeEnum.Integer
		          // do nothing
		        case else
		          logError op, "Invalid constant type. Expected integer or float."
		        end select
		      end if
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpSpecConstantComposite ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSpecConstantComposite
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      k = 0
		      while j < ub
		        validate_Id(op, ModuleBinary.UInt32Value(j), "Constituent " + Str(k) + " ID out of bounds.", "Constituent " + Str(k) + " ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpSpecConstantFalse ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSpecConstantFalse
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRV.TypeEnum.Boolean then
		          logError op, "Expected scalar Boolean type."
		        end if
		      end if
		      
		      ' ***** OpSpecConstantTrue ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSpecConstantTrue
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRV.TypeEnum.Boolean then
		          logError op, "Expected scalar Boolean type."
		        end if
		      end if
		      
		      ' ***** OpSRem ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSRem
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpStore ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpStore
		      validate_WordCountMinimum(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Pointer ID out of bounds.", "Pointer ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Object ID out of bounds.", "Object ID not found.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      while j < ub
		        if (ModuleBinary.UInt32Value(j) < 1) or (ModuleBinary.UInt32Value(j) > 2) then
		          logError op, "Invalid Memory Access mask value."
		        end if
		        j = j + 4
		      wend
		      
		      ' ***** OpString ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpString
		      validate_WordCountMinimum(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if Trim(ModuleBinary.CString(op.Offset + 8)) = "" then
		        logError op, "Invalid string."
		      end if
		      
		      ' ***** OpSwitch ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpSwitch
		      validate_WordCountMinimum(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Selector ID out of bounds.", "Selector ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Default ID out of bounds.", "Default ID not declared.")
		      k = 0
		      j = op.Offset + 12
		      while (j + 4) < ub
		        validate_Id(op, ModuleBinary.UInt32Value(op.Offset + j + 4), "Target Label " + Str(k) + " ID out of bounds.", "Target Label " + Str(k) + " ID not declared.")
		        k = k + 1
		        j = j + 8
		      wend
		      
		      ' ***** OpTextureFetchSample ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureFetchSample
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Sample ID out of bounds.", "Sample ID not found.")
		      
		      ' ***** OpTextureFetchTexel ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureFetchTexel
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Element ID out of bounds.", "Element ID not found.")
		      // todo: Sampler must be an object of a type made by OpTypeSampler.
		      // todo: Its type must have its Content operand set to 2, indicating both a texture and a filter.
		      // todo: It must have a Dimensionality of Rect or Buffer.
		      
		      ' ***** OpTextureFetchTexelLod ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureFetchTexelLod
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      
		      ' ***** OpTextureFetchTexelOffset ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureFetchTexelOffset
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Offset ID out of bounds.", "Offset ID not found.")
		      
		      ' ***** OpTextureGather ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureGather
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      if (ModuleBinary.UInt32Value(op.Offset + 20) > 3) then
		        logError op, "Component number must be 0, 1, 2 or 3."
		      end if
		      
		      ' ***** OpTextureGatherOffset ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureGatherOffset
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      if (ModuleBinary.UInt32Value(op.Offset + 20) > 3) then
		        logError op, "Component number must be 0, 1, 2 or 3."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Offset ID out of bounds.", "Offset ID not found.")
		      
		      ' ***** OpTextureGatherOffsets ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureGatherOffsets
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      if (ModuleBinary.UInt32Value(op.Offset + 20) > 3) then
		        logError op, "Component number must be 0, 1, 2 or 3."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Offsets ID out of bounds.", "Offsets ID not found.")
		      
		      ' ***** OpTextureQueryLevels ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureQueryLevels
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      
		      ' ***** OpTextureQueryLod ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureQuerySizeLod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      
		      ' ***** OpTextureQuerySamples ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureQuerySamples
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      
		      ' ***** OpTextureQuerySize ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureQuerySize
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      
		      ' ***** OpTextureQuerySizeLod ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureQuerySizeLod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      
		      ' ***** OpTextureSample ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSample
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      if op.WordCount = 6 then
		        validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Bias ID out of bounds.", "Bias ID not found.")
		      end if
		      // todo: this opcode is only allowed under the fragment execution model
		      
		      ' ***** OpTextureSampleDref ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleDref
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Dref ID out of bounds.", "Dref ID not found.")
		      // todo: this opcode is only allowed under the fragment execution model
		      
		      ' ***** OpTextureSampleGrad ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleGrad
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "dx ID out of bounds.", "dx ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "dy ID out of bounds.", "dy ID not found.")
		      
		      ' ***** OpTextureSampleGradOffset ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleGradOffset
		      validate_WordCountEqual(op, 8)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "dx ID out of bounds.", "dx ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "dy ID out of bounds.", "dy ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 28), "Offset ID out of bounds.", "Offset ID not found.")
		      // todo: offset must an <id> of an integer-based constant instruction of scalar or vector type
		      // todo: number of components in Offset must equal the number of components in Coordinate, minus the array layer component, if present
		      
		      ' ***** OpTextureSampleLod ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleLod
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      // todo: this opcode is only allowed under the fragment execution model
		      
		      ' ***** OpTextureSampleLodOffset ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleLodOffset
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Offset ID out of bounds.", "Offset ID not found.")
		      // todo: this opcode is only allowed under the fragment execution model
		      // todo: offset must an <id> of an integer-based constant instruction of scalar or vector type
		      // todo: number of components in Offset must equal the number of components in Coordinate, minus the array layer component, if present
		      
		      ' ***** OpTextureSampleOffset ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleOffset
		      validate_WordCountMinimum(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Offset ID out of bounds.", "Offset ID not found.")
		      if op.WordCount = 7 then
		        validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Bias ID out of bounds.", "Bias ID not found.")
		      end if
		      // todo: this opcode is only allowed under the fragment execution model
		      
		      ' ***** OpTextureSampleProj ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleProj
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      if op.WordCount = 6 then
		        validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Bias ID out of bounds.", "Bias ID not found.")
		      end if
		      // todo: this opcode is only allowed under the fragment execution model
		      
		      ' ***** OpTextureSampleProjGrad ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleProjGrad
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "dx ID out of bounds.", "dx ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "dy ID out of bounds.", "dy ID not found.")
		      // todo: Result Type’s component type must be the same as Sampled Type of Sampler’s type.
		      // todo: Result Type must be scalar if the Sampler’s type sets depth-comparison, and must be a vector of four components if the Sampler’s type does not set depth-comparison.
		      // todo: Sampler must be an object of a type made by OpTypeSampler. Its type must have its Content operand set to 2, indicating both a texture and a filter.
		      // todo: Coordinate is a floating-point vector of four components
		      // todo: dx and dy - The number of components of each must equal the number of components in Coordinate, minus the array layer component, if present.
		      
		      ' ***** OpTextureSampleProjGradOffset ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleProjGradOffset
		      validate_WordCountEqual(op, 8)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "dx ID out of bounds.", "dx ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "dy ID out of bounds.", "dy ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 28), "Offset ID out of bounds.", "Offset ID not found.")
		      
		      ' ***** OpTextureSampleProjLod ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleProjLod
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      
		      ' ***** OpTextureSampleProjLodOffset ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleProjLodOffset
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Offset ID out of bounds.", "Offset ID not found.")
		      
		      ' ***** OpTextureSampleProjOffset ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTextureSampleProjOffset
		      validate_WordCountMinimum(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Offset ID out of bounds.", "Offset ID not found.")
		      if op.WordCount = 7 then
		        validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "Bias ID out of bounds.", "Bias ID not found.")
		      end if
		      // todo: this opcode is only allowed under the fragment execution model
		      // todo: offset must an <id> of an integer-based constant instruction of scalar or vector type
		      // todo: number of components in Offset must equal the number of components in Coordinate, minus the array layer component, if present
		      
		      ' ***** OpTranspose ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTranspose
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Matrix ID out of bounds.", "Matrix ID not declared.")
		      // todo: Matrix must be an intermediate <id> whose type comes from an OpTypeMatrix instruction.
		      // todo: Result Type must be an <id> from an OpTypeMatrix instruction, where the number of columns and the column size is the reverse of those of the type of Matrix.
		      
		      
		      ' ***** OpTypeArray ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeArray
		      validate_WordCountEqual(op, 4)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Element Type ID out of bounds.", "Element Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) = ModuleBinary.UInt32Value(op.Offset + 4) then
		        logError op, "Circular Element Type  ID reference."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) < 1 then
		        logError op, "Invalid length."
		      end if
		      
		      ' ***** OpTypeBool ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeBool
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeDeviceEvent ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeDeviceEvent
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeEvent ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeEvent
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeFloat ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeFloat
		      validate_WordCountEqual(op, 3)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if ModuleBinary.UInt32Value(op.Offset + 8) <= 0 then
		        logError op, "Invalid width."
		      end if
		      
		      ' ***** OpTypeFunction ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeFunction
		      validate_WordCountMinimum(op, 3)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Return Type ID out of bounds.", "Return Type ID not declared.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      k = 0
		      while j < ub
		        validate_typeId(op, ModuleBinary.UInt32Value(j), "Parameter " + Str(k) + " Type ID out of bounds.", "Parameter " + Str(k) + " Type ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpTypeInt ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeInt
		      validate_WordCountEqual(op, 4)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if ModuleBinary.UInt32Value(op.Offset + 8) <= 0 then
		        logError op, "Invalid width."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 1 then
		        logError op, "Invalid sign value."
		      end if
		      
		      ' ***** OpTypeMatrix ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeMatrix
		      validate_WordCountEqual(op, 4)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Column Type ID out of bounds.", "Column Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) = ModuleBinary.UInt32Value(op.Offset + 4) then
		        logError op, "Circular Column Type  ID reference."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) < 2 then
		        logError op, "Invalid Column Count."
		      end if
		      
		      ' ***** OpTypeOpaque ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeOpaque
		      validate_WordCountMinimum(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if Trim(ModuleBinary.CString(op.Offset + 8)) = "" then
		        logError op, "Invalid opaque type name."
		      end if
		      
		      ' ***** OpTypePipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypePipe
		      validate_WordCountMinimum(op, 4)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Type ID out of bounds.", "Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 2 then
		        logError op, "Invalid Access Qualifier enumeration value."
		      end if
		      
		      ' ***** OpTypePointer ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypePointer
		      validate_WordCountEqual(op, 4)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 10 then
		        logError op, "Invalid Storage Class enumeration value."
		      end if
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 12), "Type ID out of bounds.", "Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 12) = ModuleBinary.UInt32Value(op.Offset + 4) then
		        logError op, "Circular Type  ID reference."
		      end if
		      
		      ' ***** OpTypeQueue ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeQueue
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeReserveId ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeReserveId
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeRuntimeArray ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeRuntimeArray
		      validate_WordCountEqual(op, 3)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Element Type ID out of bounds.", "Element Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) = ModuleBinary.UInt32Value(op.Offset + 4) then
		        logError op, "Circular Element Type  ID reference."
		      end if
		      
		      ' ***** OpTypeSampler ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeSampler
		      validate_WordCountMinimum(op, 8)
		      if op.WordCount > 9 then
		        logError op, "Invalid word count."
		      end if
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Sampled Type ID out of bounds.", "Sampled Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 5 then
		        logError op, "Invalid Dimensionality enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 16) > 2 then
		        logError op, "Invalid Content value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 20) > 1 then
		        logError op, "Invalid Arrayed value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 24) > 1 then
		        logError op, "Invalid Compare value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 28) > 1 then
		        logError op, "Invalid Multisampled value."
		      end if
		      if op.WordCount >= 9 then
		        if ModuleBinary.UInt32Value(op.Offset + 32) > 2 then
		          logError op, "Invalid Access Qualifier enumeration value."
		        end if
		      end if
		      
		      ' ***** OpTypeStruct ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeStruct
		      validate_WordCountMinimum(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 8
		      k = 0
		      while j < ub
		        validate_typeId(op, ModuleBinary.UInt32Value(j), "Member " + Str(k) + " Type ID out of bounds.", "Member " + Str(k) + " Type ID not declared.")
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpTypeVector ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeVector
		      validate_WordCountEqual(op, 4)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Component Type ID out of bounds.", "Component Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) = ModuleBinary.UInt32Value(op.Offset + 4) then
		        logError op, "Circular Component Type  ID reference."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) < 2 then
		        logError op, "Invalid Component Count."
		      end if
		      
		      ' ***** OpTypeVoid ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpTypeVoid
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpUConvert ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpUConvert
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Unsigned Value ID out of bounds.", "Unsigned Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      // todo: widts of components op operand and result type must be different
		      // todo: Result type cannot be signed integer
		      
		      ' ***** OpUDiv ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpUDiv
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      // todo: The operands’ types and Result Type cannot be signed types.
		      
		      ' ***** OpUGreaterThan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpUGreaterThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpUGreaterThanEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpUGreaterThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpULessThan ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpULessThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpULessThanEqual ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpULessThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpUMod ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpUMod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      // todo: The operands’ types and Result Type cannot be signed types.
		      
		      ' ***** OpUndef ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpUndef
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpUnordered ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpUnordered
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "y ID out of bounds.", "y ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      // todo: The operands’ types and Result Type must all have the same number of components.
		      
		      ' ***** OpUnreachable ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpUnreachable
		      validate_WordCountEqual(op, 1)
		      // todo: This instruction must be the last instruction in a block.
		      
		      ' ***** OpVariable ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpVariable
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 10 then
		        logError op, "Invalid Storage Class enumeration value."
		      end if
		      
		      ' ***** OpVariableArray ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpVariableArray
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 10 then
		        logError op, "Invalid Storage Class enumeration value."
		      end if
		      
		      ' ***** OpVectorExtractDynamic ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpVectorExtractDynamic
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not declared.")
		      // todo: validate that vector id is a vector type
		      // todo: validate that index not out of bounds
		      // todo: validate that result type is sane type as vector type
		      
		      ' ***** OpVectorInsertDynamic ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpVectorInsertDynamic
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Component ID out of bounds.", "Component ID not declared.")
		      // todo: validate that index not out of bounds
		      
		      ' ***** OpVectorShuffle ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpVectorShuffle
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector 1 ID out of bounds.", "Vector 1 ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Vector 2 ID out of bounds.", "Vector 2 ID not declared.")
		      // todo: validate that vectors has same component type
		      // todo: validate that components are not out of bounds
		      
		      ' ***** OpVectorTimesMatrix ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpVectorTimesMatrix
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Matrix ID out of bounds.", "Matrix ID not found.")
		      // todo: Vector must have a floating-point vector type.
		      // todo: Matrix must have a floating-point matrix type.
		      // todo: Result Type must be a vector whose size is the number of columns in the matrix.
		      
		      ' ***** OpVectorTimesScalar ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpVectorTimesScalar
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Scalar ID out of bounds.", "Scalar ID not found.")
		      // todo: Vector must have a floating-point vector type.
		      // todo: Scalar must be a floating-point scalar.
		      // todo: Result Type must be the same as the type of Vector.
		      
		      ' ***** OpWaitGroupEvents ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpWaitGroupEvents
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if not ((ModuleBinary.UInt32Value(op.Offset + 12) = 2) or (ModuleBinary.UInt32Value(op.Offset + 12) = 3)) then
		        logError op, "Execution Scope must be Workgroup or Subgroup."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Num Events ID out of bounds.", "Num Events ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Events List ID out of bounds.", "Events List ID not found.")
		      // todo: Events List must be a pointer to OpTypeEvent.
		      // todo: Num Events must be a 32 bits wide OpTypeInt.
		      
		      ' ***** OpWritePipe ***********************************************************************************
		      
		    case OpcodeTypeEnum.OpWritePipe
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "p ID out of bounds.", "p ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "ptr ID out of bounds.", "ptr ID not declared.")
		      // todo: p must be a OpTypePipe with WriteOnly Access Qualifier.
		      // todo: ptr must be a OpTypePointer with the same data type as p and a Generic storage class.
		      // todo: Result Type must be a 32-bits OpTypeInt.
		      
		    case else
		      logError op, "Unknown opcode type."
		      
		    end select
		    
		    i = i + 1
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_functionId(op As SPIRV.Opcode, id As UInt32, errMsgOutOfBounds As String, errMsgNotDeclared As String)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if (id <= 0) or (id >= Bound) then
		    logError op, errMsgOutOfBounds
		  end if
		  if not Functions.HasKey(id) then
		    logError op, errMsgNotDeclared
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_Id(op As SPIRV.Opcode, id As UInt32, errMsgOutOfBounds As String, errMsgNotDeclared As String)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if (id <= 0) or (id >= Bound) then
		    logError op, errMsgOutOfBounds
		  end if
		  if not OpcodeLookup.HasKey(id) then
		    logError op, errMsgNotDeclared
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_ResultId(op As SPIRV.Opcode, id As UInt32)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if (id <= 0) or (id >= Bound) then
		    logError op, "Result ID out of bounds."
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_typeId(op As SPIRV.Opcode, id As UInt32, errMsgOutOfBounds As String, errMsgNotDeclared As String)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if (id <= 0) or (id >= Bound) then
		    logError op, errMsgOutOfBounds
		  end if
		  if not Types.HasKey(id) then
		    logError op, errMsgNotDeclared
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_WordCountEqual(op As SPIRV.Opcode, cnt As UInt32)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if op.WordCount <> cnt then
		    logError op, "Invalid word count."
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_WordCountMinimum(op As SPIRV.Opcode, min As UInt32)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if op.WordCount < min then
		    logError op, "Invalid word count."
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AddressingModel As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Bound As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Constants As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Decorations() As SPIRV.Decoration
	#tag EndProperty

	#tag Property, Flags = &h0
		EntryPoints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Errors() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Functions As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		GeneratorMagicNumber As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		MemoryModel As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ModuleBinary As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h0
		Names As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private OpcodeLookup As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Opcodes() As SPIRV.Opcode
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceLanguage As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceVersion As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Types As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Version As UInt32
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
End Class
#tag EndClass
