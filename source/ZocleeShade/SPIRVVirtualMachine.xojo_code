#tag Class
Protected Class SPIRVVirtualMachine
	#tag Method, Flags = &h0
		Sub Clear()
		  AddressingModel = 2 // Phyical64
		  Bound = 0
		  Redim Decorations(-1)
		  Redim EntryPoints(-1)
		  Redim Errors(-1)
		  GeneratorMagicNumber = 0
		  MemoryModel = 0 // Simple
		  Names = new Dictionary()
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
		  Dim upperBound As UInt32
		  Dim ep As ZocleeShade.SPIRVEntryPoint
		  Dim dec As ZocleeShade.SPIRVDecoration
		  Dim typ As ZocleeShade.SPIRVType
		  Dim op As ZocleeShade.SPIRVOpcode
		  
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
		      
		      ip = 16
		      while ip < moduleUB
		        
		        select case ModuleBinary.UInt16Value(ip)
		          
		        case 1 // ***** OpSource ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.Source)
		          SourceLanguage = ModuleBinary.UInt32Value(ip + 4)
		          SourceVersion = ModuleBinary.UInt32Value(ip + 8)
		          
		        case 5 // ***** OpMemoryModel ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.MemoryModel)
		          AddressingModel = ModuleBinary.UInt32Value(ip + 4)
		          MemoryModel = ModuleBinary.UInt32Value(ip + 8)
		          
		        case 6 // ***** OpEntryPoint ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.EntryPoint)
		          ep = new ZocleeShade.SPIRVEntryPoint
		          ep.ExecutionModel = ModuleBinary.UInt32Value(ip + 4)
		          ep.EntryPointID = ModuleBinary.UInt32Value(ip + 8)
		          EntryPoints.Append ep
		          
		        case 8 // ***** OpTypeVoid ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.TypeVoid)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Void
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 10 // ***** OpTypeInt ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.TypeInt)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Integer
		          typ.Width = ModuleBinary.UInt32Value(ip + 8)
		          if ModuleBinary.UInt32Value(ip + 12) = 0 then
		            typ.Signed = false
		          else
		            typ.Signed = true
		          end if
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 12 // ***** OpTypeVector ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.TypeVector)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Vector
		          typ.ComponentTypeID = ModuleBinary.UInt32Value(ip + 8)
		          typ.ComponentCount = ModuleBinary.UInt32Value(ip + 8)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 20 // ***** OpTypePointer ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.TypePointer)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Pointer
		          typ.StorageClass = ModuleBinary.UInt32Value(ip + 8)
		          typ.TypeID = ModuleBinary.UInt32Value(ip + 12)
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 21 // ***** OpTypeFunction ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.TypeFunction)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Function_
		          typ.ReturnTypeID = ModuleBinary.UInt32Value(ip + 8)
		          tempIP = ip + 12
		          upperBound = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		          while tempIP < upperBound
		            typ.ParmTypeID.Append ModuleBinary.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Types.Value(ModuleBinary.UInt32Value(ip + 4)) = typ
		          
		        case 50 // ***** OpDecorate ***************************************************
		          
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.Decorate)
		          dec = new ZocleeShade.SPIRVDecoration
		          dec.TargetID = ModuleBinary.UInt32Value(ip + 4)
		          dec.Decoration = ModuleBinary.UInt32Value(ip + 8)
		          select case dec.Decoration
		            ' Stream, Location, Component, Index, Binding, DescriptorSet, Offset, Alignment, XfbBuffer, Stride,
		            ' Built-In, FuncParamAttr, FP Rouding Mode, FP Fast Math Mode, Linkage Type, SpecId
		          case 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44
		            tempIP = ip + 12
		            upperBound = ip + (ModuleBinary.UInt16Value(ip + 2) * 4)
		            while tempIP < upperBound
		              dec.ExtraOperands.Append ModuleBinary.UInt32Value(tempIP)
		              tempIP = tempIP + 4
		            wend
		          end select
		          Decorations.Append dec
		          
		        case 54 // ***** OpName ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.Name)
		          Names.Value(ModuleBinary.UInt32Value(ip + 4)) = ModuleBinary.CString(ip + 8)
		          if (ModuleBinary.UInt32Value(ip + 4) >= Bound) then
		            Errors.Append ("ERROR [" + Str(ip) + "]: Target ID out of bounds.")
		          end if
		          
		        case else
		          op = new ZocleeShade.SPIRVOpcode(self, SPIRVOpcodeTypeEnum.Unknown)
		          
		          Errors.Append ("ERROR [" + Str(ip) + "]: Unknown opcode.")
		          
		        end select
		        
		        ' store opcode
		        
		        op.Offset = ip
		        Opcodes.Append op
		        
		        if ModuleBinary.UInt16Value(ip + 2) = 0 then
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
		Private Sub validateOpcodes()
		  Dim i As UInt32
		  Dim op As ZocleeShade.SPIRVOpcode
		  Dim wordCount As Integer
		  
		  i = 0
		  while i <= Opcodes.Ubound
		    
		    op = Opcodes(i)
		    wordCount = ModuleBinary.UInt16Value(op.Offset + 2)
		    
		    select case op.Type
		      
		      ' ***** OpDecorate ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.Decorate
		      
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Target ID out of bounds.")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 44 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Decoration enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 8)) + ".")
		        op.HasErrors = True
		      end if
		      
		      select case ModuleBinary.UInt32Value(op.Offset + 8)
		      case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26
		        if wordCount <> 3 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		          op.HasErrors = True
		        end if
		      case 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 44
		        if wordCount <> 4 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		          op.HasErrors = True
		        end if
		      case 39 // Built-In
		        if wordCount <> 4 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		          op.HasErrors = True
		        end if
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 41 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Built-In enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 8)) + ".")
		          op.HasErrors = True
		        end if
		      case 40 // Function Parameter Attribute
		        if wordCount <> 4 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		          op.HasErrors = True
		        end if
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 8 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Function Parameter Attribute enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 8)) + ".")
		          op.HasErrors = True
		        end if
		      case 41 // FP Rounding Mode
		        if wordCount <> 4 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		          op.HasErrors = True
		        end if
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 3 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown FP Rounding Mode enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 8)) + ".")
		          op.HasErrors = True
		        end if
		      case 42 // FP Fast Math Mode
		        if wordCount <> 4 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		          op.HasErrors = True
		        end if
		        break // todo
		      case 43 // Linkage Type
		        if wordCount <> 4 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		          op.HasErrors = True
		        end if
		        if ModuleBinary.UInt32Value(op.Offset + 12) > 1 then
		          Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Linkage Type enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 8)) + ".")
		          op.HasErrors = True
		        end if
		        
		      end select
		      
		      ' ***** OpEntryPoint ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.EntryPoint
		      if wordCount <> 3 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 6 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Execution Model enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 4)) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Entry Point ID out of bounds.")
		        op.HasErrors = True
		      end if
		      
		      ' ***** OpMemoryModel ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.MemoryModel
		      if wordCount <> 3 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 2 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Addressing Model enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 4)) + ".")
		        op.HasErrors = True
		      end if
		      if ModuleBinary.UInt32Value(op.Offset + 8) > 4 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Memory Model enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 8)) + ".")
		        op.HasErrors = True
		      end if
		      
		      ' ***** OpName ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.Name
		      if ModuleBinary.UInt32Value(op.Offset + 4) >= Bound then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Target ID out of bounds.")
		        op.HasErrors = True
		      end if
		      
		      ' ***** OpSource ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.Source
		      if wordCount <> 3 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
		        op.HasErrors = True
		      end if 
		      if ModuleBinary.UInt32Value(op.Offset + 4) > 4 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unkown Source Language enumeration value " + Str(ModuleBinary.UInt32Value(op.Offset + 4)) + ".")
		        op.HasErrors = True
		      end if
		      
		      ' ***** OpTypeInt ***********************************************************************************
		      
		    case SPIRVOpcodeTypeEnum.TypeInt
		      if wordCount <> 4 then
		        Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unexpected word count " + Str(wordCount) + ".")
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
		      
		    case else
		      Errors.Append ("ERROR [" + Str(op.Offset) + "]: Unknown opcode type.")
		      op.HasErrors = True
		      
		    end select
		    
		    i = i + 1
		  wend
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		AddressingModel As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		Bound As UInt32
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
