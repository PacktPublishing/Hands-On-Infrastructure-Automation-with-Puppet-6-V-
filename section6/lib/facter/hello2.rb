Facter.add(:hello) do
	setcode do 'Good-bye' end
end
Facter.add(:hello) do
	confine :kernel => 'Linux'
	confine :osfamily => 'Debian'
	setcode do 'Hello, World!' end
end
