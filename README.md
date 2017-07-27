# RB-TridLib
Realbasic glue code for [TridLib](http://mark0.net/code-tridlib-e.html), which is a tool for guessing file formats by analyzing patterns in the file data. TridLib is available on Win32 only.
  
## Prerequisites
The `TridLib.dll` and `TridDefs.trd` files must be located in the same directory as your app's executable.
  
## Basic usage
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

## Advanced usage
The `TridLib` module has a number of protected functions which allow low-level access to TridLib should you need to do something not supported by the `TrIDTypes` method discussed above. These methods are:

* `Analyze() As Integer`: Performs the analysis on a previously submitted file.
* `DefCount() As Integer`: The total number of file format definitions known.
* `GetInfo(InfoType As Integer, InfoIndex As Integer, Output As MemoryBlock = Nil) As Integer`: Retrieves data about the most recently analyzed file.
* `LoadDefsPack(Directory As FolderItem) As Integer`: Loads the file named `TridDefs.trd` from the specified directory. Returns the number of definitions loaded.
* `SetDefsPack(RawDefData As MemoryBlock) As Integer`: Loads file format definitions from memory. This is only available in paid versions of `TridLib.dll`. Returns the number of definitions loaded.
* `SubmitFile(File As FolderItem) As Integer`: Prepares a new file for analysis. 
* `Version() As Integer`: The version number of `TridLib.dll`.
