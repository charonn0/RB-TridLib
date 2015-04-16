# RB-TridLib
Realbasic glue code for TridLib

The `TridLib` module provides an extension method for folderitems:

```vbnet
Function TrIDTypes(Extends f As FolderItem) As TridLib.FileType()
```

To get a list of probable file types for a folderitem, use this method to get an array of `TridLib.FileType` objects.
These objects have no methods and are merely containers for the filetype data. 

For example:
```vbnet
  Dim item As FolderItem ' assume a valid FolderItem
  Dim t() As TridLib.FileType = item.TrIDTypes()
  For Each type As TridLib.FileType In t
    MsgBox(type.Description + "(" + type.Extension + ")" + Format(type.Points, "###,###,##0.0#"))
  Next
  ```
