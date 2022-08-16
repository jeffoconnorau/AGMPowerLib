# Copyright 2022 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


Function New-AGMLibGCEMountExisting ([string]$imageid,
[string]$srcid,
[string]$projectid,
[string]$region,
[string]$zone,
[string]$instanceid,
[string]$disktype) 
{
    <#
    .SYNOPSIS
    Mounts a GCE Instance backup to an existing GCE Instance

    .EXAMPLE
    New-AGMLibGCEMountExisting -srcid 5230 -projectid "backupproject-356800" -region "australia-southeast1" -zone "australia-southeast1-b" -instanceid 3259136228063997846 -imageid 81107 -disktype "pd-ssd"

    To learn srcid use:  Get-AGMLibCredentialSrcID
    To learn instanceid use:  Get-AGMHost -filtervalue vmtype=GCP -sort hostname:asc | select hostname,uniquename
    To learn imageid if hostname is called centos, use this:
    Get-AGMImage -filtervalue "apptype=GCPInstance&jobclass=snapshot&hostname=centos" | select appname,id,consistencydate
    
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

    if (!($imageid)) { Get-AGMErrorMessage -messagetoprint "Parameter -imageid is mandatory"}
    if (!($srcid)) { Get-AGMErrorMessage -messagetoprint "Parameter -srcid is mandatory"}
    if (!($instanceid)) { Get-AGMErrorMessage -messagetoprint "Parameter -instanceid is mandatory"}
    
    $hostgrab = Get-AGMHost -filtervalue uniquename=$instanceid -limit 1 
    if ($hostgrab.count -ne 1)
    {
        Get-AGMErrorMessage -messagetoprint "Could not find host with instance ID $instanceid using:  get-agmhost -filtervalue uniquename=$instanceid"
        return
    }
    if (!($zone)) { $zone = $hostgrab.zone}
    if (!($region)) { $region = $zone -replace ".{2}$"}
    if (!($projectid)) { $projectid = $hostgrab.cloudcredential.projectid}

    if (!($projectid)) { Get-AGMErrorMessage -messagetoprint "Parameter -projectid is mandatory"}
    if (!($region)) { Get-AGMErrorMessage -messagetoprint "Parameter -region is mandatory"}
    if (!($zone)) { Get-AGMErrorMessage -messagetoprint "Parameter -zone is mandatory"}



    if ($disktype)
    {
        if (($disktype -ne "pd-balanced") -and ($disktype -ne "pd-extreme") -and ($disktype -ne "pd-ssd") -and ($disktype -ne "pd-standard"))
        {
            Get-AGMErrorMessage -messagetoprint "The Disk type requested using -disktype is not valid.   It needs to be one of pd-balanced, pd-extreme, pd-ssd or pd-standard"
            return
        }
    }

    $recoverygrab = Get-AGMAPIData -endpoint /backup/$imageid/mount -extrarequests "&formtype=existingmount"
    if ($recoverygrab.err_message)
    {
        $recoverygrab
        return
    }
    $volumelist = ($recoverygrab.fields | where-object { $_.name -eq "volumeselection" })
    if (!($volumelist))
    {
        Get-AGMErrorMessage -messagetoprint "Failed to get volume information about image ID $imageid"
        return
    }
    if ($disktype)
    {
        foreach ($row in ($volumelist.rows.disktype)) {
        if ($row.selected -eq "True")
        {
            $row.selected = ""
        }
        }
        foreach ($row in ($volumelist.rows.disktype)) {
        if ($row.name -eq $disktype)
        {
            $row | Add-Member -MemberType NoteProperty -Name selected -Value "true" -Force
        }
        }
    }
    $diskjson = $volumelist | ConvertTo-json -depth 10 -compress

    $json = '{"cloudvmoptions":{"@type":"cloudVmMountRest","name":"Existing Mount","fields":[{"displayName":"Note:","name":"message","helpId":"","type":"textmessage","readonly":true,"currentValue":"","modified":false},{"displayName":"CLOUD CREDENTIALS NAME","name":"cloudcredential","helpId":"","type":"selection","description":"","required":true,"modified":false,"dynamic":true,"choices":[{"displayName":"name","name":"'
    $json = $json +$srcid
    $json = $json +'","selected":true}],"_getchoices":"getCloudCredentials#cloudcredentiallist,image","_dependent":["project","region","zone","instance"],"_default":"1234"},{"displayName":"PROJECT NAME","name":"project","helpId":"access-data/mount-snapshot-images-of-cloud-instances","type":"selection","description":"","required":true,"modified":false,"dynamic":true,"choices":[{"displayName":"project","name":"'
    $json = $json +$projectid
    $json = $json +'","selected":true}],"_getchoices":"getAllProjects#handle,cloudcredential","_dependent":["region","zone","instance"],"_default":"default"},{"displayName":"REGION","name":"region","helpId":"","type":"selection","description":"","optiongroup":true,"required":true,"modified":false,"dynamic":true,"choices":[{"displayName":"Asia Pacific","name":"asia","choices":[{"displayName":"name","name":"'
    $json = $json +$region
    $json = $json +'","selected":true}]}],"_getchoices":"getRegions#handle,cloudcredential","_dependent":["zone","instance"],"_default":"name"},{"displayName":"ZONE","name":"zone","helpId":"","type":"selection","description":"","required":true,"modified":false,"dynamic":true,"choices":[{"displayName":"name","name":"'
    $json = $json +$zone
    $json = $json +'","selected":true}],"_getchoices":"getZonesPerRegion#handle,cloudcredential,region","_dependent":["instance"],"_default":"name"},{"displayName":"INSTANCE NAME","name":"instance","helpId":"","type":"dropdown","description":"","required":true,"modified":false,"dynamic":false,"choices":[{"displayName":"name","name":"'
    $json = $json +$instanceid
    $json = $json +'","selected":true}],"_getchoices":"getInstances#handle,cloudcredential,zone","_default":"1234"},'
    $json = $json +$diskjson
    $json = $json +'],"version":1,"cloudtype":"GCP","formtype":"existingmount"}}'

    New-AGMMount -imageid $imageid -jsonbody $json
}