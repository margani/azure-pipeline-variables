[CmdletBinding()]
param (
    [Parameter()][String]$EnvSubscriptions
)

Function Initialize-Pipeline {
    [CmdletBinding()]
    param (
        [Parameter()][String]$EnvSubscriptions
    )
    Process {
        Write-Host "EnvSubscriptions: $EnvSubscriptions"

        $EnvSubscriptions.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
        | ForEach-Object {
            $envSubscription = $_
            $keyValue = $envSubscription.Split(':', [System.StringSplitOptions]::RemoveEmptyEntries)
            if ($keyValue.Length -eq 2) {
                $envs = $keyValue[0]
                $subscription = $keyValue[1].Trim()

                $envs.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries)
                | ForEach-Object {
                    $env = $_.Trim()
                    Write-Output "##vso[task.setvariable variable=$env-subscription]$subscription"
                }
            }
        }
    }
}

Initialize-Pipeline `
    -EnvSubscriptions $EnvSubscriptions