# PowerPack custom commands
Instead of remembering the error codes for retry later, the application is already installed, reboot requested and missing disk space.

```powershell
    Exit-PpRetryLater
    Exit_ApplicationAlreadyInstalled
    Exit-PpRebootRequested
    Exit-PpMissingDiskSpace
```

The functions use Exit-PpScript that comes from the loaded module PSlib.psm1.