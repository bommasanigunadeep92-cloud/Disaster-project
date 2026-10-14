# Development Launcher for VS Code & PowerShell
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Starting AI Smart Disaster Response & Emergency Platform" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Set environment paths
$env:PATH = "C:\Users\bomma\AppData\Local\Programs\nodejs;" + $env:PATH
$env:PYTHONPATH = "backend"

# 2. Start FastAPI Backend in background
Write-Host "[1/2] Starting FastAPI Backend on http://localhost:8000..." -ForegroundColor Green
$backendProcess = Start-Process python -ArgumentList "-m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload" -WorkingDirectory "$PSScriptRoot" -PassThru

Start-Sleep -Seconds 2

# 3. Start Vite Frontend
Write-Host "[2/2] Starting React Vite Frontend on http://localhost:5173..." -ForegroundColor Green
Write-Host "Opening in browser shortly..." -ForegroundColor Yellow

Set-Location "$PSScriptRoot\frontend"
npm run dev -- --host 0.0.0.0 --port 5173
