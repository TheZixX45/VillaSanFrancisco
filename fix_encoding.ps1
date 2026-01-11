$files = Get-ChildItem -Path "c:\Users\aplic\Documents\Pajina guep" -Filter *.html -Recurse

function Fix-File {
    param($FilePath)
    $content = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::UTF8)
    
    # We use hex codes for the patterns to avoid PowerShell encoding bugs
    
    # Pattern fixes for corrupted UTF-8 shown as Latin1
    # 'Ã³' (\u00c3\u00b3) -> &oacute;
    # 'Ã­' (\u00c3\u00ad) -> &iacute;
    # 'Ã©' (\u00c3\u00a9) -> &eacute;
    # 'Ã¡' (\u00c3\u00a1) -> &aacute;
    # 'Ãº' (\u00c3\u00ba) -> &uacute;
    # 'Ã±' (\u00c3\u00b1) -> &ntilde;
    # 'Â¿' (\u00c2\u00bf) -> &iquest;
    # 'Ã©' (\u00c3\u00a9) -> &eacute;
    # 'Ã³' (\u00c3\u00b3) -> &oacute;
    
    $rules = @(
        @{ pattern = [char]0xc3 + [char]0xad; replacement = '&iacute;' }
        @{ pattern = [char]0xc3 + [char]0xb3; replacement = '&oacute;' }
        @{ pattern = [char]0xc3 + [char]0xa9; replacement = '&eacute;' }
        @{ pattern = [char]0xc3 + [char]0xa1; replacement = '&aacute;' }
        @{ pattern = [char]0xc3 + [char]0xba; replacement = '&uacute;' }
        @{ pattern = [char]0xc3 + [char]0xb1; replacement = '&ntilde;' }
        @{ pattern = [char]0xc2 + [char]0xbf; replacement = '&iquest;' }
        @{ pattern = [char]0xc3 + [char]0x81; replacement = '&Aacute;' }
        @{ pattern = [char]0xc3 + [char]0x89; replacement = '&Eacute;' }
        @{ pattern = [char]0xc3 + [char]0x8d; replacement = '&Iacute;' }
        @{ pattern = [char]0xc3 + [char]0x93; replacement = '&Oacute;' }
        @{ pattern = [char]0xc3 + [char]0x9a; replacement = '&Uacute;' }
        @{ pattern = [char]0xc3 + [char]0x91; replacement = '&Ntilde;' }
    )

    foreach ($rule in $rules) {
        $content = $content.Replace($rule.pattern, $rule.replacement)
    }

    # Also fix individual accented characters that might be there
    $map = @{
        [char]0xe1 = '&aacute;'
        [char]0xe9 = '&eacute;'
        [char]0xed = '&iacute;'
        [char]0xf3 = '&oacute;'
        [char]0xfa = '&uacute;'
        [char]0xf1 = '&ntilde;'
        [char]0xc1 = '&Aacute;'
        [char]0xc9 = '&Eacute;'
        [char]0xcd = '&Iacute;'
        [char]0xd3 = '&Oacute;'
        [char]0xda = '&Uacute;'
        [char]0xd1 = '&Ntilde;'
    }

    foreach ($key in $map.Keys) {
        $content = $content.Replace($key.ToString(), $map[$key])
    }

    [System.IO.File]::WriteAllText($FilePath, $content, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Processed $($FilePath)"
}

foreach ($file in $files) {
    Fix-File -FilePath $file.FullName
}
