#tag Class
Protected Class EntryPoint
	#tag Method, Flags = &h0
		Function GetFunctionParameters(vm As SPIRV.VirtualMachine) As Dictionary
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim i As Integer
		  Dim searchParms As Boolean
		  Dim parms As Dictionary
		  Dim op As SPIRV.Opcode
		  Dim parmCount As Integer
		  
		  if VM.OpcodeLookup.HasKey(EntryPointID) then
		    op = VM.OpcodeLookup.Value(EntryPointID)
		    if op.Type = SPIRV.OpcodeEnum.OpFunction then
		      searchParms = True
		      i = op.Index
		      parmCount = 0
		      while searchParms
		        i = i + 1
		        if i > VM.Opcodes.Ubound then
		          searchParms = false
		        elseif VM.Opcodes(i).Type <> SPIRV.OpcodeEnum.OpFunctionParameter then
		          searchParms = false
		        else
		          if parms = nil then
		            parms = new Dictionary()
		          end if
		          if VM.Names.HasKey(VM.Opcodes(i).ResultID) then
		            parms.Value(VM.Names.Value(VM.Opcodes(i).ResultID)) = inferParamterTypeID(vm, vm.Opcodes(i).ResultTypeID)
		          else
		            parms.Value("_" + Str(parmCount)) = inferParamterTypeID(vm, vm.Opcodes(i).ResultTypeID)
		          end if
		          parmCount = parmCount + 1
		        end if
		      wend
		    end if
		  end if
		  
		  return parms
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function inferParamterTypeID(vm As SPIRV.VirtualMachine, typeID As UInt32) As UInt32
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim result As UInt32
		  Dim ptrType As SPIRV.Type
		  
		  result = 0
		  
		  if vm.Types.HasKey(typeID) then
		    ptrType = vm.Types.Value(typeID)
		    if ptrType.Type = SPIRV.TypeEnum.Pointer then
		      result = ptrType.TypeID
		    else
		      break
		    end if
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		EntryPointID As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0
		ExecutionModel As UInt32
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
