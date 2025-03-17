
# Définir le répertoire racine du projet
$projectRoot = "C:\Users\yakasbi\Downloads\mobile-app-main\mobile-app-main"

# Aller dans le répertoire du projet
Set-Location -Path $projectRoot

# Fichier de log pour suivre les changements
$logFile = "C:\Users\yakasbi\Downloads\mobile-app-main\mobile-app-main\git_conflict_removal.log"

# Créer ou vider le fichier de log avant d'ajouter des informations
New-Item -Path $logFile -Force

# Fonction pour ajouter des logs au fichier
function Log-Message($message) {
    Add-Content -Path $logFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $message"
}

# Trouver tous les fichiers dans tous les sous-dossiers du projet, peu importe l'extension
$files = Get-ChildItem -Recurse -File

# Suivi de l'état des fichiers modifiés
$filesWithChanges = @()

# Supprimer les conflits Git dans les fichiers contenant les marqueurs de conflit
foreach ($file in $files) {
    # Lire le contenu du fichier
    $content = Get-Content $file.FullName

    # Vérifier si le fichier contient des conflits Git (les marqueurs de conflit)
    if ($content -match "<<<<<<<") {
        Write-Host "Conflit Git trouvé dans le fichier : $($file.FullName)"
        Log-Message "Conflit Git trouvé dans le fichier : $($file.FullName)"

        # Supprimer les lignes contenant les marqueurs de conflit
        $updatedContent = $content -replace "^\<\<\<\<\<\<\<.*", ""  # Supprime les lignes contenant "HEAD"
        $updatedContent = $updatedContent -replace "^\=\=\=\=\=\=\=\=.*", ""  # Supprime les lignes contenant "======="
        $updatedContent = $updatedContent -replace "^\>\>\>\>\>\>\>\>.*", ""  # Supprime les lignes contenant ">>>>>>>"

        # Vérifier si le contenu a été modifié (s'il y a eu un changement)
        if ($updatedContent -ne $content) {
            Set-Content -Path $file.FullName -Value $updatedContent
            Write-Host "Conflits Git supprimés dans le fichier : $($file.FullName)"
            Log-Message "Conflits Git supprimés dans le fichier : $($file.FullName)"
            $filesWithChanges += $file.FullName
        } else {
            Write-Host "Aucun changement nécessaire dans le fichier : $($file.FullName)"
            Log-Message "Aucun changement nécessaire dans le fichier : $($file.FullName)"
        }
    }
}

# Finalisation
if ($filesWithChanges.Count -eq 0) {
    Write-Host "Aucun conflit Git trouvé ou supprimé."
    Log-Message "Aucun conflit Git trouvé ou supprimé."
} else {
    Write-Host "Conflits Git supprimés avec succès dans les fichiers suivants :"
    $filesWithChanges | ForEach-Object { Write-Host $_ }
    Log-Message "Conflits Git supprimés avec succès dans les fichiers suivants :"
    $filesWithChanges | ForEach-Object { Log-Message $_ }
}

Write-Host "Journalisation terminée. Consultez le fichier de log pour plus de détails : $logFile"
