$EdgeName = 'czbr-vE-fw01-dmz'
$Edge = Get-NsxEdge -Name $EdgeName
$EIFIndex = 2
$EIF = Get-NsxEdgeInterface -Edge $Edge -Index $EIFIndex

$ESIFname = 'SIF_411_80.65.183.1-24'

Get-NsxEdgeSubInterface -Interface $EIF -Name $ESIFname