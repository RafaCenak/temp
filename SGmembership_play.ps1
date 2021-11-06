
$VMname = 't-symapi-cz-2'
Get-VM -Name $VMname | Get-NetworkAdapter |  Select @{N="VM";E={$_.parent.name}}, Name, Type, NetworkName



Get-VM -Name $VMname | Get-NsxSecurityGroup | Select-Object *
Get-VM -Name $VMname | Get-NsxSecurityGroup | Select-Object objectID,Name,Description | Format-Table

Get-VM -Name $VMname | Get-NsxSecurityGroup | Select-Object -ExpandProperty member | Select-Object Where-Object objectTypeName -eq VirtualMachine

Get-VM -Name $VMname | Get-NsxSecurityGroup |  Select-Object @{N="VM";E={$_.Name}}
Get-VM -Name $VMname | Get-NsxSecurityGroup |  Select-Object -ExpandProperty member | Where-Object objectTypeName -eq VirtualMachine | Select-Object name, @{N="SG";E={$_.name}} 
Get-VM -Name $VMname | Get-NsxSecurityGroup |  Where-Object -Property Member.name -Contains $VMname

Get-VM -Name $VMname | Get-NsxSecurityGroup |  Select-Object 

Get-NsxSecurityGroup -VirtualMachine (Get-VM -Name $VMname) | Select-Object -ExpandProperty member
Get-NsxSecurityGroup -VirtualMachine (Get-VM -Name $VMname) 

Get-NsxSecurityGroup -VirtualMachine (Get-VM -Name $VMname) -scopeId 
  

$sgs = Get-VM -Name $VMname | Get-NsxSecurityGroup


 $object1 | Add-Member -Name 'SGs' -MemberType 

 