Configuration DuoInstall
{
    param 
    ( 
         [Parameter(Mandatory)]
         [String]$IKEY,
 
         [Parameter(Mandatory)]
         [String]$SKEY,
 
        [Parameter(Mandatory)]
        [String] $Host
     ) 
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node "localhost"
    {
        Script DownloadApp {
            GetScript  = 
            {
                @{
                    GetScript  = $GetScript
                    SetScript  = $SetScript
                    TestScript = $TestScript
                    Result     = ('True' -in (Test-Path C:\downloads\duo-win-login-latest.exe))
                }
            }

            SetScript  = 
            {
                New-Item c:\downloads -ItemType Directory -Force
                $source = "https://dl.duosecurity.com/duo-win-login-latest.exe"
                $destination = "C:\downloads\duo-win-login-latest.exe"
                $webclient = New-Object System.Net.WebClient
                $webclient.DownloadFile("$source", "$destination")
                unblock-file $destination
            }

            TestScript = { Test-Path C:\downloads\duo-win-login-latest.exe }
        }

        Package InstallApp {
            Ensure = "Present"
            DependsOn = "[Script]DownloadApp"
            Name = "Duo Two-Factor Authentication"
            Path = "C:\downloads\duo-win-login-latest.exe"
            ProductID = 'AF828DB1-476C-4EDD-BFF1-44456828764F'
            Arguments =  '/S /V" /qn IKEY="$IKEY" SKEY="$SKEY" HOST="$Host" AUTOPUSH="#1" FAILOPEN="#0" RDPONLY="#0""'

        }
    }
}

DuoInstall