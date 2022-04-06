Function Get-AGMLibApplianceParameter([string]$applianceid,[string]$param,[switch]$allparams,[switch]$slots) 
{
    <#
    .SYNOPSIS
    Fetches output of parameters from appliances

    .EXAMPLE
    Get-AGMLibApplianceParameter -applianceid  1234 -param maxsnapslots
    Displays all active images (mounts)

    .DESCRIPTION
    A function to get parameters

    #>

    if ( (!($AGMSESSIONID)) -or (!($AGMIP)) )
    {
        Get-AGMErrorMessage -messagetoprint "Not logged in or session expired. Please login using Connect-AGM"
        return
    }
    $sessiontest = Get-AGMVersion
    if ($sessiontest.errormessage)
    {
        Get-AGMErrorMessage -messagetoprint "AGM session has expired. Please login again using Connect-AGM"
        return
    }
    
    # first we need an applianceid
    if (!($applianceid))
    {
        $applianceidgrab = Get-AGMAppliance
        if ($applianceidgrab.id.count -eq 0)
        {
            Get-AGMErrorMessage -messagetoprint "Failed to find any appliances with Get-AGMAppliance"
            return
        }
        if ($applianceidgrab.id.count -eq 1)
        {
            $applianceid = $applianceidgrab.id
        }
        if ($applianceidgrab.id.count -gt 1)
        {
            write-host ""
            write-host "Appliance Selection"
            write-host ""
            $i = 1
            foreach ($appliance in $appliancegrab.name)
            { 
                Write-Host -Object "$i`: $appliance"
                $i++
            }
            While ($true) 
            {
                Write-host ""
                $listmax = $appliancegrab.id.count
                [int]$appselection = Read-Host "Please select an appliance (1-$listmax)"
                if ($appselection -lt 1 -or $appselection -gt $listmax)
                {
                    Write-Host -Object "Invalid selection. Please enter a number in range [1-$($listmax)]"
                } 
                else
                {
                    break
                }
            }
            $applianceid =  $appliancegrab.name[($appselection - 1)]
        }
    } 
    if ((!($param)) -and (!($allparams)) -and (!($slots)))
    {
        $allparams = $true
    }
    if ($allparams -eq $true)
    {
        Get-AGMAPIApplianceInfo -applianceid $applianceid -command "getparameter" 
    }
    if ($param)
    {
        Get-AGMAPIApplianceInfo -applianceid $applianceid -command "getparameter" -arguments "param=$param"
    }
    if ($slots)
    {
        $paramgrab = Get-AGMAPIApplianceInfo -applianceid $applianceid -command "getparameter" 
        if ($paramgrab.maxsnapslots)
        {
            $paramarray = @()
            $paramarray += [pscustomobject]@{
                maxsnapslots = $paramgrab.maxsnapslots
                reservedsnapslots = $paramgrab.reservedsnapslots
                snapshotonrampslots = $paramgrab.snapshotonrampslots
                maxstreamsnapslots = $paramgrab.maxstreamsnapslots
                reservedstreamsnapslots = $paramgrab.reservedstreamsnapslots
                streamsnaponrampslots = $paramgrab.streamsnaponrampslots
                maxvaultslots = $paramgrab.maxvaultslots
                reservedvaultslots = $paramgrab.reservedvaultslots
                onvaultonrampslots = $paramgrab.onvaultonrampslots
                maxlogtovaultslots = $paramgrab.maxlogtovaultslots
                reservedlogtovaultslots = $paramgrab.reservedlogtovaultslots
            }
        }
       $paramarray 
    }
}