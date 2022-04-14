#
# Module manifest for module 'AGMPowerLib'
#
# Generated by: Anthony Vandewerdt
#
# Generated on: 10/7/2020
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'AGMPowerLib.psm1'

# Version number of this module.
ModuleVersion = '0.0.0.46'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '6155fdbc-7393-48a8-a7ac-9f5f69f8887b'

# Author of this module
Author = 'Anthony Vandewerdt'

# Company or vendor of this module
CompanyName = 'Actifio'

# Copyright statement for this module
Copyright = '(c) 2021 Actifio, Inc. All rights reserved'

################################################################################################################## 
# Description of the functionality provided by this module
Description = 'This is a community generated PowerShell Module for Actifio Global Manager (AGM).  
It provides composite functions that combine commands to various AGM API endpoints, to achieve specific outcomes. 
Examples include mounting a database, creating a new VM or running a workflow.
More information about this module can be found here:   https://github.com/Actifio/AGMPowerLib'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @('AGMPowerCLI')

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @('Export-AGMLibSLT',
'Get-AGMLibActiveImage',
'Get-AGMLibApplicationID',
'Get-AGMLibApplianceParameter',
'Get-AGMLibAppPolicies',
'Get-AGMLibContainerYAML',
'Get-AGMLibCredentialSrcID',
'New-AGMLibGCPInstance',
'Get-AGMLibHostID',
'Get-AGMLibHostList',
'Get-AGMLibImageDetails',
'Get-AGMLibImageRange',
'Get-AGMLibFollowJobStatus',
'Get-AGMLibLastPostCommand',
'Get-AGMLibLatestImage',
'Get-AGMLibPolicies',
'Get-AGMLibRunningJobs',
'Get-AGMLibSLA',
'Get-AGMLibWorkflowStatus',
'Import-AGMLibOnVault',
'Import-AGMLibSLT',
'New-AGMLibAWSVM',
'New-AGMLibAzureVM',
'New-AGMLibContainerMount',
'New-AGMLibFSMount',
'New-AGMLibGCEConversion',
'New-AGMLibGCEConversionMulti',
'New-AGMLibGCVEfailover',
'New-AGMLibGCPInstance',
'New-AGMLibGCPInstanceMultiMount',
'New-AGMLibGCPVM',
'New-AGMLibImage',
'New-AGMLibMultiMount',
'New-AGMLibMSSQLMount',
'New-AGMLibVM',
'New-AGMLibVMMultiMount',
'New-AGMLibMultiVM',
'New-AGMLibOracleMount',
'New-AGMLibMSSQLMigrate',
'New-AGMLibSystemStateToVM',
'New-AGMLibVMExisting',
'Remove-AGMLibMount',
'Restore-AGMLibMount',
'Set-AGMLibApplianceParameter',
'Set-AGMLibImage',
'Set-AGMLibMSSQLMigrate',
'Set-AGMLibSLA',
'Start-AGMLibWorkflow',
'Start-AGMLibPolicy',
'Start-AGMLibRansomwareRecovery')

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("Actifio","AGM","Sky","CDS","CDX","VDP","ActifioGO")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/Actifio/AGMPowerLib/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Actifio/AGMPowerLib'

        # A URL to an icon representing this module.
        IconUri = 'https://i.imgur.com/QAaK5Po.jpg'

        # ReleaseNotes of this module
        ReleaseNotes = '
        ## [0.0.0.46] 2022-04-15
        

        ## [0.0.0.45] 2022-04-14
        Add more debug info to Import-AGMLibOnVault and increase timeout value to handle long pauses while fetching applications

        ## [0.0.0.44] 2022-04-13
        Remove spurious information from job details when runninng New-AGMLibGCEConversion and New-AGMLibGCPInstance, corrected issue with image count when 1 image is found in New-AGMLibGCEConversion

        ## [0.0.0.43] 2022-04-13
        Teach Get-AGMLibCredentialSrcID to show clusterid.  Teach New-AGMLibVM how to specify storage performance option and New-AGMLibGCVEfailover how to use that as well
        Fixed disktype selection in  New-AGMLibGCPInstance  ALso removed option to use -credentialid, you have to use -srcid
        Add New-AGMLibGCEConversion and New-AGMLibGCEConversionMulti, Set-AGMLibApplianceParameter,  Get-AGMLibApplianceParameter

        ## [0.0.0.42] 2022-03-08
        Fixed typo

        ## [0.0.0.41] 2022-03-08
        Teach New-AGMLibGCPInstance and New-AGMLibGCPInstanceMultiMount to allow for 4 NICs per GCE instance rather than 2
        Teach New-AGMLibGCPInstance to prefer user set label to retained label and not force duplicate key error when the user defines a label key that already existed
       
        ## [0.0.0.40] 2022-01-07
        New-AGMLibGCVEfailover was ignoring power settings  
        New-AGMLibGCPVM needs to show unmanaged apps or imported images dont show up.  Guided mode now lets you choose managed, unmanaged or imported apps
        New-AGMLibVMExisting, New-AGMLibSystemStateToVM will also stop insisting source app is managed.

        ## [0.0.0.39] 2021-12-29
        Teach New-AGMLibSystemStateToVM to work with imported apps, was previously restricting to only managed apps which meant imported apps never appeared in guided menu

        ## [0.0.0.38] 2021-11-29
        Teach Import and Export AGMLibSLT about GCS Buckets.   Improve Installer
        Add New-AGMLibGCVEfailover   Added label to sample command in  New-AGMLibVM 

        ## [0.0.0.37] 2021-11-05
        Teach New-AGMLibVM to handle imported images and OnVault images without being prompted.  Switch default mount mode to nfs. Fixed bug where labels were not being assigned
        Teach Get-AGMLibSLA to know about SLT name and SLP name

        ## [0.0.0.36] 2021-09-16
        Teach New-AGMLibGCPInstance to show existing labels with -retainlabel true

        ## [0.0.0.35] 2021-09-13
        Allow silent install

        ## [0.0.0.34] 2021-09-13
        Added appcount to Get-AGMLibPolicies

        ## [0.0.0.33] 2021-09-08
        Made pre-session check more demanding to ensure we always have a good session before starting a composite function
        Improved RansomWare Recovery flow
        Taught New-AGMLibVM  will work with OnVault
        Taught New-AGMLibSystemStateToVM to handle stacked OnVault images
        Added  New-AGMVMMultiMount
        
        ## [0.0.0.32] 2021-08-27
        Added Export-AGMLibSLT, Import-AGMLibSLT, Import-AGMLibOnVault, Get-AGMLibHostList, Get-AGMLibCredentialSrcID
        Improved Start-AGMLibRansomwareRecovery

        ## [0.0.0.31] 2021-08-11
        Added Remove-AGMLibMount   Improved Start-AGMLibRansomwareRecovery

        ## [0.0.0.30] 2021-07-27
        Improved New-AGMLibMultiMount help

        ## [0.0.0.30] 2021-07-09
        Added ostype and label field to Get-AGMLibImageRange.  Also added a lot more help info.
        Give Hostname and appname when running Start-AGMLibPolicy
        New-AGMLibMultiMount was ignoring hostid, corrected this.  
        Added full guided mode for Start-AGMLibPolicy
        Teach Start-AGMLibPolicy to work with logical groups
        Taught New-AGMLibGCPInstance to handle disktype requests
        Add Set-AGMLibSLA, Get-AGMLibSLA, Set-AGMLibImage, Start-AGMLibRansomwareRecovery
        Changed Get-AGMLibPolicies and Get-AGMLibAppPolicies to use common operation terms rather than id

        ## [0.0.0.29] 2021-06-20
        Added Start-AGMLibPolicy, New-AGMLibGCPInstance, New-AGMLibMultiMount, New-AGMLibGCPInstanceMultiMount
        Allow Get-AGMLibImageRange to work with SLT Name.  
        Check for ostype in New-AGMLibSystemStateToVM as some vmware images may not have that value as reported in Issue 13
        Fix install bug on Linux OS in line 80 of Install-AGMPowerLib.ps1

        ## [0.0.0.28] 2020-11-12
        Start-AGMLibWorkflow now uses correct host timezone when specifying ENDPIT and user and host timezones are different
        New-AGMLibImage was not printing errors in monitor mode, fixed this.  Also changed the syntax from capturetype to backuptype as this is more obvious

        ## [0.0.0.27] 2020-11-11
        Improved monitor logic in reports that offer it
        Get-AGMLibApplicationID will ignore orphan apps
        Enhanced New-AGMLibImage by adding wait process and improving monitor process
        Enhanced Get-AGMLibFollowJobStatus to handle queued (readiness) and initializing job statuses.
        Enhanced Get-AGMLibRunningJobs with -q and -e options to track queued jobs and all dogs 

        ## [0.0.0.26] 2020-11-01
        Allow New-AGMLibMSSQLMount to remount a mount

        ## [0.0.0.25] 2020-10-29
        Improve the follow logic for monitor function in all functions that use it.   Improve maturity of New-AGMLibVMExisting

        ## [0.0.0.24] 2020-10-28
        Wait option was not working in all the functions that create new objects

        ## [0.0.0.23] 2020-10-17
        Added jobtag to Get-AGMLibWorkflowStatus

        ## [0.0.0.22] 2020-10-17
        AGMPowerCLI 0.0.0.17 added duration conversion, which clashed with functions already using Convert-AGMDuration to do this.   Corrected Get-AGMLibRunningJobs,Get-AGMLibFollowJobStatus.

        ## [0.0.0.21] 2020-10-09
        Revamped New-AGMLibMSSQLMigrate and Set-AGMLibMSSQLMigrate with improved menus and help.  Enhanced imagestate column in Get-AGMLibActiveImage. Added migrate user story

        ## [0.0.0.20] 2020-09-20
        Improved module description for PowerShell Gallery users'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

