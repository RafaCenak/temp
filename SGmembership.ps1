

# =================================================================================
# I have 
# Next goal is to export VM membership to the Json 
# And then import it back to PSObject

# Input - pole VMek, ktere chci zpracovat exportovat/importovat jejich SG
$aVMnames = @('t-symapi-cz-1','t-symapi-cz-2')


# Kompletni pole/seznam objektu of VMek
$aVMs = @()

ForEach ($VMname in $aVMnames) {

  # Get all Security Groups where particullar VM is effective member.
  $SGs = Get-VM -Name $VMname | Get-NsxSecurityGroup | Sort-Object name
  # Get all Security Groups where particullar VM is statically added member (not effective).
  $SGsR3 = $SGs | Where-Object {$_.member.objectTypeName -EQ 'VirtualMachine' -and $_.member.name -eq $VMName}

  # ted delam jeden objekt pro jednu VM

  # vytvoreni pole SGs (cleni budou SG objekty s vlastnosmi jednotlivych SG)
  $aSGs = @()
  # Naplneni pole
  foreach ($SG in $SGs) {
    # Vytvoreni objektu pro SG
    $oSG = New-Object -TypeName PSObject 
    $oSG | Add-Member -Name 'name' -MemberType Noteproperty -Value $SG.name
    $oSG | Add-Member -Name 'objectId' -MemberType Noteproperty -Value $SG.objectId
    If ($SGsR3 -contains $SG) {
      # VM je staticy clen of SG
      $oSG | Add-Member -Name 'isdynamic' -MemberType Noteproperty -Value $false 
    } 
    else {
      # VM je je pouze dynamickym efektivnim clenem
      $oSG | Add-Member -Name 'isdynamic' -MemberType Noteproperty -Value $true
    }
    # Pridani do pole aSGs
    $aSGs += $oSG
  }

  # Ukol zni: vytvorit objekt a kde druhym clenem je pole aSGs (a pak ten objekt pridat do nadrazeneho pole aVMs)
  # V technice vytvareni objektu vyse jsem nevedel jake pridat clena Add-Member, ktery je typ pole. Nevedel jsem jaky ma byt membertype. Zkusil jsem tradicne Noteproperty afunguje.
  $oVM = New-Object -TypeName PSObject 
    $oVM | Add-Member -Name 'VMname' -MemberType Noteproperty -Value $VMname
    $oVM | Add-Member -Name 'SGs' -MemberType  Noteproperty -Value $aSGs
  # Pridani objektu do pole VMek
  $aVMs += $oVM  
    
 <#
  # Nejprve jsem nasel jinou techniku,jak to udelat, defakto strucnejsi a nepta se na typ clena (ktery jsem nevedel):
  # Vytvoreni objektu pro jedno VM
  $oVM = [PSCustomObject]@{
      VMname = $VMname; 
      SGs = $aSGs
  }
  #>

}


$json = $aVMs | ConvertTo-Json -Depth 100
$pso = $json | ConvertFrom-Json

# ukazalo se ze nadrazeny objekt (directory key) neni treba a root of json muze byt rovnou seznam objektu


$json
$pso

$pso | Select-Object -ExpandProperty SGs

exit


# Hrani si z konverzi json tam a zpet a modelovani ciloveho formatu
# You have real PS object of SGs 
# But you want to save that info


# Final Json goal
<#
{
  "avms": [
    {
      "VMname" : "t-symapi-cz-1",
      "SGs" : [ 
        { 
          "Name" : "SG_appT_SymfonieNV",
          "objectId" : "securitygroup-94"
          "isdynamic" : true
        },
        {
          "Name" : "SG_hap_t-hap002-cz_app",
          "objectId" : "securitygroup-223"
          "isdynamic" : true
        }
      ]
    },
    {
      "VMname" : "t-symapi-cz-2",
      "SGs" : [ 
        { 
          "Name" : "SG_appT_SymfonieNV",
          "objectId" : "securitygroup-94"
        },
        {
          "Name" : "SG_hap_t-hap002-cz_app",
          "objectId" : "securitygroup-223"
        }
      ]
    }
  ]
}

#>

$json = "
{
  `"json`": [
    {
      `"VMname`" : `"t-symapi-cz-1`",
      `"SGs`" : [ 
        { 
          `"Name`" : `"SG_appT_SymfonieNV`",
          `"objectId`" : `"securitygroup-94`"
        },
        {
          `"Name`" : `"SG_hap_t-hap002-cz_app`",
          `"objectId`" : `"securitygroup-223`"
        }
      ]
    },
    {
      `"VMname`" : `"t-symapi-cz-2`",
      `"SGs`" : [ 
        { 
          `"Name`" : `"SG_appT_SymfonieNV`",
          `"objectId`" : `"securitygroup-94`"
        },
        {
          `"Name`" : `"SG_hap_t-hap002-cz_app`",
          `"objectId`" : `"securitygroup-223`"
        }
      ]
    }
  ]
}
"

$p = $json | ConvertFrom-Json -depth 100 
$p
$p | ConvertTo-Json -Depth 100
$v = $p | Select-Object -ExpandProperty json | Format-List
$v
$v | Select-Object VMname

foreach ($i in $v) {
  $i
}

$p | select-object json



