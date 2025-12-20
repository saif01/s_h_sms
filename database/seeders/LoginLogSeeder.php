<?php

namespace Database\Seeders;

use App\Models\LoginLog;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class LoginLogSeeder extends Seeder
{
    /**
     * Seed login log entries for demonstration purposes
     */
    public function run(): void
    {
        $users = User::all();

        if ($users->isEmpty()) {
            $this->command->error('No users found. Please run AdminUserSeeder first.');
            return;
        }

        $this->command->info('Seeding login log entries...');

        $userAgents = [
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15',
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        ];

        $ipAddresses = [
            '192.168.1.100',
            '192.168.1.101',
            '10.0.0.50',
            '172.16.0.25',
            '203.0.113.45',
            '198.51.100.12',
        ];

        $failureReasons = [
            'invalid_credentials',
            'account_locked',
            'password_expired',
            'too_many_attempts',
        ];

        // Create successful login logs for each user
        foreach ($users as $user) {
            // Create 5-10 successful login logs per user
            $successCount = rand(5, 10);
            
            for ($i = 0; $i < $successCount; $i++) {
                $loginDate = Carbon::now()->subDays(rand(0, 90))->subHours(rand(0, 23))->subMinutes(rand(0, 59));
                
                LoginLog::create([
                    'user_id' => $user->id,
                    'email' => $user->email,
                    'ip_address' => $ipAddresses[array_rand($ipAddresses)],
                    'user_agent' => $userAgents[array_rand($userAgents)],
                    'status' => 'success',
                    'failure_reason' => null,
                    'logged_in_at' => $loginDate,
                    'created_at' => $loginDate,
                    'updated_at' => $loginDate,
                ]);
            }

            // Create 1-3 failed login attempts per user
            $failureCount = rand(1, 3);
            
            for ($i = 0; $i < $failureCount; $i++) {
                $loginDate = Carbon::now()->subDays(rand(0, 90))->subHours(rand(0, 23))->subMinutes(rand(0, 59));
                
                LoginLog::create([
                    'user_id' => null, // Failed attempts may not have user_id
                    'email' => $user->email,
                    'ip_address' => $ipAddresses[array_rand($ipAddresses)],
                    'user_agent' => $userAgents[array_rand($userAgents)],
                    'status' => 'failed',
                    'failure_reason' => $failureReasons[array_rand($failureReasons)],
                    'logged_in_at' => null,
                    'created_at' => $loginDate,
                    'updated_at' => $loginDate,
                ]);
            }
        }

        // Create some failed login attempts with non-existent emails
        $fakeEmails = [
            'hacker@example.com',
            'test@test.com',
            'admin@admin.com',
            'user@user.com',
        ];

        foreach ($fakeEmails as $email) {
            $failureCount = rand(2, 5);
            
            for ($i = 0; $i < $failureCount; $i++) {
                $loginDate = Carbon::now()->subDays(rand(0, 90))->subHours(rand(0, 23))->subMinutes(rand(0, 59));
                
                LoginLog::create([
                    'user_id' => null,
                    'email' => $email,
                    'ip_address' => $ipAddresses[array_rand($ipAddresses)],
                    'user_agent' => $userAgents[array_rand($userAgents)],
                    'status' => 'failed',
                    'failure_reason' => 'invalid_credentials',
                    'logged_in_at' => null,
                    'created_at' => $loginDate,
                    'updated_at' => $loginDate,
                ]);
            }
        }

        $this->command->info('Login log entries seeded successfully!');
    }
}

