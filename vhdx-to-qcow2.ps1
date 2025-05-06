# Demander les chemins à l'utilisateur
$sourceRoot = Read-Host "Entrez le chemin du dossier source contenant les fichiers .vhdx"
$destinationRoot = Read-Host "Entrez le chemin du dossier de destination pour les fichiers .qcow2"
$qemuImgPath = Read-Host "Entrez le chemin vers l'exécutable qemu-img.exe (par ex: C:\Outils\qemu-img.exe)"

# Vérifier l'existence de qemu-img
if (!(Test-Path $qemuImgPath)) {
    Write-Error "qemu-img.exe introuvable à l'emplacement spécifié. Script interrompu."
    exit
}

# Créer le dossier de destination s'il n'existe pas
if (!(Test-Path $destinationRoot)) {
    New-Item -ItemType Directory -Path $destinationRoot | Out-Null
    Write-Host "Dossier de destination créé : $destinationRoot"
}

# Rechercher tous les fichiers .vhdx récursivement
$vhdxFiles = Get-ChildItem -Path $sourceRoot -Filter *.vhdx -Recurse

if ($vhdxFiles.Count -eq 0) {
    Write-Warning "Aucun fichier .vhdx trouvé dans le dossier source."
    exit
}

foreach ($vhdxFile in $vhdxFiles) {
    # Trouver le dossier parent qui est la VM
    $relativePath = $vhdxFile.FullName.Substring($sourceRoot.Length).TrimStart('\')

    # Extraire le nom de la VM
    $parts = $relativePath.Split('\')
    if ($parts.Count -ge 2 -and $parts[1] -eq 'Virtual Hard Disks') {
        $vmName = $parts[0]
    } else {
        $vmName = $parts[0]
    }

    # Créer un sous-dossier pour chaque VM si tu veux organiser les fichiers
    $vmDestinationDir = Join-Path $destinationRoot $vmName
    if (!(Test-Path $vmDestinationDir)) {
        New-Item -ItemType Directory -Path $vmDestinationDir | Out-Null
    }

    # Nom du fichier de sortie
    $destinationFile = Join-Path $vmDestinationDir "$($vhdxFile.BaseName).qcow2"

    Write-Host "Conversion de $($vhdxFile.FullName) vers $destinationFile"

    # Exécuter la conversion
    & $qemuImgPath convert -f vhdx -O qcow2 "`"$($vhdxFile.FullName)`"" "`"$destinationFile`""
}

Write-Host "Toutes les conversions sont terminées."
