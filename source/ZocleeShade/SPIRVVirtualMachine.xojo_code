#tag Class
Protected Class SPIRVVirtualMachine
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
		  Dim ep As ZocleeShade.SPIRVEntryPoint
		  Dim dec As ZocleeShade.SPIRVDecoration
		  Dim typ As ZocleeShade.SPIRVType
		  Dim op As ZocleeShade.SPIRVOpcode
		  Dim cnst As ZocleeShade.SPIRVConstant
		  
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
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpNop)
		          
		        case 1 // ***** OpSource ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSource)
		          SourceLanguage = ModuleBinary.UInt32Value(ip + 4)
		          SourceVersion = ModuleBinary.UInt32Value(ip + 8)
		          
		        case 2 // ***** OpSourceExtension ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSourceExtension)
		          
		        case 3 // ***** OpExtension ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpExtension)
		          
		        case 4 // ***** OpExtInstImport ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpExtInstImport)
		          
		        case 5 // ***** OpMemoryModel ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpMemoryModel)
		          AddressingModel = ModuleBinary.UInt32Value(ip + 4)
		          MemoryModel = ModuleBinary.UInt32Value(ip + 8)
		          
		        case 6 // ***** OpEntryPoint ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpEntryPoint)
		          ep = new ZocleeShade.SPIRVEntryPoint
		          ep.ExecutionModel = ModuleBinary.UInt32Value(ip + 4)
		          ep.EntryPointID = ModuleBinary.UInt32Value(ip + 8)
		          EntryPoints.Value(ep.EntryPointID) = ep
		          
		        case 7 // ***** OpExecutionMode ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpExecutionMode)
		          
		        case 8 // ***** OpTypeVoid ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeVoid)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Void
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 9 // ***** OpTypeBool ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeBool)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Boolean
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 10 // ***** OpTypeInt ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeInt)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Integer
		          typ.Width = ModuleBinary.UInt32Value(ip + 8)
		          if ModuleBinary.UInt32Value(ip + 12) = 0 then
		            typ.Signed = false
		          else
		            typ.Signed = true
		          end if
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 11 // ***** OpTypeFloat ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeFloat)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Float
		          typ.Width = ModuleBinary.UInt32Value(ip + 8)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 12 // ***** OpTypeVector ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeVector)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Vector
		          typ.ComponentTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.ComponentCount = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 13 // ***** OpTypeMatrix ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeMatrix)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Matrix
		          typ.ColumnTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.ColumnCount = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 14 // ***** OpTypeSampler ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeSampler)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Sampler
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
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeFilter)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Filter
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 16 // ***** OpTypeArray ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeArray)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Array_
		          typ.ElementTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.Length = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 17 // ***** OpTypeRuntimeArray ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeRuntimeArray)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.RuntimeArray
		          typ.ElementTypeID = ModuleBinary.UInt32Value(ip + 8)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 18 // ***** OpTypeStruct ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeStruct)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Struct
		          tempIP = ip + 8
		          ub = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		          while tempIP < ub
		            typ.MemberTypeID.Append ModuleBinary.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 19 // ***** OpTypeOpaque ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeOpaque)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Opaque
		          typ.Name = ModuleBinary.CString(ip + 8)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 20 // ***** OpTypePointer ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypePointer)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Pointer
		          typ.StorageClass = ModuleBinary.UInt32Value(ip + 8)
		          typ.TypeID = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 21 // ***** OpTypeFunction ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeFunction)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Function_
		          typ.ReturnTypeID = ModuleBinary.UInt32Value(ip + 8)
		          tempIP = ip + 12
		          ub = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		          while tempIP < ub
		            typ.ParmTypeID.Append ModuleBinary.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 22 // ***** OpTypeEvent ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeEvent)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Event_
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 23 // ***** OpTypeDeviceEvent ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeDeviceEvent)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.DeviceEvent
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 24 // ***** OpTypeReserveId ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeReserveId)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.ReservedId
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 25 // ***** OpTypeQueue ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeQueue)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Queue
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 26 // ***** OpTypePipe ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypePipe)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Pipe
		          typ.DataTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.AccessQualifier = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 27 // ***** OpConstantTrue ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstantTrue)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.Type = SPIRVConstantType.BooleanTrue
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 28 // ***** OpConstantFalse ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstantFalse)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.Type = SPIRVConstantType.BooleanFalse
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 29 // ***** OpConstant ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstant)
		          
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.Type = SPIRVConstantType.Constant
		          if Types.HasKey(ModuleBinary.UInt32Value(ip + 4)) then
		            typ = Types.Value(ModuleBinary.UInt32Value(ip + 4))
		            select case typ.Type
		            case SPIRVTypeEnum.Float
		              cnst.Type = SPIRVConstantType.Float
		            case SPIRVTypeEnum.Integer
		              cnst.Type = SPIRVConstantType.Integer
		            end select
		          end if
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 30 // ***** OpConstantComposite ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstantComposite)
		          cnst = new ZocleeShade.SPIRVConstant
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
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstantSampler)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          cnst.Mode = ModuleBinary.UInt32Value(ip + 12)
		          cnst.Param = ModuleBinary.UInt32Value(ip + 16)
		          cnst.Filter = ModuleBinary.UInt32Value(ip + 20)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 32 // ***** OpConstantNullPointer ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstantNullPointer)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.Type = SPIRVConstantType.NullPointer
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 33 // ***** OpConstantNullObject ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstantNullObject)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.Type = SPIRVConstantType.NullObject
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 34 // ***** OpSpecConstantTrue ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSpecConstantTrue)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.Type = SPIRVConstantType.SpecBooleanTrue
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 35 // ***** OpSpecConstantFalse ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSpecConstantFalse)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.Type = SPIRVConstantType.SpecBooleanFalse
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 36 // ***** OpSpecConstant ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSpecConstant)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.Type = SPIRVConstantType.SpecConstant
		          if Types.HasKey(ModuleBinary.UInt32Value(ip + 4)) then
		            typ = Types.Value(ModuleBinary.UInt32Value(ip + 4))
		            select case typ.Type
		            case SPIRVTypeEnum.Float
		              cnst.Type = SPIRVConstantType.Float
		            case SPIRVTypeEnum.Integer
		              cnst.Type = SPIRVConstantType.Integer
		            end select
		          end if
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ResultTypeID = ModuleBinary.UInt32Value(ip + 4)
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 37 // ***** OpSpecConstantComposite ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSpecConstantComposite)
		          cnst = new ZocleeShade.SPIRVConstant
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
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpVariable)
		          
		        case 39 // ***** OpVariableArray ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpVariableArray)
		          
		        case 40 // ***** OpFunction ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFunction)
		          Functions.Value(ModuleBinary.UInt32Value(ip + 8)) = op
		          
		        case 41 // ***** OpFunctionParameter ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFunctionParameter)
		          
		        case 42 // ***** OpFunctionEnd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFunctionEnd)
		          
		        case 43 // ***** OpFunctionCall ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFunctionCall)
		          
		        case 44 // ***** OpExtInst ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpExtInst)
		          
		        case 45 // ***** OpUndef ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpUndef)
		          
		        case 46 // ***** OpLoad ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLoad)
		          
		        case 47 // ***** OpStore ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpStore)
		          
		        case 48 // ***** OpPhi ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpPhi)
		          
		        case 49 // ***** OpDecorationGroup ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDecorationGroup)
		          
		        case 50 // ***** OpDecorate ***************************************************
		          
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDecorate)
		          dec = new ZocleeShade.SPIRVDecoration
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
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpMemberDecorate)
		          
		        case 52 // ***** OpGroupDecorate ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupDecorate)
		          
		        case 53 // ***** OpGroupMemberDecorate ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupMemberDecorate)
		          
		        case 54 // ***** OpName ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpName)
		          Names.Value(ModuleBinary.UInt32Value(ip + 4)) = ModuleBinary.CString(ip + 8)
		          
		        case 55 // ***** OpMemberName ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpMemberName)
		          
		        case 56 // ***** OpString ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpString)
		          
		        case 57 // ***** OpLine ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLine)
		          
		        case 58 // ***** OpVectorExtractDynamic ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpVectorExtractDynamic)
		          
		        case 59 // ***** OpVectorInsertDynamic ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpVectorInsertDynamic)
		          
		        case 60 // ***** OpVectorShuffle ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpVectorShuffle)
		          
		        case 61 // ***** OpCompositeConstruct ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpCompositeConstruct)
		          
		        case 62 // ***** OpCompositeExtract ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpCompositeExtract)
		          
		        case 63 // ***** OpCompositeInsert ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpCompositeInsert)
		          
		        case 64 // ***** OpCopyObject ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpCopyObject)
		          
		        case 65 // ***** OpCopyMemory ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpCopyMemory)
		          
		        case 66 // ***** OpCopyMemorySized ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpCopyMemorySized)
		          
		        case 67 // ***** OpSampler ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSampler)
		          
		        case 68 // ***** OpTextureSample ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSample)
		          
		        case 69 // ***** OpTextureSampleDref ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleDref)
		          
		        case 70 // ***** OpTextureSampleLod ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleLod)
		          
		        case 71 // ***** OpTextureSampleProj ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleProj)
		          
		        case 72 // ***** OpTextureSampleGrad ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleGrad)
		          
		        case 73 // ***** OpTextureSampleOffset ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleOffset)
		          
		        case 74 // ***** OpTextureSampleProjGrad ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleProjGrad)
		          
		        case 75 // ***** OpTextureSampleProjLod ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleProjLod)
		          
		        case 76 // ***** OpTextureSampleLodOffset ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleLodOffset)
		          
		        case 77 // ***** OpTextureSampleProjOffset ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleProjOffset)
		          
		        case 78 // ***** OpTextureSampleGradOffset ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleGradOffset)
		          
		        case 79 // ***** OpTextureSampleProjLodOffset ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleProjLodOffset)
		          
		        case 80 // ***** OpTextureSampleProjGradOffset ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureSampleProjGradOffset)
		          
		        case 81 // ***** OpTextureFetchTexelLod ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureFetchTexelLod)
		          
		        case 82 // ***** OpTextureFetchTexelOffset ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureFetchTexelOffset)
		          
		        case 83 // ***** OpTextureFetchSample ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureFetchSample)
		          
		        case 84 // ***** OpTextureFetchTexel ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureFetchTexel)
		          
		        case 85 // ***** OpTextureGather ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureGather)
		          
		        case 86 // ***** OpTextureGatherOffset ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureGatherOffset)
		          
		        case 87 // ***** OpTextureGatherOffsets ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureGatherOffsets)
		          
		        case 88 // ***** OpTextureQuerySizeLod ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureQuerySizeLod)
		          
		        case 89 // ***** OpTextureQuerySize ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureQuerySize)
		          
		        case 90 // ***** OpTextureQueryLod ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureQueryLod)
		          
		        case 91 // ***** OpTextureQueryLevels ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureQueryLevels)
		          
		        case 92 // ***** OpTextureQuerySamples ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTextureQuerySamples)
		          
		        case 93 // ***** OpAccessChain ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAccessChain)
		          
		        case 94 // ***** OpInBoundsAccessChain ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpInBoundsAccessChain)
		          
		        case 95 // ***** OpSNegate ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSNegate)
		          
		        case 96 // ***** OpFNegate ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFNegate)
		          
		        case 97 // ***** OpNot ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpNot)
		          
		        case 98 // ***** OpAny ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAny)
		          
		        case 99 // ***** OpAll ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAll)
		          
		        case 100 // ***** OpConvertFToU ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConvertFToU)
		          
		        case 101 // ***** OpConvertFToS ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConvertFToS)
		          
		        case 102 // ***** OpConvertSToF ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConvertSToF)
		          
		        case 103 // ***** OpConvertUToF ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConvertUToF)
		          
		        case 104 // ***** OpUConvert ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpUConvert)
		          
		        case 105 // ***** OpSConvert ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSConvert)
		          
		        case 106 // ***** OpFConvert ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFConvert)
		          
		        case 107 // ***** OpConvertPtrToU ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConvertPtrToU)
		          
		        case 108 // ***** OpConvertUToPtr ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConvertUToPtr)
		          
		        case 109 // ***** OpPtrCastToGeneric ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpPtrCastToGeneric)
		          
		        case 110 // ***** OpGenericCastToPtr ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGenericCastToPtr)
		          
		        case 111 // ***** OpBitcast ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpBitcast)
		          
		        case 112 // ***** OpTranspose ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTranspose)
		          
		        case 113 // ***** OpIsNan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpIsNan)
		          
		        case 114 // ***** OpIsInf ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpIsInf)
		          
		        case 115 // ***** OpIsFinite ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpIsFinite)
		          
		        case 116 // ***** OpIsNormal ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpIsNormal)
		          
		        case 117 // ***** OpSignBitSet ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSignBitSet)
		          
		        case 118 // ***** OpLessOrGreater ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLessOrGreater)
		          
		        case 119 // ***** OpOrdered ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpOrdered)
		          
		        case 120 // ***** OpUnordered ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpUnordered)
		          
		        case 121 // ***** OpArrayLength ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpArrayLength)
		          
		        case 122 // ***** OpIAdd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpIAdd)
		          
		        case 123 // ***** OpFAdd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFAdd)
		          
		        case 124 // ***** OpISub ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpISub)
		          
		        case 125 // ***** OpFSub ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFSub)
		          
		        case 126 // ***** OpIMul ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpIMul)
		          
		        case 127 // ***** OpFMul ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFMul)
		          
		        case 128 // ***** OpUDiv ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpUDiv)
		          
		        case 129 // ***** OpSDiv ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSDiv)
		          
		        case 130 // ***** OpFDiv ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFDiv)
		          
		        case 131 // ***** OpUMod ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpUMod)
		          
		        case 132 // ***** OpSRem ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSRem)
		          
		        case 133 // ***** OpSMod ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSMod)
		          
		        case 134 // ***** OpFRem ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFRem)
		          
		        case 135 // ***** OpFMul ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFMul)
		          
		        case 136 // ***** OpVectorTimesScalar ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpVectorTimesScalar)
		          
		        case 137 // ***** OpMatrixTimesScalar ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpMatrixTimesScalar)
		          
		        case 138 // ***** OpVectorTimesMatrix ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpVectorTimesMatrix)
		          
		        case 139 // ***** OpMatrixTimesVector ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpMatrixTimesVector)
		          
		        case 140 // ***** OpMatrixTimesMatrix ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpMatrixTimesMatrix)
		          
		        case 141 // ***** OpOuterProduct ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpOuterProduct)
		          
		        case 142 // ***** OpDot ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDot)
		          
		        case 143 // ***** OpShiftRightLogical ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpShiftRightLogical)
		          
		        case 144 // ***** OpShiftRightArithmetic ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpShiftRightArithmetic)
		          
		        case 145 // ***** OpShiftLeftLogical ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpShiftLeftLogical)
		          
		        case 146 // ***** OpLogicalOr ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLogicalOr)
		          
		        case 147 // ***** OpLogicalXor ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLogicalXor)
		          
		        case 148 // ***** OpLogicalAnd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLogicalAnd)
		          
		        case 149 // ***** OpBitwiseOr ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpBitwiseOr)
		          
		        case 150 // ***** OpBitwiseXor ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpBitwiseXor)
		          
		        case 151 // ***** OpBitwiseAnd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpBitwiseAnd)
		          
		        case 152 // ***** OpSelect ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSelect)
		          
		        case 153 // ***** OpIEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpIEqual)
		          
		        case 154 // ***** OpFOrdEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFOrdEqual)
		          
		        case 155 // ***** OpFUnordEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFUnordEqual)
		          
		        case 156 // ***** OpINotEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpINotEqual)
		          
		        case 157 // ***** OpFOrdNotEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFOrdNotEqual)
		          
		        case 158 // ***** OpFUnordNotEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFUnordNotEqual)
		          
		        case 159 // ***** OpULessThan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpULessThan)
		          
		        case 160 // ***** OpSLessThan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSLessThan)
		          
		        case 161 // ***** OpFOrdLessThan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFOrdLessThan)
		          
		        case 162 // ***** OpFUnordLessThan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFUnordLessThan)
		          
		        case 163 // ***** OpUGreaterThan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpUGreaterThan)
		          
		        case 164 // ***** OpSGreaterThan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSGreaterThan)
		          
		        case 165 // ***** OpFOrdGreaterThan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFOrdGreaterThan)
		          
		        case 166 // ***** OpFUnordGreaterThan ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFUnordGreaterThan)
		          
		        case 167 // ***** OpULessThanEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpULessThanEqual)
		          
		        case 168 // ***** OpSLessThanEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSLessThanEqual)
		          
		        case 169 // ***** OpFOrdLessThanEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFOrdLessThanEqual)
		          
		        case 170 // ***** OpFUnordLessThanEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFUnordLessThanEqual)
		          
		        case 171 // ***** OpUGreaterThanEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpUGreaterThanEqual)
		          
		        case 172 // ***** OpSGreaterThanEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSGreaterThanEqual)
		          
		        case 173 // ***** OpFOrdGreaterThanEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFOrdGreaterThanEqual)
		          
		        case 174 // ***** OpFUnordGreaterThanEqual ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFUnordGreaterThanEqual)
		          
		        case 175 // ***** OpDPdx ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDPdx)
		          
		        case 176 // ***** OpDPdy ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDPdy)
		          
		        case 177 // ***** OpFwidth ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFwidth)
		          
		        case 178 // ***** OpDPdxFine ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDPdxFine)
		          
		        case 179 // ***** OpDPdyFine ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDPdyFine)
		          
		        case 180 // ***** OpFwidthFine ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFwidthFine)
		          
		        case 181 // ***** OpDPdxCoarse ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDPdxCoarse)
		          
		        case 182 // ***** OpDPdyCoarse ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpDPdyCoarse)
		          
		        case 183 // ***** OpFwidthCoarse ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFwidthCoarse)
		          
		        case 184 // ***** OpEmitVertex ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpEmitVertex)
		          
		        case 185 // ***** OpEndPrimitive ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpEndPrimitive)
		          
		        case 186 // ***** OpEmitStreamVertex ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpEmitStreamVertex)
		          
		        case 187 // ***** OpEndStreamPrimitive ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpEndStreamPrimitive)
		          
		        case 188 // ***** OpControlBarrier ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpControlBarrier)
		          
		        case 189 // ***** OpMemoryBarrier ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpMemoryBarrier)
		          
		        case 190 // ***** OpImagePointer ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpImagePointer)
		          
		        case 191 // ***** OpAtomicInit ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicInit)
		          
		        case 192 // ***** OpAtomicLoad ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicLoad)
		          
		        case 193 // ***** OpAtomicStore ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicStore)
		          
		        case 194 // ***** OpAtomicExchange ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicExchange)
		          
		        case 195 // ***** OpAtomicCompareExchange ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicCompareExchange)
		          
		        case 196 // ***** OpAtomicCompareExchangeWeak ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicCompareExchangeWeak)
		          
		        case 197 // ***** OpAtomicIIncrement ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicIIncrement)
		          
		        case 198 // ***** OpAtomicIDecrement ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicIDecrement)
		          
		        case 199 // ***** OpAtomicIAdd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicIAdd)
		          
		        case 200 // ***** OpAtomicISub ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicISub)
		          
		        case 201 // ***** OpAtomicUMin ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicUMin)
		          
		        case 202 // ***** OpAtomicUMax ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicUMax)
		          
		        case 203 // ***** OpAtomicAnd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicAnd)
		          
		        case 204 // ***** OpAtomicOr ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicOr)
		          
		        case 205 // ***** OpAtomicXor ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAtomicXor)
		          
		        case 206 // ***** OpLoopMerge ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLoopMerge)
		          
		        case 207 // ***** OpSelectionMerge ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSelectionMerge)
		          
		        case 208 // ***** OpLabel ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLabel)
		          
		        case 209 // ***** OpBranch ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpBranch)
		          
		        case 210 // ***** OpBranchConditional ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpBranchConditional)
		          
		        case 211 // ***** OpSwitch ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSwitch)
		          
		        case 212 // ***** OpKill ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpKill)
		          
		        case 213 // ***** OpReturn ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpReturn)
		          
		        case 214 // ***** OpReturnValue ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpReturnValue)
		          
		        case 215 // ***** OpUnreachable ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpUnreachable)
		          
		        case 216 // ***** OpLifetimeStart ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLifetimeStart)
		          
		        case 217 // ***** OpLifetimeStop ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLifetimeStop)
		          
		        case 218 // ***** OpCompileFlag ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpCompileFlag)
		          
		        case 219 // ***** OpAsyncGroupCopy ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpAsyncGroupCopy)
		          
		        case 220 // ***** OpWaitGroupEvents ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpWaitGroupEvents)
		          
		        case 221 // ***** OpGroupAll ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupAll)
		          
		        case 222 // ***** OpGroupAny ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupAny)
		          
		        case 223 // ***** OpGroupBroadcast ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupBroadcast)
		          
		        case 224 // ***** OpGroupIAdd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupIAdd)
		          
		        case 225 // ***** OpGroupFAdd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupFAdd)
		          
		        case 226 // ***** OpGroupFMin ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupFMin)
		          
		        case 227 // ***** OpGroupUMin ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupUMin)
		          
		        case 228 // ***** OpGroupSMin ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupSMin)
		          
		        case 229 // ***** OpGroupFMax ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupFMax)
		          
		        case 230 // ***** OpGroupUMax ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupUMax)
		          
		        case 231 // ***** OpGroupSMax ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpGroupSMax)
		          
		        case else
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.Unknown)
		          
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
		Private Sub logError(op As ZocleeShade.SPIRVOpcode, errMsg As String)
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
		  Dim op As ZocleeShade.SPIRVOpcode
		  Dim typ As ZocleeShade.SPIRVType
		  
		  i = 0
		  while i <= Opcodes.Ubound
		    
		    op = Opcodes(i)
		    
		    select case op.Type
		      
		      ' ***** OpAccessChain ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpAccessChain
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Base ID out of bounds.", "Base ID not declared.")
		      
		      ' ***** OpAll ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpAll
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRVTypeEnum.Boolean then
		          logError op, "Result Type must be a Boolean scalar type."
		        end if
		      end if
		      
		      ' ***** OpAny ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpAny
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRVTypeEnum.Boolean then
		          logError op, "Result Type must be a Boolean scalar type."
		        end if
		      end if
		      
		      ' ***** OpArrayLength ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpArrayLength
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Structure ID out of bounds.", "Structure ID not declared.")
		      // todo: Structure must be an object of type OpTypeStruct that contains a member that is a run-time array.
		      // todo: Array member is a member number of Structure that must have a type from OpTypeRuntimeArray.
		      
		      ' ***** OpAsyncGroupCopy ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpAsyncGroupCopy
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicAnd
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicCompareExchange
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicCompareExchangeWeak
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicExchange
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicIAdd
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicIDecrement
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicIIncrement
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicInit
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Pointer ID out of bounds.", "Pointer ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Value ID out of bounds.", "Value ID not found.")
		      // todo: The type of Value and the type pointed to by Pointer must be the same type.
		      
		      ' ***** OpAtomicISub ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicISub
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicLoad
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicOr
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicStore
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicUMax
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicUMin
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
		      
		    case SPIRVOpcodeTypeEnum.OpAtomicXor
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
		      
		    case SPIRVOpcodeTypeEnum.OpBitcast
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not declared.")
		      // todo: Result Type must be different than the type of Operand.
		      // todo: Both Result Type and the type of Operand must be Numerical-types or pointer types.
		      // todo: The components of Operand and Result Type must be same bit width.
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpBitwiseAnd ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpBitwiseAnd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpBitwiseOr ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpBitwiseOr
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpBitwiseXor ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpBitwiseXor
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpBranch ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpBranch
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target Label ID out of bounds.", "Target Label ID not declared.")
		      
		      ' ***** OpBranchConditional ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpBranchConditional
		      validate_WordCountMinimum(op, 4)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Condition ID out of bounds.", "Condition ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "True Label ID out of bounds.", "True Label ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "False Label ID out of bounds.", "False Label ID not declared.")
		      
		      ' ***** OpCompileFlag ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpCompileFlag
		      validate_WordCountMinimum(op, 1)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not found.")
		      
		      ' ***** OpCompositeConstruct ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpCompositeConstruct
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
		      
		    case SPIRVOpcodeTypeEnum.OpCompositeExtract
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Composite ID out of bounds.", "Composite ID not declared.")
		      // todo: validate that result type id is the same type as the object selected by the last provided index
		      
		      ' ***** OpCompositeInsert ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpCompositeInsert
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Object ID out of bounds.", "Object ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Composite ID out of bounds.", "Composite ID not declared.")
		      
		      ' ***** OpConstant ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConstant
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        select case typ.Type
		        case SPIRVTypeEnum.Float, SPIRVTypeEnum.Integer
		          // do nothing
		        case else
		          logError op, "Invalid constant type. Expected integer or float."
		        end select
		      end if
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpConstantComposite ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConstantComposite
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
		      
		    case SPIRVOpcodeTypeEnum.OpConstantFalse
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRVTypeEnum.Boolean then
		          logError op, "Expected scalar Boolean type."
		        end if
		      end if
		      
		      ' ***** OpConstantNullObject ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConstantNullObject
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpConstantNullPointer ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConstantNullPointer
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpConstantSampler ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConstantSampler
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
		      
		    case SPIRVOpcodeTypeEnum.OpConstantTrue
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRVTypeEnum.Boolean then
		          logError op, "Expected scalar Boolean type."
		        end if
		      end if
		      
		      ' ***** OpControlBarrier ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpControlBarrier
		      validate_WordCountEqual(op, 2)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 3 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      // todo: It is only valid to use this instruction with TessellationControl, GLCompute, or Kernel execution models.
		      
		      ' ***** OpConvertFToS ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConvertFToS
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Float Value ID out of bounds.", "Float Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpConvertFToU ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConvertFToU
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Float Value ID out of bounds.", "Float Value ID not declared.")
		      // todo: result type cannot be signed integer type
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpConvertPtrToU ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConvertPtrToU
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not declared.")
		      // todo: result type cannot be signed integer type
		      
		      ' ***** OpConvertSToF ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConvertSToF
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Signed Value ID out of bounds.", "Signed Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpConvertUToF ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConvertUToF
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Unsigned Value ID out of bounds.", "Unsigned Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      
		      ' ***** OpConvertUToPtr ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConvertUToPtr
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Integer Value ID out of bounds.", "Integer Value ID not declared.")
		      
		      ' ***** OpCopyMemory ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpCopyMemory
		      validate_WordCountMinimum(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Source ID out of bounds.", "Source ID not declared.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      while j < ub
		        if (ModuleBinary.UInt32Value(j) < 1) or (ModuleBinary.UInt32Value(j) > 2) then
		          logError op, "Invalid Memory Access enumeration value."
		        end if
		        j = j + 4
		      wend
		      
		      ' ***** OpCopyMemorySized ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpCopyMemorySized
		      validate_WordCountMinimum(op, 4)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Source ID out of bounds.", "Source ID not declared.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 16
		      while j < ub
		        if (ModuleBinary.UInt32Value(j) < 1) or (ModuleBinary.UInt32Value(j) > 2) then
		          logError op, "Invalid Memory Access enumeration value."
		        end if
		        j = j + 4
		      wend
		      
		      ' ***** OpCopyObject ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpCopyObject
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not declared.")
		      
		      ' ***** OpDecorate ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDecorate
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
		        break // todo
		      case 43 // Linkage Type
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 1 then
		          logError op, "Invalid Linkage Type enumeration value."
		        end if
		      case else
		        validate_WordCountEqual(op, 3)
		      end select
		      
		      ' ***** OpDecorationGroup ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDecorationGroup
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpDot ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDot
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector 1 ID out of bounds.", "Vector 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Vector 2 ID out of bounds.", "Vector 2 ID not found.")
		      // todo: The operands’ types must be floating-point vectors with the same component type and the same number of components.
		      // todo: Result Type must be a scalar of the same type as the operands’ component type.
		      
		      ' ***** OpDPdx ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDPdx
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdxCoarse ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDPdxCoarse
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdxFine ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDPdxFine
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdy ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDPdy
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdyCoarse ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDPdyCoarse
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpDPdyFine ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDPdyFine
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpEmitStreamVertex ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpEmitStreamVertex
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Stream ID out of bounds.", "Stream ID not found.")
		      // todo: Stream must be an <id> of a constant instruction with a scalar integer type.
		      // todo: This instruction can only be used when multiple streams are present.
		      
		      ' ***** OpEmitVertex ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpEmitVertex
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpEndPrimitive ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpEndPrimitive
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpEndStreamPrimitive ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpEndStreamPrimitive
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Stream ID out of bounds.", "Stream ID not found.")
		      // todo: Stream must be an <id> of a constant instruction with a scalar integer type.
		      // todo: This instruction can only be used when multiple streams are present.
		      
		      ' ***** OpEntryPoint ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpEntryPoint
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 6 then
		        logError op, "Invalid Execution Model enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Entry Point ID out of bounds.", "Entry Point ID not declared.")
		      
		      ' ***** OpExecutionMode ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpExecutionMode
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
		      
		    case SPIRVOpcodeTypeEnum.OpExtension
		      validate_WordCountMinimum(op, 1)
		      if Trim(ModuleBinary.CString(op.Offset + 4)) = "" then
		        logError op, "Invalid name."
		      end if
		      
		      ' ***** OpExtInst ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpExtInst
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
		      
		    case SPIRVOpcodeTypeEnum.OpExtInstImport
		      validate_WordCountMinimum(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if Trim(ModuleBinary.CString(op.Offset + 8)) = "" then
		        logError op, "Invalid name."
		      end if
		      
		      ' ***** OpFAdd ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFAdd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFConvert ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFConvert
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Float Value ID out of bounds.", "Float Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      // todo: widts of components op operand and result type must be different
		      
		      ' ***** OpFDiv ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFDiv
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFMod ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFMod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFMul ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFMul
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFNegate ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFNegate
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not found.")
		      // todo: The operand type and Result Type must be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFOrdEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFOrdEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFOrdGreaterThan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFOrdGreaterThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFOrdGreaterThanEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFOrdGreaterThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      
		      ' ***** OpFOrdLessThan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFOrdLessThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFOrdLessThanEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFOrdLessThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFOrdNotEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFOrdNotEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFRem ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFRem
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of floating-point types with the same number of components and the same component widths.
		      
		      ' ***** OpFSub ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFSub
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      
		      ' ***** OpFunction ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFunction
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 15 then
		        logError op, "Invalid Function Control Mask value."
		      end if
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 16), "Function Type ID out of bounds.", "Function TypeID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 16)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 16))
		        if typ.ReturnTypeID <> ModuleBinary.UInt32Value(op.Offset + 4) then
		          logError op, "Result Type ID does not match Return Type ID in function declaration."
		        end if
		      end if
		      
		      ' ***** OpFunctionCall ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFunctionCall
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
		      
		    case SPIRVOpcodeTypeEnum.OpFunctionEnd
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpFunctionParameter ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFunctionParameter
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpFUnordEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFUnordEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFUnordGreaterThan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFUnordGreaterThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFUnordGreaterThanEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFUnordGreaterThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFUnordLessThan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFUnordLessThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFUnordLessThanEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFUnordLessThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      
		      ' ***** OpFUnordNotEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFUnordNotEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpFwidth ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFwidth
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpFwidthCoarse ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFwidthCoarse
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpFwidthFine ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFwidthFine
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "P ID out of bounds.", "P ID not found.")
		      // todo: Result Type must be the same as the type of P. This type must be a floating-point scalar or floating-point vector.
		      
		      ' ***** OpGenericCastToPtr ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpGenericCastToPtr
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Source Pointer ID out of bounds.", "Source Pointer ID not declared.")
		      // todo: Result Type must point to storage class WorkgroupLocal, WorkgroupGlobal or Private
		      // todo: Result Type must be a pointer type pointing to storage class Generic
		      // todo: Result Type and Source pointer must point to the same type.
		      
		      ' ***** OpGroupAll ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpGroupAll
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupAny
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupBroadcast
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
		      
		      ' ***** OpGroupDecorate ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpGroupDecorate
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupFAdd
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupFMax
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupFMin
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupIAdd
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupSMin
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupUMax
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupUMin
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
		      
		    case SPIRVOpcodeTypeEnum.OpGroupMemberDecorate
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
		      
		    case SPIRVOpcodeTypeEnum.OpIAdd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpIEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpIEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpImagePointer ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpImagePointer
		      validate_WordCountMinimum(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Image ID out of bounds.", "Image ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Sample ID out of bounds.", "Sample ID not declared.")
		      // todo : Image is a pointer to a variable of type of OpTypeSampler.
		      
		      ' ***** OpIMul ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpIMul
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpInBoundsAccessChain ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpInBoundsAccessChain
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Base ID out of bounds.", "Base ID not found.")
		      
		      ' ***** OpINotEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpINotEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      
		      ' ***** OpIsFinite ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpIsFinite
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpIsInf ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpIsInf
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpIsNan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpIsNan
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpIsNormal ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpIsNormal
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpISub ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpISub
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpKill ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpKill
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpLabel ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLabel
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpLessOrGreater ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLessOrGreater
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "y ID out of bounds.", "y ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      // todo: The operands’ types and Result Type must all have the same number of components.
		      
		      ' ***** OpLifetimeStart ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLifetimeStart
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "ID out of bounds.", "ID not found.")
		      
		      ' ***** OpLifetimeStop ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLifetimeStop
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "ID out of bounds.", "ID not found.")
		      
		      ' ***** OpLine ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLine
		      validate_WordCountEqual(op, 5)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "File ID out of bounds.", "File ID not found.")
		      
		      ' ***** OpLoad ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLoad
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      
		      ' ***** OpLogicalAnd ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLogicalAnd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Operand 1 and Operand 2 must both be scalars or vectors of Boolean type.
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpLogicalOr ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLogicalOr
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Operand 1 and Operand 2 must both be scalars or vectors of Boolean type.
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpLogicalXor ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLogicalXor
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Operand 1 and Operand 2 must both be scalars or vectors of Boolean type.
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpLoopMerge ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLoopMerge
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Label ID out of bounds.", "Label ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 2 then
		        logError op, "Invalid Loop Control enumeration value."
		      end if
		      
		      ' ***** OpMatrixTimesMatrix ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpMatrixTimesMatrix
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "LeftMatrix ID out of bounds.", "LeftMatrix ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "RightMatrix ID out of bounds.", "RightMatrix ID not found.")
		      // todo: LeftMatrix and RightMatrix must both have a floating-point matrix type.
		      // todo: The number of columns of LeftMatrix must equal the number of rows of RightMatrix.
		      // todo: Result Type must be a matrix whose number of columns is the number of columns in RightMatrix and whose number of rows is the number of rows of LeftMatrix.
		      
		      ' ***** OpMatrixTimesScalar ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpMatrixTimesScalar
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Matrix ID out of bounds.", "Vector ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Scalar ID out of bounds.", "Scalar ID not found.")
		      // todo: Matrix must have a floating-point matrix type.
		      // todo: Scalar must be a floating-point scalar.
		      // todo: Result Type must be the same as the type of Vector.
		      
		      ' ***** OpMatrixTimesVector ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpMatrixTimesVector
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Matrix ID out of bounds.", "Vector ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Vector ID out of bounds.", "Vector ID not found.")
		      // todo: Matrix must have a floating-point matrix type.
		      // todo: Vector must have a floating-point vector type.
		      // todo: Result Type must be a vector whose size is the number of rows in the matrix.
		      
		      ' ***** OpMemberDecorate ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpMemberDecorate
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
		        break // todo
		      case 43 // Linkage Type
		        validate_WordCountEqual(op, 4)
		        if ModuleBinary.UInt32Value(op.Offset + 16) > 1 then
		          logError op, "Invalid Linkage Type enumeration value."
		        end if
		      case else
		        validate_WordCountEqual(op, 4)
		      end select
		      
		      
		      ' ***** OpMemberName ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpMemberName
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      if Trim(ModuleBinary.CString(op.Offset + 12)) = "" then
		        logError op, "Invalid name."
		      end if
		      
		      ' ***** OpMemoryBarrier ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpMemoryBarrier
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 3) > 6 then
		        logError op, "Invalid Execution Scope enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 3) > 1023 then
		        logError op, "Invalid Memory Semantics enumeration value."
		      end if
		      
		      ' ***** OpMemoryModel ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpMemoryModel
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 2 then
		        logError op, "Invalid Addressing Model enumeration value."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 4 then
		        logError op, "Invalid Memory Model enumeration value."
		      end if
		      
		      ' ***** OpName ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpName
		      validate_WordCountMinimum(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not found.")
		      
		      ' ***** OpNop ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpNop
		      logError op, "Use of OpNop is invalid."
		      
		      ' ***** OpNot ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpNot
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not found.")
		      // todo: Result Type must be scalars or vectors of floatint-point types
		      
		      ' ***** OpOrdered ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpOrdered
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "y ID out of bounds.", "y ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      // todo: The operands’ types and Result Type must all have the same number of components.
		      
		      ' ***** OpOuterProduct ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpOuterProduct
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector 1 ID out of bounds.", "Vector 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Vector 2 ID out of bounds.", "Vector 2 ID not found.")
		      // todo: The vectors' types must be floating-point vectors with the same component type and the same number of components.
		      // todo: Result Type must be a matrix type. Its number of columns must equal the number of components in Vector 2. The vector type of its columns must be the same as the type of Vector 1.
		      
		      ' ***** OpPhi ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpPhi
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
		      
		    case SPIRVOpcodeTypeEnum.OpPtrCastToGeneric
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Source Pointer ID out of bounds.", "Source Pointer ID not declared.")
		      // todo: Source pointer must point to storage class WorkgroupLocal, WorkgroupGlobal or Private
		      // todo: Result Type must be a pointer type pointing to storage class Generic
		      // todo: Result Type and Source pointer must point to the same type.
		      
		      ' ***** OpReturn ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpReturn
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpReturnValue ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpReturnValue
		      validate_WordCountEqual(op, 2)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Value ID out of bounds.", "Value ID not declared.")
		      // todo: Value must match the Return Type operand of the OpTypeFunction type of the OpFunction body this return instruction is in.
		      
		      ' ***** OpSampler ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSampler
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      // todo: validate that sampler object type is OpTypeSampler
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Filter ID out of bounds.", "Filter ID not found.")
		      // todo: validate that sampler object type is OpTypeFilter
		      
		      ' ***** OpSConvert ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSConvert
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Signed Value ID out of bounds.", "Signed Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      // todo: widts of components op operand and result type must be different
		      
		      ' ***** OpSDiv ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSDiv
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpSelect ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSelect
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Condtion ID out of bounds.", "Condtion ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Object 1 ID out of bounds.", "Object 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Object 2 ID out of bounds.", "Object 2 ID not found.")
		      // todo: Result Type, the type of Object 1, and the type of Object 2 must all be the same.
		      // todo: Condition must have the same number of components as the operands
		      
		      ' ***** OpSelectionMerge ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSelectionMerge
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Label ID out of bounds.", "Label ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 2 then
		        logError op, "Invalid Selection Control enumeration value."
		      end if
		      
		      ' ***** OpSGreaterThan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSGreaterThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpSGreaterThanEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSGreaterThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpShiftLeftLogical ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpShiftLeftLogical
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The number of components and bit width of Result Type must match those of Operand 1 type.
		      // todo: All types must be integer types.
		      
		      ' ***** OpShiftRightArithmetic ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpShiftRightArithmetic
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The number of components and bit width of Result Type must match those of Operand 1 type.
		      // todo: All types must be integer types.
		      
		      ' ***** OpShiftRightLogical ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpShiftRightLogical
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The number of components and bit width of Result Type must match those of Operand 1 type.
		      // todo: All types must be integer types.
		      
		      ' ***** OpSignBitSet ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSignBitSet
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operand.
		      // todo: The operand’s type and Result Type must have the same number of components.
		      
		      ' ***** OpSLessThan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSLessThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpSLessThanEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSLessThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpSMod ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSMod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpSNegate ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSNegate
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand ID out of bounds.", "Operand ID not found.")
		      // todo: Result Type must be scalars or vectors of integer types
		      
		      ' ***** OpSource ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSource
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 4 then
		        logError op, "Invalid Source Language enumeration value."
		      end if
		      
		      ' ***** OpSourceExtension ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSourceExtension
		      validate_WordCountMinimum(op, 1)
		      if Trim(ModuleBinary.CString(op.Offset + 4)) = "" then
		        logError op, "Invalid extension."
		      end if
		      
		      ' ***** OpSpecConstant ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSpecConstant
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        select case typ.Type
		        case SPIRVTypeEnum.Float, SPIRVTypeEnum.Integer
		          // do nothing
		        case else
		          logError op, "Invalid constant type. Expected integer or float."
		        end select
		      end if
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpSpecConstantComposite ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSpecConstantComposite
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
		      
		    case SPIRVOpcodeTypeEnum.OpSpecConstantFalse
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRVTypeEnum.Boolean then
		          logError op, "Expected scalar Boolean type."
		        end if
		      end if
		      
		      ' ***** OpSpecConstantTrue ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSpecConstantTrue
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        typ = Types.Value(ModuleBinary.UInt32Value(op.Offset + 4))
		        if typ.Type <> SPIRVTypeEnum.Boolean then
		          logError op, "Expected scalar Boolean type."
		        end if
		      end if
		      
		      ' ***** OpSRem ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSRem
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      
		      ' ***** OpStore ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpStore
		      validate_WordCountMinimum(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Pointer ID out of bounds.", "Pointer ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Object ID out of bounds.", "Object ID not found.")
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      while j < ub
		        if (ModuleBinary.UInt32Value(j) < 1) or (ModuleBinary.UInt32Value(j) > 2) then
		          logError op, "Invalid Memory Access enumeration value."
		        end if
		        j = j + 4
		      wend
		      
		      ' ***** OpString ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpString
		      validate_WordCountMinimum(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if Trim(ModuleBinary.CString(op.Offset + 8)) = "" then
		        logError op, "Invalid string."
		      end if
		      
		      ' ***** OpSwitch ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSwitch
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
		      
		    case SPIRVOpcodeTypeEnum.OpTextureFetchSample
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Sample ID out of bounds.", "Sample ID not found.")
		      
		      ' ***** OpTextureFetchTexel ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureFetchTexel
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Element ID out of bounds.", "Element ID not found.")
		      // todo: Sampler must be an object of a type made by OpTypeSampler.
		      // todo: Its type must have its Content operand set to 2, indicating both a texture and a filter.
		      // todo: It must have a Dimensionality of Rect or Buffer.
		      
		      ' ***** OpTextureFetchTexelLod ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureFetchTexelLod
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      
		      ' ***** OpTextureFetchTexelOffset ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureFetchTexelOffset
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Offset ID out of bounds.", "Offset ID not found.")
		      
		      ' ***** OpTextureGather ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureGather
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      if (ModuleBinary.UInt32Value(op.Offset + 20) > 3) then
		        logError op, "Component number must be 0, 1, 2 or 3."
		      end if
		      
		      ' ***** OpTextureGatherOffset ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureGatherOffset
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
		      
		    case SPIRVOpcodeTypeEnum.OpTextureGatherOffsets
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
		      
		    case SPIRVOpcodeTypeEnum.OpTextureQueryLevels
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      
		      ' ***** OpTextureQueryLod ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureQuerySizeLod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      
		      ' ***** OpTextureQuerySamples ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureQuerySamples
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      
		      ' ***** OpTextureQuerySize ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureQuerySize
		      validate_WordCountEqual(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      
		      ' ***** OpTextureQuerySizeLod ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureQuerySizeLod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      
		      ' ***** OpTextureSample ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSample
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
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleDref
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Dref ID out of bounds.", "Dref ID not found.")
		      // todo: this opcode is only allowed under the fragment execution model
		      
		      ' ***** OpTextureSampleGrad ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleGrad
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "dx ID out of bounds.", "dx ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "dy ID out of bounds.", "dy ID not found.")
		      
		      ' ***** OpTextureSampleGradOffset ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleGradOffset
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
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleLod
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      // todo: this opcode is only allowed under the fragment execution model
		      
		      ' ***** OpTextureSampleLodOffset ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleLodOffset
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
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleOffset
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
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleProj
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
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleProjGrad
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "dx ID out of bounds.", "dx ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "dy ID out of bounds.", "dy ID not found.")
		      
		      ' ***** OpTextureSampleProjGradOffset ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleProjGradOffset
		      validate_WordCountEqual(op, 8)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "dx ID out of bounds.", "dx ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 24), "dy ID out of bounds.", "dy ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 28), "Offset ID out of bounds.", "Offset ID not found.")
		      
		      ' ***** OpTextureSampleProjLod ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleProjLod
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      
		      ' ***** OpTextureSampleProjLodOffset ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleProjLodOffset
		      validate_WordCountEqual(op, 7)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Sampler ID out of bounds.", "Sampler ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Coordinate ID out of bounds.", "Coordinate ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Level of Detail ID out of bounds.", "Level of Detail ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 20), "Offset ID out of bounds.", "Offset ID not found.")
		      
		      ' ***** OpTextureSampleProjOffset ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTextureSampleProjOffset
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
		      
		    case SPIRVOpcodeTypeEnum.OpTranspose
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Matrix ID out of bounds.", "Matrix ID not declared.")
		      // todo: Matrix must be an intermediate <id> whose type comes from an OpTypeMatrix instruction.
		      // todo: Result Type must be an <id> from an OpTypeMatrix instruction, where the number of columns and the column size is the reverse of those of the type of Matrix.
		      
		      
		      ' ***** OpTypeArray ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeArray
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
		      
		    case SPIRVOpcodeTypeEnum.OpTypeBool
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeDeviceEvent ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeDeviceEvent
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeEvent ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeEvent
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeFloat ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeFloat
		      validate_WordCountEqual(op, 3)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if ModuleBinary.UInt32Value(op.Offset + 8) <= 0 then
		        logError op, "Invalid width."
		      end if
		      
		      ' ***** OpTypeFunction ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeFunction
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
		      
		    case SPIRVOpcodeTypeEnum.OpTypeInt
		      validate_WordCountEqual(op, 4)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if ModuleBinary.UInt32Value(op.Offset + 8) <= 0 then
		        logError op, "Invalid width."
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 1 then
		        logError op, "Invalid sign value."
		      end if
		      
		      ' ***** OpTypeMatrix ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeMatrix
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
		      
		    case SPIRVOpcodeTypeEnum.OpTypeOpaque
		      validate_WordCountMinimum(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if Trim(ModuleBinary.CString(op.Offset + 8)) = "" then
		        logError op, "Invalid opaque type name."
		      end if
		      
		      ' ***** OpTypePipe ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypePipe
		      validate_WordCountMinimum(op, 4)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Type ID out of bounds.", "Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 2 then
		        logError op, "Invalid Access Qualifier enumeration value."
		      end if
		      
		      ' ***** OpTypePointer ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypePointer
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
		      
		    case SPIRVOpcodeTypeEnum.OpTypeQueue
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeReserveId ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeReserveId
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpTypeRuntimeArray ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeRuntimeArray
		      validate_WordCountEqual(op, 3)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 8), "Element Type ID out of bounds.", "Element Type ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) = ModuleBinary.UInt32Value(op.Offset + 4) then
		        logError op, "Circular Element Type  ID reference."
		      end if
		      
		      ' ***** OpTypeSampler ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeSampler
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
		      
		    case SPIRVOpcodeTypeEnum.OpTypeStruct
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
		      
		    case SPIRVOpcodeTypeEnum.OpTypeVector
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
		      
		    case SPIRVOpcodeTypeEnum.OpTypeVoid
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpUConvert ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpUConvert
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Unsigned Value ID out of bounds.", "Unsigned Value ID not declared.")
		      // todo: operand type and result type must have same number of components
		      // todo: widts of components op operand and result type must be different
		      // todo: Result type cannot be signed integer
		      
		      ' ***** OpUDiv ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpUDiv
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      // todo: The operands’ types and Result Type cannot be signed types.
		      
		      ' ***** OpUGreaterThan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpUGreaterThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpUGreaterThanEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpUGreaterThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpULessThan ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpULessThan
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpULessThanEqual ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpULessThanEqual
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      
		      ' ***** OpUMod ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpUMod
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      // todo: The operands’ types and Result Type must all be scalars or vectors of integer types with the same number of components and the same component widths.
		      // todo: The operands’ types and Result Type cannot be signed types.
		      
		      ' ***** OpUndef ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpUndef
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpUnordered ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpUnordered
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "x ID out of bounds.", "x ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "y ID out of bounds.", "y ID not declared.")
		      // todo: Result Type must be a scalar or vector of Boolean type, with the same number of components as the operands.
		      // todo: The operands’ types and Result Type must all have the same number of components.
		      
		      ' ***** OpUnreachable ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpUnreachable
		      validate_WordCountEqual(op, 1)
		      // todo: This instruction must be the last instruction in a block.
		      
		      ' ***** OpVariable ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpVariable
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 10 then
		        logError op, "Invalid Storage Class enumeration value."
		      end if
		      
		      ' ***** OpVariableArray ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpVariableArray
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 10 then
		        logError op, "Invalid Storage Class enumeration value."
		      end if
		      
		      ' ***** OpVectorExtractDynamic ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpVectorExtractDynamic
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not declared.")
		      // todo: validate that vector id is a vector type
		      // todo: validate that index not out of bounds
		      // todo: validate that result type is sane type as vector type
		      
		      ' ***** OpVectorInsertDynamic ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpVectorInsertDynamic
		      validate_WordCountEqual(op, 6)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Component ID out of bounds.", "Component ID not declared.")
		      // todo: validate that index not out of bounds
		      
		      ' ***** OpVectorShuffle ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpVectorShuffle
		      validate_WordCountMinimum(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector 1 ID out of bounds.", "Vector 1 ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Vector 2 ID out of bounds.", "Vector 2 ID not declared.")
		      // todo: validate that vectors has same component type
		      // todo: validate that components are not out of bounds
		      
		      ' ***** OpVectorTimesMatrix ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpVectorTimesMatrix
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Matrix ID out of bounds.", "Matrix ID not found.")
		      // todo: Vector must have a floating-point vector type.
		      // todo: Matrix must have a floating-point matrix type.
		      // todo: Result Type must be a vector whose size is the number of columns in the matrix.
		      
		      ' ***** OpVectorTimesScalar ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpVectorTimesScalar
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Vector ID out of bounds.", "Vector ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Scalar ID out of bounds.", "Scalar ID not found.")
		      // todo: Vector must have a floating-point vector type.
		      // todo: Scalar must be a floating-point scalar.
		      // todo: Result Type must be the same as the type of Vector.
		      
		      ' ***** OpWaitGroupEvents ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpWaitGroupEvents
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
		      
		    case else
		      logError op, "Unknown opcode type."
		      
		    end select
		    
		    i = i + 1
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_functionId(op As ZocleeShade.SPIRVOpcode, id As UInt32, errMsgOutOfBounds As String, errMsgNotDeclared As String)
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
		Private Sub validate_Id(op As ZocleeShade.SPIRVOpcode, id As UInt32, errMsgOutOfBounds As String, errMsgNotDeclared As String)
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
		Private Sub validate_ResultId(op As ZocleeShade.SPIRVOpcode, id As UInt32)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if (id <= 0) or (id >= Bound) then
		    logError op, "Result ID out of bounds."
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_typeId(op As ZocleeShade.SPIRVOpcode, id As UInt32, errMsgOutOfBounds As String, errMsgNotDeclared As String)
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
		Private Sub validate_WordCountEqual(op As ZocleeShade.SPIRVOpcode, cnt As UInt32)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if op.WordCount <> cnt then
		    logError op, "Invalid word count."
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_WordCountMinimum(op As ZocleeShade.SPIRVOpcode, min As UInt32)
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
		Decorations() As ZocleeShade.SPIRVDecoration
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
		Opcodes() As ZocleeShade.SPIRVOpcode
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
