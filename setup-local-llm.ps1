# Local LLM Setup Script
# Installs: Ollama + Qwen3-30B-A3B + Open Interpreter
# Requirements: RTX 3090 (24GB VRAM), Windows

Write-Host "=== Local LLM Setup ===" -ForegroundColor Cyan

# 1. Install Ollama
Write-Host "`n[1/3] Installing Ollama..." -ForegroundColor Yellow
$ollamaInstalled = Get-Command ollama -ErrorAction SilentlyContinue
if ($ollamaInstalled) {
    Write-Host "Ollama already installed, skipping." -ForegroundColor Green
} else {
    $installer = "$env:TEMP\ollama-setup.exe"
    Invoke-WebRequest -Uri "https://ollama.com/download/OllamaSetup.exe" -OutFile $installer
    Start-Process -FilePath $installer -Wait
    Write-Host "Ollama installed." -ForegroundColor Green
}

# 2. Pull Qwen3 model
Write-Host "`n[2/3] Pulling Qwen3-30B-A3B model (this will take a while)..." -ForegroundColor Yellow
ollama pull qwen3:30b-a3b
Write-Host "Model ready." -ForegroundColor Green

# 3. Install Python dependencies
Write-Host "`n[3/3] Installing Open Interpreter + data libraries..." -ForegroundColor Yellow
$pipInstalled = Get-Command pip -ErrorAction SilentlyContinue
if (-not $pipInstalled) {
    Write-Host "ERROR: Python/pip not found. Please install Python first from python.org" -ForegroundColor Red
    exit 1
}

pip install open-interpreter pandas openpyxl plotly streamlit sqlalchemy psycopg2-binary

Write-Host "`n=== Setup Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "To start:" -ForegroundColor White
Write-Host "  interpreter --model ollama/qwen3:30b-a3b" -ForegroundColor Green
Write-Host ""
Write-Host "Example tasks you can ask it:" -ForegroundColor White
Write-Host "  - Read sales.xlsx and summarize by department"
Write-Host "  - Query my database and show totals by year"
Write-Host "  - Create a Plotly dashboard from this Excel file"
