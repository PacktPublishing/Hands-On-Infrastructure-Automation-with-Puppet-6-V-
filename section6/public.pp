$public = fact('publication')
$publish = fact('publication.publisher')
$github = fact('publication.github')

notify { "${public}\n${publish} - ${github}": }
