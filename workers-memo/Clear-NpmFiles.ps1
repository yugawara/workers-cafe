function Clear-NpmFiles{
    remove-item -force -recurse "$env:APPDATA\Local\npm-cache\"
    remove-item -force -recurse "$env:APPDATA\Roaming\\npm"
}