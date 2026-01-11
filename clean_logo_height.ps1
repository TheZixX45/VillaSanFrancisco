$files = Get-ChildItem -Path "c:\Users\aplic\Documents\Pajina guep" -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    # Use (?s) to allow . to match newlines
    $newContent = $content -replace '(?s)(<a[^>]*class="navbar-brand logo-container"[^>]*>.*?<img[^>]*) height="\d+"([^>]*>)', '$1$2'
    
    if ($content -ne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -Encoding utf8
        Write-Host "Removed height attribute from logo in $($file.FullName)"
    }
    else {
        # Check if it's because of different formatting
        Write-Host "No change for $($file.FullName)"
    }
}
