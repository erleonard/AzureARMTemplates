Function Get-RedirectedUrl
{
    Param (
        [Parameter(Mandatory=$true)]
        [String]$URL
    )
 
    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()
 
    If ($response.StatusCode -eq "Found")
    {
        $response.GetResponseHeader("Location")
    }
}

$url = 'https://go.microsoft.com/fwlink/?Linkid=852155'
$codeSetupUrl = Get-RedirectedUrl -URL $url

$infPath = $PSScriptRoot + "\vscode.inf"
$vscodeSetup = "${env:Temp}\VSCodeSetup.exe"

try
{
    (New-Object System.Net.WebClient).DownloadFile($codeSetupUrl, $vscodeSetup)
}
catch
{
    Write-Error "Failed to download VSCode Setup"
}

try
{
    Start-Process -FilePath $vscodeSetup -ArgumentList "/VERYSILENT /MERGETASKS=!runcode"
}
catch
{
    Write-Error 'Failed to install VSCode'
}