$files = Get-ChildItem -Path "c:\Users\aplic\Documents\Pajina guep" -Filter *.html -Recurse

function Fix-File {
    param($FilePath)
    $content = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::UTF8)
    
    # Use -replace for regex-like string replacement which is more flexible in PS
    # 'Â' is \u00c2, '©' is \u00a9
    $corruptedCopyright = [char]0xc2 + [char]0xa9
    $content = $content -replace [regex]::Escape($corruptedCopyright), '&copy;'
    
    # Also fix individual copyright symbol
    $content = $content -replace [char]0xa9, '&copy;'

    [System.IO.File]::WriteAllText($FilePath, $content, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Fixed copyright in $($FilePath)"
}

foreach ($file in $files) {
    Fix-File -FilePath $file.FullName
}
