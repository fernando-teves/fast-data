# ============================================
# Fast Data for AI — Deploy Script (PowerShell)
# Engineering do Brasil
# ============================================

# Configurações — ajuste conforme necessário
$REPO_URL = "https://github.com/fernando-teves/fast-data.git"  # URL do repositório Git
$BRANCH   = "main"
$DEPLOY_DIR = "C:\deploy\fast-data"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Fast Data for AI — Deploy" -ForegroundColor Cyan
Write-Host "  Engineering do Brasil" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Verificar se Git está instalado
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "[ERRO] Git não encontrado. Instale o Git e tente novamente." -ForegroundColor Red
    exit 1
}

# Navegar para a pasta
Set-Location $DEPLOY_DIR
Write-Host "[1/5] Pasta: $DEPLOY_DIR" -ForegroundColor Yellow

# Verificar se já é um repo Git
if (-not (Test-Path ".git")) {
    Write-Host "[2/5] Inicializando repositório Git..." -ForegroundColor Yellow
    git init
    git remote add origin $REPO_URL
} else {
    Write-Host "[2/5] Repositório Git já inicializado." -ForegroundColor Green
}

# Listar arquivos
Write-Host ""
Write-Host "Arquivos para deploy:" -ForegroundColor Cyan
Get-ChildItem -Name *.html, *.md
Write-Host ""

# Stage, commit e push
Write-Host "[3/5] Adicionando arquivos..." -ForegroundColor Yellow
git add .

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
$commitMsg = "deploy: Fast Data for AI — $timestamp"

Write-Host "[4/5] Commit: $commitMsg" -ForegroundColor Yellow
git commit -m $commitMsg

Write-Host "[5/5] Push para $BRANCH..." -ForegroundColor Yellow
git push -u origin $BRANCH

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  Deploy concluído com sucesso!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Verifique em: $REPO_URL" -ForegroundColor Cyan
Write-Host ""
