$newFooter = @"
    <footer class="footer">
        <!-- Top Bar: Green -->
        <div class="footer-top">
            <div class="container d-flex flex-wrap justify-content-between align-items-center py-3">
                <div class="contact-item">
                    <i class="bi bi-envelope-fill me-2"></i>
                    <span>info@villadesanfrancisco.hn</span>
                </div>
                <div class="social-links d-flex gap-3">
                    <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-twitter-x"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
                </div>
                <div class="contact-item">
                    <i class="bi bi-telephone-fill me-2"></i>
                    <span>+504 2552-1588</span>
                </div>
            </div>
        </div>

        <!-- Main Footer: White -->
        <div class="footer-main bg-white py-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-4 mb-4 mb-lg-0">
                        <div class="footer-logos d-flex align-items-center gap-4">
                            <img src="../../assets/images/Logo.png" alt="Logo Municipal" height="70">
                            <!-- Placeholder for second logo -->
                            <div style="width: 1px; height: 50px; background: #eee;"></div>
                            <img src="../../assets/images/Logo.png" alt="Logo Ciudad" height="60"
                                style="filter: grayscale(1); opacity: 0.7;">
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="row">
                            <div class="col-6 col-md-3 ms-auto">
                                <h6 class="hashtag-title text-green">HASHTAG FACEBOOK</h6>
                                <ul class="list-unstyled hashtag-list">
                                    <li>#VillaDeSanFrancisco</li>
                                    <li>#VSF</li>
                                    <li>#CiudadDeEmprendedores</li>
                                    <li>#VSFCiudadEnOrden</li>
                                    <li>#YoSoy0827</li>
                                </ul>
                            </div>
                            <div class="col-6 col-md-3">
                                <h6 class="hashtag-title text-yellow">HASHTAG INSTAGRAM</h6>
                                <ul class="list-unstyled hashtag-list">
                                    <li>#VillaDeSanFrancisco</li>
                                    <li>#VSF</li>
                                    <li>#CiudadDeEmprendedores</li>
                                    <li>#VSFCiudadEnOrden</li>
                                    <li>#YoSoy0827</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bottom Bar: Light Green -->
        <div class="footer-bottom py-3">
            <div class="container text-center">
                <p class="mb-0 small text-muted">© 2026 Municipalidad de Villa de San Francisco. Todos los derechos
                    reservados.</p>
            </div>
        </div>
    </footer>
"@

$pagesDir = "c:\Users\aplic\Documents\Pajina guep\pages"
$files = Get-ChildItem -Path $pagesDir -Filter *.html -Recurse

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # regex to find the footer block
    $regex = '(?s)<footer class="footer">.*?</footer>'
    
    if ($content -match $regex) {
        $newContent = $content -replace $regex, $newFooter
        Set-Content -Path $file.FullName -Value $newContent -Encoding utf8
        Write-Host "Updated footer in $($file.FullName)"
    }
    else {
        Write-Host "Footer not found in $($file.FullName)"
    }
}
