# Conversion des disques VDHX vers QCOW2 en PowerShell

Ce script PowerShell permet de convertir des fichiers de disque virtuel VHDX (Hyper-V) en QCOW2 (QEMU/KVM) en utilisant l'outil `qemu-img`.

<p>
    <img src="https://img.shields.io/badge/Powershell-2CA5E0?style=for-the-badge&logo=powershell&logoColor=white" alt="version">
</p>

## Auteur
* [**Sorway**](https://github.com/Sorway)

## 🔧 Prérequis

- PowerShell 5.1+ ou PowerShell Core
- [qemu-img](https://www.qemu.org/download/) doit être installé et accessible via le `PATH`

## 📥 Installation

1. Téléchargez le fichier `vhdx-to-qcow2.ps1`
2. Placez-le dans le dossier de votre choix

## ▶️ Utilisation

```powershell
.\vhdx-to-qcow2.ps1
```

## Avertissement

Assurez-vous que l'exécution de scripts PowerShell est autorisée sur votre système. Vous pouvez vérifier cela en exécutant la commande suivante dans PowerShell:

```powershell
Get-ExecutionPolicy
```

Si la politique d'exécution est restreinte, vous devrez peut-être la modifier en exécutant la commande suivante (en tant qu'administrateur):

```powershell
Set-ExecutionPolicy RemoteSigned
```

## Licence
Ce script est distribué sous la licence MIT. Consultez le fichier LICENSE pour plus d'informations.
