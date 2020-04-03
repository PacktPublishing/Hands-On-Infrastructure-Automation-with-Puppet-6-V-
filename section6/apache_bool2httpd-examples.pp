$off = apache::bool2httpd('False')
$on = apache::bool2httpd('true')
$disable = apache::bool2httpd('disable')

notify {"Apache::Bool2httpd\n'False' is '${off}'\n'true' is '${on}'\n'disable'
is '${disable}'": }
