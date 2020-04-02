$off = apache2::bool2httpd('False')
$on = apache2::bool2httpd('true')
$disable = apache2::bool2httpd('disable')

notify {"Apache2::Bool2httpd\n'False' is '${off}'\n'true' is '${on}'\n'disable'
is '${disable}'": }
