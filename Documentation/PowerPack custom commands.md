# PowerPack custom commands
Instead of remembering the error codes for retry later, the application is already installed, reboot requested and missing disk space.

```powershell
    Exit_RetryLater
    Exit_ApplicationAlreadyInstalled
    Exit_RebootRequested
    Exit_MissingDiskSpace
```

The functions use Exit-PSScript that comes from the loaded module PSlib.psm1.