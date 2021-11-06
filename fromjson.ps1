
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

$po = $json | ConvertFrom-Json -depth 100 
$v = $po | Select-Object -ExpandProperty json | Format-List


foreach ($i in $v) {
  $i | select-object VMname
  $j
}


