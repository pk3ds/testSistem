<?php

namespace App\Providers;

use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Vite;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Ensure Laravel generates HTTPS URLs in production
        if ($this->app->environment('production')) {
            URL::forceScheme('https');
        }

        // Set Vite prefetch concurrency
        Vite::prefetch(concurrency: 3);
    }
}
