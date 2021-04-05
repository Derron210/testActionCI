#$solutions = dir -Path .\ -Filter *.sln -Recurse | %{$_.FullName}

$currentPath = (Get-Item .).FullName

function Find-Solution {
	param(
        $file
		)
            
    $dir =  ([system.io.fileinfo]$file).Directory     
        
    while ($dir.FullName -ne $currentPath) {
       $dirName = $dir.FullName 
       $projects = dir -Path $dirName -Filter *.csproj -Recurse | %{$_.FullName}
       if ($projects.length -eq 0) {
           $dir = $dir.Parent
       } else {
           write-host "FOUND"
       }
     }
       
    #([system.io.fileinfo]$File).DirectoryName
    #write-host JKKK   ([system.io.fileinfo]$file).DirectoryName  
}

$changedFiles = git diff --name-only HEAD~1 HEAD

forEach ($changedFile in $changedFiles) {
  $file =  $($currentPath + "\" + $changedFile.Replace("/", "\"))
  Find-Solution $file
  #& "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\msbuild.exe" /m /p:Configuration=Release $solution
}