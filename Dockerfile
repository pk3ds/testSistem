# Base image for PHP
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install PHP and system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    git \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Copy application files (excluding `node_modules` and unbuilt assets)
COPY . .

# Install PHP dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions for Laravel
RUN chmod -R 775 storage bootstrap/cache \
    && chown -R www-data:www-data /var/www

# Expose PHP-FPM port
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]
