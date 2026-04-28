# ============================================
# Fast Data for AI — Deploy Script (PowerShell)
# Engineering do Brasil
# ============================================

$REPO_NAME = "fast-data"
$GITHUB_USER = "fernando-teves"
$BRANCH = "main"
$DEPLOY_DIR = "C:\deploy\fast-data"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Fast Data for AI - Deploy" -ForegroundColor Cyan
Write-Host "  Engineering do Brasil" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[ERRO] Git nao encontrado." -ForegroundColor Red
    exit 1
}

Set-Location $DEPLOY_DIR

Write-Host "[1/5] Arquivos em $DEPLOY_DIR" -ForegroundColor Yellow
Write-Host ""
Write-Host "  index.html        - Hub" -ForegroundColor White
Write-Host "  onepage.html      - One-page comercial" -ForegroundColor White
Write-Host "  comparativo.html  - Comparativo" -ForegroundColor White
Write-Host "  simulador.html    - Simulador" -ForegroundColor White
Write-Host "  arquitetura.html  - Arquitetura" -ForegroundColor White
Write-Host ""

if (-not (Test-Path ".git")) {
    Write-Host "[2/5] Inicializando repositorio Git..." -ForegroundColor Yellow
    git init
    git branch -M $BRANCH
    git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
} else {
    Write-Host "[2/5] Repo Git ja inicializado." -ForegroundColor Green
    git remote set-url origin "https://github.com/$GITHUB_USER/$REPO_NAME.git" 2>$null
}

Write-Host "[3/5] Adicionando arquivos..." -ForegroundColor Yellow
git add .

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$commitMsg = "deploy: Fast Data for AI - $timestamp"
Write-Host "[4/5] Commit: $commitMsg" -ForegroundColor Yellow
git commit -m $commitMsg

Write-Host "[5/5] Push para GitHub..." -ForegroundColor Yellow
git push -u origin $BRANCH

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  Deploy concluido!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Repo: https://github.com/$GITHUB_USER/$REPO_NAME" -ForegroundColor Cyan
Write-Host "  Site: https://$GITHUB_USER.github.io/$REPO_NAME/" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Hub:          /$REPO_NAME/" -ForegroundColor White
Write-Host "  One-page:     /$REPO_NAME/onepage.html" -ForegroundColor White
Write-Host "  Comparativo:  /$REPO_NAME/comparativo.html" -ForegroundColor White
Write-Host "  Simulador:    /$REPO_NAME/simulador.html" -ForegroundColor White
Write-Host "  Arquitetura:  /$REPO_NAME/arquitetura.html" -ForegroundColor White
Write-Host ""