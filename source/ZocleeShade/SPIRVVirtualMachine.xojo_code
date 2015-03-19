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
		  REdim Opcodes(-1)
		  SourceLanguage = 0 // Unknown
		  SourceVersion = 0
		  Types = new Dictionary()
		  Version = 99
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LoadModule(m As MemoryBlock)
		  Dim ip As UInt32
		  Dim moduleUB As Integer
		  Dim tempIP As UInt32
		  Dim upperBound As UInt32
		  Dim ep As ZocleeShade.SPIRVEntryPoint
		  Dim dec As ZocleeShade.SPIRVDecoration
		  Dim typ As ZocleeShade.SPIRVType
		  Dim op As ZocleeShade.SPIRVOpcode
		  Dim unknown As Integer
		  
		  Clear()
		  
		  if m <> nil then
		    
		    // test magic number
		    
		    if m.UInt32Value(0) <> &h07230203 then
		      
		      Errors.Append "Invalid magic number."
		      
		    else
		      
		      Version = m.UInt32Value(4)
		      GeneratorMagicNumber = m.UInt32Value(8)
		      Bound = m.UInt32Value(12)
		      moduleUB = m.Size - 1
		      
		      //  instructions
		      
		      ip = 16
		      while ip < moduleUB
		        
		        select case m.UInt16Value(ip)
		          
		        case 1 // ***** OpSource ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.Source)
		          SourceLanguage = m.UInt32Value(ip + 4)
		          SourceVersion = m.UInt32Value(ip + 8)
		          
		        case 5 // ***** OpMemoryModel ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.MemoryModel)
		          AddressingModel = m.UInt32Value(ip + 4)
		          MemoryModel = m.UInt32Value(ip + 8)
		          
		        case 6 // ***** OpEntryPoint ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.EntryPoint)
		          ep = new ZocleeShade.SPIRVEntryPoint
		          ep.ExecutionModel = m.UInt32Value(ip + 4)
		          ep.EntryPointID = m.UInt32Value(ip + 8)
		          EntryPoints.Append ep
		          
		        case 8 // ***** OpTypeVoid ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.TypeVoid)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Void
		          Types.Value(m.UInt32Value(ip + 4)) = typ
		          
		        case 10 // ***** OpTypeInt ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.TypeInt)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Integer
		          typ.Width = m.UInt32Value(ip + 8)
		          if m.UInt32Value(ip + 12) = 0 then
		            typ.Signed = false
		          else
		            typ.Signed = true
		          end if
		          Types.Value(m.UInt32Value(ip + 4)) = typ
		          
		        case 12 // ***** OpTypeVector ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.TypeVector)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Vector
		          typ.ComponentTypeID = m.UInt32Value(ip + 8)
		          typ.ComponentCount = m.UInt32Value(ip + 8)
		          Types.Value(m.UInt32Value(ip + 4)) = typ
		          
		        case 20 // ***** OpTypePointer ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.TypePointer)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Pointer
		          typ.StorageClass = m.UInt32Value(ip + 8)
		          typ.TypeID = m.UInt32Value(ip + 12)
		          Types.Value(m.UInt32Value(ip + 4)) = typ
		          
		        case 21 // ***** OpTypeFunction ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.TypeFunction)
		          typ = new ZocleeShade.SPIRVType
		          typ.Type = SPIRVTypeEnum.Function_
		          typ.ReturnTypeID = m.UInt32Value(ip + 8)
		          tempIP = ip + 12
		          upperBound = ip + (m.UInt16Value(ip + 2) * 4)
		          while tempIP < upperBound
		            typ.ParmTypeID.Append m.UInt32Value(tempIP)
		            tempIP = tempIP + 4
		          wend
		          Types.Value(m.UInt32Value(ip + 4)) = typ
		          
		        case 50 // ***** OpDecorate ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.Decorate)
		          dec = new ZocleeShade.SPIRVDecoration
		          dec.TargetID = m.UInt32Value(ip + 4)
		          dec.Decoration = m.UInt32Value(ip + 8)
		          select case dec.Decoration
		            ' Stream, Location, Component, Index, Binding, DescriptorSet, Offset, Alignment, XfbBuffer, Stride,
		            ' Built-In, FuncParamAttr, FP Rouding Mode, FP Fast Math Mode, Linkage Type, SpecId
		          case 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44
		            tempIP = ip + 12
		            upperBound = ip + (m.UInt16Value(ip + 2) * 4)
		            while tempIP < upperBound
		              dec.ExtraOperands.Append m.UInt32Value(tempIP)
		              tempIP = tempIP + 4
		            wend
		          end select
		          Decorations.Append dec
		          
		        case 54 // ***** OpName ***************************************************
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.Name)
		          Names.Value(m.UInt32Value(ip + 4)) = m.CString(ip + 8)
		          if (m.UInt32Value(ip + 4) >= Bound) then
		            Errors.Append ("ERROR [" + Str(ip + 2) + "]: Target ID out of bounds.")
		          end if
		          
		        case else
		          op = new ZocleeShade.SPIRVOpcode(SPIRVOpcodeTypeEnum.Unknown)
		          unknown = unknown + 1
		          
		        end select
		        
		        ' store opcode
		        
		        op.Offset = ip
		        Opcodes.Append op
		        
		        if m.UInt16Value(ip + 2) = 0 then
		          Errors.Append ("ERROR [" + Str(ip + 2) + "]: Word count of zero.")
		          ip = moduleUB + 1
		        else
		          ip = ip + (m.UInt16Value(ip + 2) * 4)
		        end if
		        
		      wend
		      
		      if unknown > 0 then
		        Errors.Append "ERROR: " + Str(unknown) + " unknown opcodes."
		      end if
		      
		    end if
		    
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
