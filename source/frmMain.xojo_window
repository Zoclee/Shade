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
   MenuBar         =   1232599039
   MenuBarVisible  =   True
   MinHeight       =   400
   MinimizeButton  =   True
   MinWidth        =   600
   Placement       =   0
   Resizeable      =   True
   Title           =   "{Zoclee}™ Shade"
   Visible         =   True
   Width           =   600
   Begin PushButton cmdOpen
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Open"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
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
      Height          =   212
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
      Top             =   54
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   301
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
      Height          =   102
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
      Top             =   278
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
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   "70,70"
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
      Height          =   212
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Offset	Result ID	Instruction Text"
      Italic          =   False
      Left            =   333
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
      Top             =   54
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   247
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Me.Title = "{Zoclee}™ Shade v" + Str(App.MajorVersion) + "." + Str(App.MinorVersion)+ "." + Str(App.BugVersion)
		  Me.Maximize
		  
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events cmdOpen
	#tag Event
		Sub Action()
		  Dim f As FolderItem
		  Dim dlg As new OpenDialog
		  Dim m As MemoryBlock
		  Dim i As Integer
		  Dim readStream As BinaryStream
		  Dim allType As New FileType
		  Dim spirvType As New FileType
		  
		  // configure file types
		  
		  allType.Name = "All files"
		  allType.Extensions = ".*"
		  
		  spirvType.Name = "SPIR-V Binary Modules"
		  spirvType.MacType = "SPIRV"
		  spirvType.MacCreator = "spirv"
		  spirvType.Extensions = ".spirv"
		  
		  dlg.Filter = spirvType + allType
		  
		  ' select file
		  
		  f = dlg.ShowModal()
		  
		  if f <> nil then
		    
		    lstErrors.DeleteAllRows
		    lstInfo.DeleteAllRows
		    lstInstructions.DeleteAllRows
		    
		    ' read file into memoryblock
		    
		    readStream = BinaryStream.Open(f)
		    readStream.LittleEndian = True
		    
		    m = new MemoryBlock(f.Length)
		    m = readStream.Read(f.Length)
		    
		    readStream.Close
		    
		    App.VM.LoadModule(m)
		    
		    // display errors
		    
		    if App.VM.Errors.Ubound >= 0 then
		      i = 0
		      while i <= App.VM.Errors.Ubound
		        lstErrors.AddRow App.VM.Errors(i)
		        i = i + 1
		      wend
		    end if
		    
		    // display info
		    
		    lstInfo.AddRow "SPIR-V Version Number"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Version)
		    
		    lstInfo.AddRow "Generator Magic Number"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.GeneratorMagicNumber)
		    
		    lstInfo.AddRow "Bound"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Bound)
		    
		    lstInfo.AddRow "Opcodes"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Opcodes.Ubound + 1)
		    
		    lstInfo.AddRow "Source Language"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = ZocleeShade.SPIRVDescribeSourceLanguage(App.VM.SourceLanguage)
		    
		    lstInfo.AddRow "Source Version"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.SourceVersion)
		    
		    lstInfo.AddRow "Entry Points"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.EntryPoints.Ubound + 1)
		    
		    lstInfo.AddRow "Addressing Model"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = ZocleeShade.SPIRVDescribeAddressingModel(App.VM.AddressingModel)
		    
		    lstInfo.AddRow "Memory Model"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = ZocleeShade.SPIRVDescribeMemoryModel(App.VM.MemoryModel)
		    
		    lstInfo.AddRow "Names"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Names.Keys.Ubound + 1)
		    
		    lstInfo.AddRow "Decorations"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Decorations.Ubound + 1)
		    
		    lstInfo.AddRow "Types"
		    lstInfo.Cell(lstInfo.LastIndex, 1) = Str(App.VM.Types.Keys.Ubound + 1)
		    
		    // display instructions
		    
		    i = 0
		    while i <= App.VM.Opcodes.Ubound
		      lstInstructions.AddRow Str(App.VM.Opcodes(i).Offset)
		      if App.VM.Opcodes(i).ResultID > 0 then
		        lstInstructions.Cell(lstInstructions.LastIndex, 1) = Str(App.VM.Opcodes(i).ResultID)
		      end if
		      lstInstructions.Cell(lstInstructions.LastIndex, 2) = App.VM.Opcodes(i).InstructionText
		      lstInstructions.RowTag(lstInstructions.LastIndex) = App.VM.Opcodes(i)
		      i = i + 1
		    wend
		    
		  end if
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
