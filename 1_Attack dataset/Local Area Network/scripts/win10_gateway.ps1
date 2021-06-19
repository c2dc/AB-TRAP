# Get the interface number for the Private IP defined at Vagrantfile 
$interface = Get-NetIPAddress | Where-Object {$_.IPAddress -match "10.10.10.13"} | select -ExpandProperty InterfaceIndex

# Remove the IP default IP route for interface dedicated to the Private IP defined at Vagrantfile
Remove-NetRoute -InterfaceIndex $interface -NextHop "0.0.0.0" -Confirm:$false | out-null

# Create the route for interface dedicated to the Private IP defined at Vagrantfile
New-NetRoute -InterfaceIndex $interface -NextHop "10.10.10.254" -DestinationPrefix "0.0.0.0/0" -confirm:$false | out-null

# Disable firewall from Windows
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
