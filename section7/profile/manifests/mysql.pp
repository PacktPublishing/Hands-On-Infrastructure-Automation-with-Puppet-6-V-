class profile::mysql (
  String[1] $username = 'username',
  String[1] $password = 'password',
  String[1] $hostname = 'localhost',
  String[1] $database = 'database',
) {

  class { '::mysql::server':
    root_password           => 'verygoodpassword',
    remove_default_accounts => true,
    restart                 => true,
  }
  mysql::db { 'cmsdb':
    user     => $username,
    password => $password,
    host     => $hostname,
    grant    => ['SELECT', 'CREATE', 'INSERT', 'UPDATE'],
}

}
