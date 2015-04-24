#tag Module
Protected Module SPIRVUtil
	#tag Method, Flags = &h0
		Sub RemoveDebugInstructions(moduleBinary As MemoryBlock)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim reduceSize As UInt32
		  Dim ip As UInt32
		  Dim moduleUB As UInt32
		  
		  reduceSize = 0
		  moduleUB = moduleBinary.Size - 1
		  
		  //  instructions
		  
		  ip = 20
		  while ip <= moduleUB
		    
		    select case ModuleBinary.UInt16Value(ip)
		      
		    case 1 // ***** OpSource ***************************************************
		      reduceSize = reduceSize + (moduleBinary.UInt16Value(ip + 2) * 4)
		      
		    case 2 // ***** OpSourceExtension ***************************************************
		      reduceSize = reduceSize + (moduleBinary.UInt16Value(ip + 2) * 4)
		      
		    case 54 // ***** OpName ***************************************************
		      reduceSize = reduceSize + (moduleBinary.UInt16Value(ip + 2) * 4)
		      
		    case 55 // ***** OpMemberName ***************************************************
		      reduceSize = reduceSize + (moduleBinary.UInt16Value(ip + 2) * 4)
		      
		    case 56 // ***** OpString ***************************************************
		      reduceSize = reduceSize + (moduleBinary.UInt16Value(ip + 2) * 4)
		      
		    case 57 // ***** OpLine ***************************************************
		      reduceSize = reduceSize + (moduleBinary.UInt16Value(ip + 2) * 4)
		      
		    end select
		    
		    if (ip + 2) >= moduleBinary.Size then
		      ip = moduleUB + 1
		    elseif moduleBinary.UInt16Value(ip + 2) = 0 then
		      ip = moduleUB + 1
		    else
		      ip = ip + (moduleBinary.UInt16Value(ip + 2) * 4)
		    end if
		  wend
		  
		  // todo
		  break
		  
		  if reduceSize > 0 then
		    break
		  end if
		End Sub
	#tag EndMethod


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
