# Use the official image as a parent image
FROM php:5.6-apache

# Set the working directory
WORKDIR /var/www/html

# Download latest formalms package 
RUN \
	curl https://netcologne.dl.sourceforge.net/project/forma/version-2.x/formalms-v2.3.0.2.zip --output formalms.zip
	
# Run the command inside your image filesystem
RUN chmod -R 777 ./formalms/
RUN docker-php-ext-configure mysqli && docker-php-ext-install mysqli
# Inform Docker that the container is listening on the specified port at runtime.
EXPOSE 80
