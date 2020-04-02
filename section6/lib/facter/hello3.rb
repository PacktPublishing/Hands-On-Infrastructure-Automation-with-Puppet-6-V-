hello = Facter.value(:hello)

Facter.add(:hello2) do
	confine :osfamily => 'Debian'
	setcode do "Good-bye #{hello}" end
end
