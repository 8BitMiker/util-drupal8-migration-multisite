#!/usr/bin/ruby -i.bak

# surpress warning nonsense
# warnings = $VERBOSE
# $VERBOSE = nil

DATA.each { |folder| folder.chomp!; ARGV.push(folder) }

ARGF.each(nil) do |php|

	puts ARGF.filename

	if ARGF.filename =~ %r{/var/www/drupal/8/sites/sites.php}  
			
			php.gsub!(%r{(?i)(\$sites = array\([^\)]+\);)}) do  
			
				%Q{/*\n#{$1}\n*/}
				
			end
			
		else
			
			php.gsub!(%r{(?i)(\$settings\['trusted_host_patterns'\][^\)]+\);)}) do  
			
				%Q{/*\n#{$1}\n*/}
			
			end
	
	end
	
	puts php

end

=begin
 
	/var/www/drupal/8/sites/sites.php
	
	$sites = array(
		'patients.dentistry.utoronto.ca' => 'patient',
		'iits.dentistry.utoronto.ca' => 'iits',
		'cde.dentistry.utoronto.ca' => 'cde',
		# 'sale.dentistry.utoronto.ca' => 'sale',
		'forms.dentistry.utoronto.ca' => 'forms',
		'www.dentistry.utoronto.ca' => 'default',
	 );

=end

=begin

	/var/www/drupal/8/sites/cde/*.php

	$settings['trusted_host_patterns'] = array(
	'^beta-www.dentistry.utoronto.ca$',
	'^beta-iits.dentistry.utoronto.ca$',
	'^beta-cde.dentistry.utoronto.ca$',
	'^beta-patients.dentistry.utoronto.ca$',
	'^forms.dentistry.utoronto.ca$',
	'^www.dentistry.utoronto.ca$',
	'^iits.dentistry.utoronto.ca$',
	'^cde.dentistry.utoronto.ca$',
	'^patients.dentistry.utoronto.ca$',
	'^cde-utoronto.ca$',
	'^www.cde-utoronto.ca$',
);	

=end

__END__
/var/www/drupal/8/sites/sites.php
/var/www/drupal/8/sites/cde/settings.php
/var/www/drupal/8/sites/default/settings.php
/var/www/drupal/8/sites/iits/settings.php
/var/www/drupal/8/sites/patient/settings.php
/var/www/drupal/8/sites/forms/settings.php
