$UserName="jeev20"
gitfolio build $UserName --theme dark  --sort star --order "des"
gitfolio update

Get-ChildItem -Path "./dist" | Move-Item -Destination "./jeev20.github.io" -Force
Remove-Item "./dist" -Confirm:$false -Force