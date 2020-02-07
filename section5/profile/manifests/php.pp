class profile::php {
  class { 'php':
    extensions => {
      mysql => {},
      mysqli => {},
    }
  }
  include apache::mod::php
  
}
