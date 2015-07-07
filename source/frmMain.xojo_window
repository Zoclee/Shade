#tag Window
Begin Window frmMain
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1556432895
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   True
   MinWidth        =   600
   Placement       =   0
   Resizeable      =   True
   Title           =   "{Zoclee}™ Shade"
   Visible         =   True
   Width           =   600
   Begin Listbox lstInfo
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   False
      ColumnWidths    =   "60%,40%"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   199
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   241
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Listbox lstErrors
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   149
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      RequiresSelection=   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   231
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Listbox lstInstructions
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   4
      ColumnsResizable=   True
      ColumnWidths    =   "50,110,120"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   199
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Offset	Result ID	Result Type	Instruction"
      Italic          =   False
      Left            =   273
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   307
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin MainToolbar toolMain
      Enabled         =   True
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockedInPosition=   False
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   0
      Visible         =   True
      Width           =   100
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Self.Title = "{Zoclee}™ Shade v" + Str(App.MajorVersion) + "." + Str(App.MinorVersion)+ "." + Str(App.BugVersion)
		  Self.Maximize
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function mnuAbout() As Boolean Handles mnuAbout.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			frmAbout.ShowModal()
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function mnuExit() As Boolean Handles mnuExit.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			Quit()
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function mnuFind() As Boolean Handles mnuFind.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			frmFind.Show()
			frmFind.txtFind.SetFocus()
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function mnuOpen() As Boolean Handles mnuOpen.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			actionOpen()
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function mnuReleaseNotes() As Boolean Handles mnuReleaseNotes.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			frmReleaseNotes.ShowModal()
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function mnuSave() As Boolean Handles mnuSave.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			actionSave()
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function mnuSaveAs() As Boolean Handles mnuSaveAs.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			Dim dlg As new SaveAsDialog
			Dim spirvType As new FileType
			Dim f As FolderItem
			
			if CurrentFile <> nil then
			
			spirvType.Name = "SPIR-V Binary Modules"
			spirvType.MacType = "SPV"
			spirvType.MacCreator = "spv"
			spirvType.Extensions = ".spv"
			
			dlg.Filter = spirvType
			
			f = dlg.ShowModal()
			
			if f <> nil then
			
			CurrentFile = f
			actionSave()
			Self.Title = "{Zoclee}™ Shade v" + Str(App.MajorVersion) + "." + Str(App.MinorVersion)+ "." + Str(App.BugVersion) + " - " + CurrentFile.NativePath
			
			end if
			
			end if
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function mnuUndo() As Boolean Handles mnuUndo.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			actionUndo()
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function mnuVacuumOpcodes() As Boolean Handles mnuVacuumOpcodes.Action
			' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
			' www.zoclee.com/shade
			
			actionVacuumOpcodes()
			
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub actionOpen()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim f As FolderItem
		  Dim dlg As new OpenDialog
		  Dim readStream As BinaryStream
		  Dim allType As New FileType
		  Dim spirvType As New FileType
		  
		  // configure file types
		  
		  allType.Name = "All files"
		  allType.Extensions = ".*"
		  
		  spirvType.Name = "SPIR-V Binary Modules"
		  spirvType.MacType = "SPV"
		  spirvType.MacCreator = "spv"
		  spirvType.Extensions = ".spv"
		  
		  dlg.Filter = spirvType + allType
		  
		  ' select file
		  
		  f = dlg.ShowModal()
		  
		  if f <> nil then
		    
		    CurrentFile = f
		    
		    ' read file into memoryblock
		    
		    readStream = BinaryStream.Open(f)
		    readStream.LittleEndian = True
		    
		    SPIRVModule = new MemoryBlock(f.Length)
		    SPIRVModule = readStream.Read(f.Length)
		    
		    readStream.Close
		    
		    Self.Title = "{Zoclee}™ Shade v" + Str(App.MajorVersion) + "." + Str(App.MinorVersion)+ "." + Str(App.BugVersion) + " - " + CurrentFile.NativePath
		    
		    refreshModule()
		    
		    mnuFind.AutoEnable = True
		    mnuSave.AutoEnable = True
		    mnuSaveAs.AutoEnable = True
		    mnuUndo.AutoEnable = False
		    mnuVacuumOpcodes.AutoEnable = True
		    toolMain.Item(2).Enabled = True // enable save menu
		    toolMain.Item(4).Enabled = True // enable run menu
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub actionRun()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim n As Integer
		  Dim ep As SPIRV.EntryPoint
		  Dim parmList As Dictionary
		  Dim data As Dictionary
		  
		  if App.VM.EntryPoints.Count <= 0 then
		    n = MsgBox("No entry points found in module.", 16, "Run Module")
		    
		  elseif App.VM.EntryPoints.Count = 1 then
		    
		    // start with only available entry point
		    
		    ep = App.VM.EntryPoints.Value(App.VM.EntryPoints.Key(0))
		    
		  else
		    // TODO: select entry point
		    break
		    
		  end if
		  
		  // did we find a valid entrypoint?
		  if ep <> nil then
		    
		    // collect parameter data if needed
		    
		    parmList = ep.GetFunctionParameters(App.VM)
		    
		    // invoke entrypoint
		    
		    App.VM.Run(ep.EntryPointID, data)
		    
		    // display errors 
		    
		    displayErrors()
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub actionSave()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim bs As BinaryStream
		  
		  if CurrentFile <> nil then
		    
		    bs = BinaryStream.Create(CurrentFile, True) // Overwrite if exists
		    bs.Write(SPIRVModule)
		    bs.Close
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub actionUndo()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  if UndoStack.Ubound >= 0 then
		    SPIRVModule = UndoStack(UndoStack.Ubound)
		    UndoStack.Remove(UndoStack.Ubound)
		    refreshModule()
		  end if
		  
		  if UndoStack.Ubound < 0 then
		    mnuUndo.AutoEnable = False
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub actionVacuumOpcodes()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim prevMod As MemoryBlock
		  
		  prevMod = SPIRVModule.Copy()
		  
		  SPIRVUtil.RemoveDebugInstructions(SPIRVModule)
		  if (prevMod.Size <> SPIRVModule.Size) then
		    UndoStack.Append prevMod
		    mnuUndo.AutoEnable = True
		  end if
		  refreshModule()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub displayErrors()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim i As Integer
		  
		  lstErrors.DeleteAllRows()
		  
		  i = 0
		  while i <= App.VM.Errors.Ubound
		    lstErrors.AddRow App.VM.Errors(i)
		    i = i + 1
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub refreshModule()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim i As Integer
		  Dim op As SPIRV.Opcode
		  Dim tmpStr As String
		  
		  lstErrors.DeleteAllRows
		  lstInfo.DeleteAllRows
		  lstInstructions.DeleteAllRows
		  
		  App.VM.LoadModule(SPIRVModule)
		  
		  // display errors
		  
		  displayErrors()
		  
		  // display info
		  
		  lstInfo.AddRow "Errors"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Errors.Ubound + 1)
		  
		  lstInfo.AddRow "SPIR-V Version Number"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Version)
		  
		  lstInfo.AddRow "Generator Magic Number"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.GeneratorMagicNumber)
		  
		  lstInfo.AddRow "Bound"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Bound)
		  
		  lstInfo.AddRow "Source Language"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = SPIRV.SPIRVDescribeSourceLanguage(App.VM.SourceLanguage)
		  
		  lstInfo.AddRow "Source Version"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.SourceVersion)
		  
		  lstInfo.AddRow "Entry Points"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.EntryPoints.Count)
		  
		  lstInfo.AddRow "Addressing Model"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = SPIRV.SPIRVDescribeAddressingModel(App.VM.AddressingModel)
		  
		  lstInfo.AddRow "Memory Model"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = SPIRV.SPIRVDescribeMemoryModel(App.VM.MemoryModel)
		  
		  lstInfo.AddRow "Opcodes"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Opcodes.Ubound + 1)
		  
		  lstInfo.AddRow "Names"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Names.Keys.Ubound + 1)
		  
		  lstInfo.AddRow "Decorations"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Decorations.Ubound + 1)
		  
		  lstInfo.AddRow "Types"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Types.Keys.Ubound + 1)
		  
		  lstInfo.AddRow "Constants"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Constants.Keys.Ubound + 1)
		  
		  lstInfo.AddRow "Functions"
		  lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Functions.Keys.Ubound + 1)
		  
		  // display instructions
		  
		  lstInstructions.ColumnAlignment(0) = Listbox.AlignRight
		  lstInstructions.ColumnAlignment(1) = Listbox.AlignRight
		  
		  i = 0
		  while i <= App.VM.Opcodes.Ubound
		    op = App.VM.Opcodes(i)
		    lstInstructions.AddRow Str(op.Offset)
		    if op.ResultID > 0 then
		      tmpStr = Str(op.ResultID)
		      if App.VM.Names.HasKey(op.ResultID) then
		        if Trim(App.VM.Names.Value(op.ResultID)) <> "" then
		          tmpStr = tmpStr + "("
		          tmpStr = tmpStr + Trim(App.VM.Names.Value(op.ResultID))
		          tmpStr = tmpStr + ")"
		        end if
		      end if
		      tmpStr = tmpStr + ":"
		      lstInstructions.Cell(lstInstructions.LastIndex, 1) = tmpStr
		    end if
		    lstInstructions.Cell(lstInstructions.LastIndex, 2) = op.ResultType
		    lstInstructions.Cell(lstInstructions.LastIndex, 3) = op.InstructionText
		    lstInstructions.RowTag(lstInstructions.LastIndex) = op
		    i = i + 1
		  wend
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CurrentFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		SPIRVModule As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h0
		UndoStack() As MemoryBlock
	#tag EndProperty


#tag EndWindowCode

#tag Events lstErrors
	#tag Event
		Sub Change()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim tmpStr As String
		  Dim pos As Integer
		  Dim offset As UInt32
		  Dim i As Integer
		  Dim op As SPIRV.Opcode
		  Dim found As Boolean
		  
		  if lstErrors.ListIndex >= 0 then
		    
		    tmpStr = lstErrors.List(lstErrors.ListIndex)
		    if Left(tmpStr, 7) = "ERROR [" then
		      pos = Instr(7, tmpStr, "]")
		      if pos > 0 then
		        offset = Val(Trim(Mid(tmpStr, 8, pos - 8)))
		        
		        i = 0
		        found = false
		        while (i < lstInstructions.ListCount) and not found
		          op = lstInstructions.RowTag(i)
		          if op.Offset = offset then
		            lstInstructions.ListIndex = i
		            found = true
		          else
		            i = i + 1
		          end if
		        wend
		        
		      end if
		    end if
		    
		  end if
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lstInstructions
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Dim op As SPIRV.Opcode
		  
		  op = Me.RowTag(row)
		  
		  if op.HasErrors then
		    g.ForeColor = &caa0000
		  elseif App.VM.Types.HasKey(op.ResultID) then
		    g.ForeColor = &c007700
		  elseif App.VM.Constants.HasKey(op.ResultID) then
		    g.ForeColor = &c6b2b83
		  end if
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  Me.ColumnSortDirection(0)=0
		  Me.ColumnSortDirection(1)=0
		  Me.ColumnSortDirection(2)=0
		  Me.ColumnSortDirection(3)=0
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events toolMain
	#tag Event
		Sub Action(item As ToolItem)
		  ' {Zoclee}™ Shade is an open source initiative by {Zoclee}™.
		  ' www.zoclee.com/shade
		  
		  select case item.Name
		    
		  case "toolOpen"
		    actionOpen
		    
		  case "toolRun"
		    actionRun
		    
		  case "toolSave"
		    actionSave
		    
		  end select
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Appearance"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"10 - Drawer Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
