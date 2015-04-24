#tag Menu
Begin Menu mnuMain
   Begin MenuItem mnuFile
      SpecialMenu = 0
      Text = "File"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem mnuOpen
         SpecialMenu = 0
         Text = "Open..."
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem mnuFileSep1
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem mnuSave
         SpecialMenu = 0
         Text = "Save"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem mnuSaveAs
         SpecialMenu = 0
         Text = "Save As..."
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem mnuExit
         SpecialMenu = 0
         Text = "E&xit"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem mnuTools
      SpecialMenu = 0
      Text = "Tools"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem mnuVacuumOpcodes
         SpecialMenu = 0
         Text = "Vacuum Opcodes"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
   End
   Begin MenuItem mnuHelp
      SpecialMenu = 0
      Text = "Help"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem mnuAbout
         SpecialMenu = 0
         Text = "About..."
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
   End
End
#tag EndMenu
