#Colourize cmdlets, add prediction source based on history   
Install-Module -Name PSReadLine -Scope CurrentUser
Set-PSReadLineOption -colors @{
    Operator           = 'Cyan'
    Parameter          = 'Cyan'
    String             = 'White'
  } `
-PredictionSource History

$prodSubscriptionStartswith = "prd" #example replace with what your production subscriptions start with

# modifed prompt funtion to collapse path to last subfolder, added Az context colour highlighting to show red highlights for production subscriptions
function prompt {
    $p = Split-Path -leaf -path (Get-Location)
    $az = (Get-AzContext).Subscription.Name 
    
    if ($az -like ($prodSubscriptionStartswith +"*") )
    {
        $az = "[" + $az  + "]"
        (write-host $az -BackgroundColor Red -NoNewline)  + " ..\$p> "
    }
    else {
        $az = "[" + $az  + "]"
        (write-host $az -BackgroundColor DarkGreen -NoNewline)  + " ..\$p> "
    }
  }
  
