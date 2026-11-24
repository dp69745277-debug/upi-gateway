FROM php:8.3-cli-alpine

# Install necessary extensions for Laravel & UPI QR generation
RUN apk add --no-cache \
    nodejs \
    npm \
    git \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

# Install dependencies and build assets
RUN composer install --no-dev --optimize-autoloader --no-interaction
RUN npm install && npm run build

# Give full permissions for installer wizard to write .env and storage
RUN chmod -R 777 /app

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
