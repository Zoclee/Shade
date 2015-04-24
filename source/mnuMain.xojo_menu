#tag Menu
Begin Menu mnuMain
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
