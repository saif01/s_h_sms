<?php
/**
 * Quick script to check database configuration
 * Run this via web browser: http://your-site/check_db_config.php
 * Or via CLI: php check_db_config.php
 */

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

echo "<pre>";
echo "=== Database Configuration Check ===\n\n";

echo "1. .env file DB_CONNECTION: ";
if (file_exists('.env')) {
    $envContent = file_get_contents('.env');
    if (preg_match('/^DB_CONNECTION=(.*)$/m', $envContent, $matches)) {
        echo trim($matches[1]) . "\n";
    } else {
        echo "Not found\n";
    }
} else {
    echo ".env file not found\n";
}

echo "\n2. Config database.default: " . config('database.default') . "\n";

echo "\n3. Actual DB connection driver: ";
try {
    $driver = DB::connection()->getDriverName();
    echo $driver . "\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}

echo "\n4. Database connection config:\n";
$config = config('database.connections.' . config('database.default'));
echo "   Host: " . ($config['host'] ?? 'N/A') . "\n";
echo "   Port: " . ($config['port'] ?? 'N/A') . "\n";
echo "   Database: " . ($config['database'] ?? 'N/A') . "\n";
echo "   Username: " . ($config['username'] ?? 'N/A') . "\n";

echo "\n5. Testing connection: ";
try {
    DB::connection()->getPdo();
    echo "SUCCESS - Connected to " . DB::connection()->getDriverName() . "\n";
} catch (Exception $e) {
    echo "FAILED: " . $e->getMessage() . "\n";
}

echo "\n6. Testing User model query: ";
try {
    $user = App\Models\User::where('email', 'test@example.com')->first();
    echo "SUCCESS - Query executed (no results expected, but query worked)\n";
} catch (Exception $e) {
    echo "FAILED: " . $e->getMessage() . "\n";
    echo "Error details: " . get_class($e) . "\n";
}

echo "\n=== End of Check ===\n";
echo "</pre>";

