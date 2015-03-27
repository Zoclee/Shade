#tag Class
Protected Class SPIRVVirtualMachine
	#tag Method, Flags = &h0
		Sub Clear()
		  AddressingModel = 2 // Phyical64
		  Bound = 0
		  Constants = new Dictionary()
		  Redim Decorations(-1)
		  Redim EntryPoints(-1)
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
		          
		        case 1 // ***** OpSource ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSource)
		          SourceLanguage = ModuleBinary.UInt32Value(ip + 4)
		          SourceVersion = ModuleBinary.UInt32Value(ip + 8)
		          
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
		          EntryPoints.Append ep
		          
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
		          
		        case 16 // ***** OpTypeArray ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpTypeArray)
		          typ = new ZocleeShade.SPIRVType(self, ModuleBinary.UInt32Value(ip + 4))
		          typ.Type = SPIRVTypeEnum.Array_
		          typ.ElementTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.Length = ModuleBinary.UInt32Value(ip + 12)
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
		          
		        case 29 // ***** OpConstant ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstant)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ReturnTypeID = ModuleBinary.UInt32Value(ip + 4)
		          cnst.Value = Str(ModuleBinary.UInt32Value(ip + 12))
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 30 // ***** OpConstantComposite ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpConstantComposite)
		          cnst = new ZocleeShade.SPIRVConstant
		          cnst.ResultID = ModuleBinary.UInt32Value(ip + 8)
		          cnst.ReturnTypeID = ModuleBinary.UInt32Value(ip + 4)
		          tempIP = ip + 12
		          ub = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		          while tempIP < ub
		            cnst.Constituents.Append ModuleBinary.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Constants.Value(cnst.ResultID) = cnst
		          
		        case 38 // ***** OpVariable ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpVariable)
		          
		        case 40 // ***** OpFunction ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFunction)
		          Functions.Value(ModuleBinary.UInt32Value(ip + 8)) = op
		          
		        case 41 // ***** OpFunctionParameter ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFunctionParameter)
		          
		        case 42 // ***** OpFunctionEnd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpFunctionEnd)
		          
		        case 46 // ***** OpLoad ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLoad)
		          
		        case 47 // ***** OpStore ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpStore)
		          
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
		          
		        case 54 // ***** OpName ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpName)
		          Names.Value(ModuleBinary.UInt32Value(ip + 4)) = ModuleBinary.CString(ip + 8)
		          
		        case 55 // ***** OpMemberName ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpMemberName)
		          
		        case 62 // ***** OpCompositeExtract ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpCompositeExtract)
		          
		        case 94 // ***** OpInBoundsAccessChain ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpInBoundsAccessChain)
		          
		        case 122 // ***** OpIAdd ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpIAdd)
		          
		        case 207 // ***** OpSelectionMerge ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpSelectionMerge)
		          
		        case 208 // ***** OpLabel ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpLabel)
		          
		        case 210 // ***** OpBranchConditional ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpBranchConditional)
		          
		        case 213 // ***** OpReturn ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.OpReturn)
		          
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
		  Errors.Append "ERROR [" + Str(op.Offset) + "]: " + errMsg
		  op.HasErrors = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validateOpcodes()
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
		      
		      ' ***** OpBranchConditional ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpBranchConditional
		      validate_WordCountMinimum(op, 4)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Condition ID out of bounds.", "Condition ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "True Label ID out of bounds.", "True Label ID not declared.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "False Label ID out of bounds.", "False Label ID not declared.")
		      
		      ' ***** OpCompositeExtract ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpCompositeExtract
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Composite ID out of bounds.", "Composite ID not declared.")
		      // todo: validate that result type id is the same type as the object selected by the last provided index
		      
		      ' ***** OpConstant ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpConstant
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
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
		      
		      ' ***** OpDecorate ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpDecorate
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not declared.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 44 then
		        logError op, "Invalid Decoration enumeration value."
		      end if
		      
		      select case ModuleBinary.UInt32Value(op.Offset + 8)
		      case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26
		        validate_WordCountEqual(op, 3)
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
		      end select
		      
		      ' ***** OpEntryPoint ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpEntryPoint
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 6 then
		        logError op, "Execution Model enumeration value."
		      end if
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 8), "Entry Point ID out of bounds.", "Entry Point ID not declared.")
		      
		      ' ***** OpExtInstImport ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpExtInstImport
		      validate_WordCountMinimum(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if Trim(ModuleBinary.CString(op.Offset + 8)) = "" then
		        logError op, "Invalid name."
		      end if
		      
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
		      
		      ' ***** OpFunctionEnd ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFunctionEnd
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpFunctionParameter ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpFunctionParameter
		      validate_WordCountEqual(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      
		      ' ***** OpIAdd ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpIAdd
		      validate_WordCountEqual(op, 5)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Operand 1 ID out of bounds.", "Operand 1 ID not found.")
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 16), "Operand 2 ID out of bounds.", "Operand 2 ID not found.")
		      
		      ' ***** OpInBoundsAccessChain ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpInBoundsAccessChain
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Base ID out of bounds.", "Base ID not found.")
		      
		      ' ***** OpLabel ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLabel
		      validate_WordCountEqual(op, 2)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      
		      ' ***** OpLoad ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpLoad
		      validate_WordCountMinimum(op, 4)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 8))
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 12), "Pointer ID out of bounds.", "Pointer ID not found.")
		      
		      ' ***** OpMemberName ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpMemberName
		      validate_WordCountMinimum(op, 3)
		      validate_typeId(op, ModuleBinary.UInt32Value(op.Offset + 4), "Result Type ID out of bounds.", "Result Type ID not declared.")
		      if Trim(ModuleBinary.CString(op.Offset + 12)) = "" then
		        logError op, "Invalid name."
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
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Target ID out of bounds.", "Target ID not found.")
		      if Trim(ModuleBinary.CString(op.Offset + 8)) = "" then
		        logError op, "Invalid name."
		      end if
		      
		      ' ***** OpReturn ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpReturn
		      validate_WordCountEqual(op, 1)
		      
		      ' ***** OpSelectionMerge ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSelectionMerge
		      validate_WordCountEqual(op, 3)
		      validate_Id(op, ModuleBinary.UInt32Value(op.Offset + 4), "Label ID out of bounds.", "Label ID not found.")
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 2 then
		        logError op, "Invalid Selection Control enumeration value."
		      end if
		      
		      ' ***** OpSource ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpSource
		      validate_WordCountEqual(op, 3)
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 4 then
		        logError op, "Invalid Source Language enumeration value."
		      end if
		      
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
		      
		      ' ***** OpTypeFloat ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeFloat
		      validate_WordCountEqual(op, 3)
		      validate_ResultId(op, ModuleBinary.UInt32Value(op.Offset + 4))
		      if ModuleBinary.UInt32Value(op.Offset + 8) <= 0 then
		        logError op, "Invalid width."
		      end if
		      
		      ' ***** OpTypeFunction ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeFunction
		      if op.WordCount < 3 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(op.WordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Return Type ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if not Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 8)) then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Return Type  ID not declared.")
		        op.HasErrors = True
		      end if
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 12
		      k = 0
		      while j < ub
		        if ModuleBinary.UInt32Value(j) >= Bound then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Parameter " + Str(k) + "  Type ID out of bounds.")
		          op.HasErrors = True
		        end if
		        if not Types.HasKey(ModuleBinary.UInt32Value(j)) then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Parameter " + Str(k) + "  Type  ID not declared.")
		          op.HasErrors = True
		        end if
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpTypeInt ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeInt
		      if op.WordCount <> 4 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(op.WordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) <= 0 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Invalid width.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 1 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Invalid sign value.")
		        op.HasErrors = True
		      end if
		      
		      ' ***** OpTypePointer ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypePointer
		      if op.WordCount <> 4 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(op.WordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 10 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Storage Class enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 4)) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) = ModuleBinary.UInt32Value(op.Offset + 4) then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Circular Type  ID reference.")
		        op.HasErrors = True
		      end if
		      if not Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 12)) then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Type  ID not declared.")
		        op.HasErrors = True
		      end if
		      
		      ' ***** OpTypeStruct ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeStruct
		      if op.WordCount < 2 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(op.WordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result ID out of bounds.")
		        op.HasErrors = True
		      end if
		      ub = op.Offset + (op.WordCount * 4)
		      j = op.Offset + 8
		      k = 0
		      while j < ub
		        if ModuleBinary.UInt32Value(j) >= Bound then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Member " + Str(k) + "  Type ID out of bounds.")
		          op.HasErrors = True
		        end if
		        if not Types.HasKey(ModuleBinary.UInt32Value(j)) then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Member " + Str(k) + "  Type  ID not declared.")
		          op.HasErrors = True
		        end if
		        j = j + 4
		        k = k + 1
		      wend
		      
		      ' ***** OpTypeVector ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeVector
		      if op.WordCount <> 4 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(op.WordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Component Type ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) = ModuleBinary.UInt32Value(op.Offset + 4) then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Circular Component Type  ID reference.")
		        op.HasErrors = True
		      end if
		      if not Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 8)) then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Component Type  ID not declared.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) < 2 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Invalid Component Count.")
		        op.HasErrors = True
		      end if
		      
		      ' ***** OpTypeVoid ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpTypeVoid
		      if op.WordCount <> 2 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(op.WordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result ID out of bounds.")
		        op.HasErrors = True
		      end if
		      
		      ' ***** OpVariable ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.OpVariable
		      if op.WordCount < 4 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(op.WordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result Type ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if not Types.HasKey(ModuleBinary.UInt32Value(op.Offset + 4)) then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result Type  ID not declared.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Result ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 12) > 10 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Storage Class enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 4)) + ".")
		        op.HasErrors = True
		      end if
		      
		    case else
		      Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unknown opcode type.")
		      op.HasErrors = True
		      
		    end select
		    
		    i = i + 1
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_Id(op As ZocleeShade.SPIRVOpcode, id As UInt32, errMsgOutOfBounds As String, errMsgNotDeclared As String)
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
		  if (id <= 0) or (id >= Bound) then
		    logError op, "Result ID out of bounds."
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_typeId(op As ZocleeShade.SPIRVOpcode, id As UInt32, errMsgOutOfBounds As String, errMsgNotDeclared As String)
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
		  if op.WordCount <> cnt then
		    logError op, "Invalid word count."
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub validate_WordCountMinimum(op As ZocleeShade.SPIRVOpcode, min As UInt32)
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
		EntryPoints() As ZocleeShade.SPIRVEntryPoint
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
